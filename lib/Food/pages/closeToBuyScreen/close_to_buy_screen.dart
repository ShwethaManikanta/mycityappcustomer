import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mycityapp/Food/CommonWidgets/common_styles.dart';
import 'package:mycityapp/Food/CommonWidgets/screen_width_and_height.dart';
import 'package:mycityapp/Food/Models/PopularCurations.dart';
import 'package:mycityapp/Food/Models/UserModel.dart';
import 'package:mycityapp/Food/Services/ApiServices.dart';
import 'package:mycityapp/Food/Services/popularcuration_list_api_provider.dart';
import 'package:mycityapp/Food/Services/profile_view_api_provider.dart';
import 'package:mycityapp/Food/pages/app_colors.dart';
import 'package:mycityapp/Food/pages/changelocation.dart';
import 'package:mycityapp/Food/pages/closeToBuyScreen/widgets/spotlight_best_top_food_item.dart';
import 'package:mycityapp/Food/pages/popularCurationsView.dart';
import 'package:mycityapp/Food/pages/ui_helper.dart';
import 'package:mycityapp/backend/service/firebase_auth_service.dart';
import '../../CommonWidgets/utils.dart';
import '../../Services/FCMchannel/local_notification_service.dart';

import '../../Services/takeaway_api_service.dart';
import '../homePage/Home.dart';
import '../utils/loaction_shared_preference.dart';
import 'widgets/offer_banner_view.dart';
import 'widgets/in_the_spotlight_view.dart';
import 'package:provider/provider.dart';

class CloseToBuyScreen extends StatefulWidget {
  @override
  _CloseToBuyScreenState createState() => _CloseToBuyScreenState();
}

class _CloseToBuyScreenState extends State<CloseToBuyScreen> {
  List<CategoryList>? popularCurations = [];
  // List<TakeAwayModel>? foods = [];

  @override
  void initState() {
    super.initState();
    // FirebaseMessaging.onMessage.listen((RemoteMessage remoteMessage) {
    //   RemoteNotification? notification = remoteMessage.notification;
    //   AndroidNotification? android = remoteMessage.notification?.android;
    //   if (notification != null && android != null) {
    //     flutterLocalNotificationsPlugin.show(
    //         notification.hashCode,
    //         notification.title,
    //         notification.body,
    //         NotificationDetails(
    //             android: AndroidNotificationDetails(channel.id, channel.name,
    //                 channelDescription: channel.description,
    //                 color: Colors.blue,
    //                 playSound: true,
    //                 icon: '@mipmap/ic_luncher.jpg')));
    //   }
    // });

    // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    //   RemoteNotification? notification = message.notification;
    //   AndroidNotification? android = message.notification?.android;
    //   if (notification != null && android != null) {
    //     showDialog(
    //         context: context,
    //         builder: (_) {
    //           return AlertDialog(
    //             title: Text(
    //               notification.title!,
    //               style: CommonStyles.black12thin(),
    //             ),
    //             content: SingleChildScrollView(
    //               child: Column(
    //                 children: [
    //                   Text(
    //                     notification.body!,
    //                     style: CommonStyles.black12(),
    //                   )
    //                 ],
    //               ),
    //             ),
    //           );
    //         });
    //   }
    // });
    if (context.read<TakeAwayAPIProvider>().takeAwayResponseModel == null) {
      context.read<TakeAwayAPIProvider>().getTakeAways();
    }
    apiService.getTopOffers(
        SharedPreference.latitudeValue, SharedPreference.longitudeValue);
    if (context.read<ProfileViewApiProvider>().profileViewResponseModel ==
        null) {
      context.read<ProfileViewApiProvider>().getProfileView();
    }
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        // final routeFromMessage = message.data['route'];
        // Navigator.of(context).pushNamed(routeFromMessage);

        LocalNotificationServices.display(message);
      }
    });

    //When the app is in foreground
    FirebaseMessaging.onMessage.listen((message) {
      // final routeFromMessage = message.data['route'];
      // if (routeFromMessage != null || routeFromMessage != "") {
      //   Navigator.of(context).pushNamed(routeFromMessage);

      print("message" + message.notification!.body!);
      LocalNotificationServices.display(message);
    });

    //When the app is in background but opened and user taps
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      // final routeFromMessage = message.data['route'];
      // if (routeFromMessage != null || routeFromMessage != "") {
      //   Navigator.of(context).pushNamed(routeFromMessage);
      // }
      // print("message" + message.notification!.body!);

      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => HomeBottomNavigationScreen()));
      LocalNotificationServices.display(message);
    });

    //  setState(() {
    // apiServices.getBanners();
    // apiServices.getBottomBanners();
    // apiServices.getOnboardingBanners();

    // apiServices.getPopularDishes(
    //     SharedPreference.latitudeValue, SharedPreference.longitudeValue);
    // apiServices.popluarcurationlist().then((value) {
    //   setState(() {
    //     popularCurations = ApiServices.popularCurations!.categoryList;
    //   });
    // });
    // apiServices.getTakeAway(
    //     SharedPreference.latitudeValue, SharedPreference.longitudeValue, "1");
    // apiServices
    //     .getTakeAway(SharedPreference.latitudeValue,
    //         SharedPreference.longitudeValue, "")
    //     .then((value) {
    //   setState(() {
    //     foods = ApiServices.takeAways;
    //   });
    // });
    // });
    // showNotification();
  }

  // void showNotification() async {
  //   await flutterLocalNotificationsPlugin.show(
  //       0,
  //       "Testing notification",
  //       "How ya doin ?",
  //       NotificationDetails(
  //           android: AndroidNotificationDetails(channel.id, channel.name,
  //               channelDescription: channel.description,
  //               importance: Importance.high,
  //               color: Colors.blue,
  //               playSound: true)));
  // }

  @override
  Widget build(BuildContext context) {
    // List<TopOfferModel>? topOffers = ApiServices.topOffers;
    return WillPopScope(
      onWillPop: showExitPopup,

      // () async {
      //   Navigator.of(context).pop(true);
      //   return true;
      //   // showExitPopup
      // }, //call function on back button press
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: SafeArea(child: buildAppBar()),
        ),
        // AppBar(
        //   flexibleSpace: FlexibleSpaceBar(
        //     background: ,
        //   ),
        // ),
        body: buildBody(),
      ),
    );
  }

  Widget buildAppBar() {
    final firebaseAuthService = Provider.of<FirebaseAuthService>(context);
    final profileViewAPIProvider = Provider.of<ProfileViewApiProvider>(context);

    if (firebaseAuthService.isAnonymusSignIn()) {
      return Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Icon(
                Icons.location_on,
                color: Colors.amber[900],
                size: 35,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UIHelper.verticalSpaceSmall(),
                SizedBox(
                  width: deviceWidth(context) * 0.82,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SizedBox(
                      child: Text(
                        SharedPreference.currentAddress.toString(),
                        maxLines: 1,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 2),
                      ),
                      //  Text(
                      //   SharedPreference.currentAddress.toString(),
                      //   maxLines: 1,
                      //   style: TextStyle(
                      //       color: Colors.black,
                      //       fontSize: 13,
                      //       fontWeight: FontWeight.w600,
                      //       letterSpacing: 2),
                      // ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: addressPage,
                        // () {
                        //   // Navigator.push(
                        //   //   context,
                        //   //   MaterialPageRoute(builder: (context) => MapSample()),
                        //   // );
                        // },
                        child: Text(
                          "Change my location",
                          maxLines: 2,
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      UIHelper.horizontalSpaceLarge(),
                      InkWell(
                          onTap: () async {
                            var result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MapSample(
                                    latitude: SharedPreference.latitudeValue,
                                    longitude: SharedPreference.longitudeValue,
                                    isProceed: true),
                              ),
                            );
                            if (result == "set") {
                              Navigator.of(context).pop();
                            }
                          },
                          child: Text(
                            "Add address",
                            style: TextStyle(fontSize: 13, color: Colors.blue),
                          )),
                    ],
                  ),
                ),
                UIHelper.verticalSpaceSmall(),
              ],
            ),
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Icon(
                Icons.location_on,
                color: Colors.amber[900],
                size: 35,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UIHelper.verticalSpaceSmall(),
                SizedBox(
                  width: deviceWidth(context) * 0.82,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SizedBox(
                      child: profileViewAPIProvider.ifLoading
                          ? Center(
                              child: SizedBox(
                                  width: 50,
                                  height: 10,
                                  child: LinearProgressIndicator(
                                    backgroundColor: Colors.black54,
                                    color: Colors.blue[400],
                                  )),
                            )
                          : SharedPreference.currentAddress == null
                              ? Text(
                                  "Address",
                                  maxLines: 1,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 2),
                                )
                              : Text(
                                  SharedPreference.currentAddress,
                                  maxLines: 1,
                                  style: CommonStyles.black12(),
                                ),
                      // [int.parse(
                      //                 profileViewAPIProvider
                      //                     .profileViewResponseModel!
                      //                     .userDetails!
                      //                     .selectedAddress!)]

                      //  Text(

                      //   SharedPreference.currentAddress.toString(),
                      //   maxLines: 1,
                      //   style: TextStyle(
                      //       color: Colors.black,
                      //       fontSize: 13,
                      //       fontWeight: FontWeight.w600,
                      //       letterSpacing: 2),
                      // ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // InkWell(
                      //   onTap: addressPage,
                      //   // () {
                      //   //   // Navigator.push(
                      //   //   //   context,
                      //   //   //   MaterialPageRoute(builder: (context) => MapSample()),
                      //   //   // );
                      //   // },
                      //   child: Text(
                      //     "Change my location",
                      //     maxLines: 2,
                      //     style: TextStyle(
                      //         color: Colors.red,
                      //         fontSize: 12,
                      //         fontWeight: FontWeight.bold),
                      //   ),
                      // ),
                      // UIHelper.horizontalSpaceLarge(),
                      InkWell(
                          onTap: () async {
                            var result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MapSample(
                                    latitude: SharedPreference.latitudeValue,
                                    longitude: SharedPreference.longitudeValue,
                                    isProceed: true),
                              ),
                            );
                            if (result == "set") {
                              Navigator.of(context).pop();
                            }
                          },
                          child: Text(
                            "Change address",
                            style: CommonStyles.black12thin(),
                          )),
                    ],
                  ),
                ),
                UIHelper.verticalSpaceSmall(),
              ],
            ),
          ],
        ),
      );
    }

    // return AppBar(
    //   automaticallyImplyLeading: false,
    //   elevation: 0,
    //   backgroundColor: Colors.white,
    //   title: ,
    //   actions: [
    //     TextButton.icon(
    //       onPressed: () {
    //         Navigator.push(
    //           context,
    //           MaterialPageRoute(
    //             builder: (context) => OffersScreen(),
    //           ),
    //         );
    //       },
    //       icon: Icon(
    //         Icons.local_offer_rounded,
    //       ),
    //       label: Text(
    //         "Offers",
    //       ),
    //       style: TextButton.styleFrom(
    //         primary: Colors.orange[900],
    //       ),
    //     ),
    //   ],
    // );
  }

  String getSelectedAddressText(
      ProfileViewResponseModel profileViewResponseModel) {
    String string = "NA";
    profileViewResponseModel.getAllAddress!.forEach((element) {
      if (element.addressTypeId ==
          profileViewResponseModel.userDetails!.selectedAddress!) {
        string = element.address!;
      }
    });
    return string;
  }

  addressPage() {
    return showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        context: context,
        builder: (builder) {
          return Container(
              height: MediaQuery.of(context).size.height,
              decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(20.0),
                      topRight: const Radius.circular(20.0))),
              child: Padding(
                padding: const EdgeInsets.only(top: 50.0, left: 20, right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Select a location",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    UIHelper.verticalSpaceMedium(),
                    placesAutoCompleteTextField(context),
                    UIHelper.verticalSpaceMedium(),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(
                        Icons.my_location,
                        color: swiggyOrange,
                      ),
                      title: Text(
                        "Use current location",
                        style: TextStyle(
                            color: swiggyOrange,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.12,
                          child: Text(
                            SharedPreference.currentAddress,
                          ),
                        ),
                      ),
                      trailing: IconButton(
                        onPressed: () async {
                          var result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MapSample(
                                latitude: SharedPreference.latitudeValue,
                                longitude: SharedPreference.longitudeValue,
                                isProceed: false,
                              ),
                            ),
                          );
                          if (result == "set") {
                            Navigator.of(context).pop();
                          }
                        },
                        icon: Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 15,
                          color: swiggyOrange,
                        ),
                      ),
                    ),
                    UIHelper.verticalSpaceMedium(),
                    Text(
                      "Saved Addresses".toUpperCase(),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    FutureBuilder<UserApi>(
                        future: apiService.fetchAlbum(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return snapshot.data!.get_all_address != null
                                ? Column(
                                    children: snapshot.data!.get_all_address!
                                        .map((e) {
                                      return InkWell(
                                        onTap: () async {
                                          SharedPreference.getLocationData(
                                              double.parse(
                                                e.lat!,
                                              ),
                                              double.parse(
                                                e.long!,
                                              ));
                                          SharedPreferences sharedPreference =
                                              await SharedPreferences
                                                  .getInstance();
                                          setState(() {
                                            sharedPreference.setDouble(
                                                "LATITUDE",
                                                double.parse(
                                                  e.lat!,
                                                ));
                                            sharedPreference
                                                .getDouble("LATITUDE");
                                            sharedPreference.setDouble(
                                                "LONGITUDE",
                                                double.parse(
                                                  e.long!,
                                                ));
                                            sharedPreference
                                                .getDouble("LONGITUDE");
                                          });
                                          Navigator.pushNamed(context, 'Home');
                                        },
                                        child: Column(
                                          children: [
                                            ListTile(
                                              contentPadding: EdgeInsets.zero,
                                              leading:
                                                  Icon(Icons.location_city),
                                              title: Text(
                                                addressName(e.address_type_id)
                                                    .toString(),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 15),
                                              ),
                                              subtitle: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(e.address!),
                                                  Text(e.land_mark!),
                                                  Text(e.floor!),
                                                  Text(e.reach!),
                                                ],
                                              ),
                                              // trailing: ,
                                            ),
                                            Divider(),
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                  )
                                : Container();
                          }
                          return Container();
                        })
                  ],
                ),
              ));
        });
  }

  addressName(dynamic typeId) {
    switch (typeId) {
      case "1":
        return "Home";
      case "2":
        return "Work";
      default:
        return "Other";
    }
  }

  Widget buildBody() {
    return SizedBox(
      height: deviceHeight(context),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        controller: ScrollController(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // OnGoingOrderSegment(),
            OfferBannerView(),
            SizedBox(
              height: 10,
            ),
            // PopularBrandsView(),
            // FoodGroceriesAvailabilityView(),
            // TopOffersViews(),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         // crossAxisAlignment: CrossAxisAlignment.stretch,
            //         children: <Widget>[
            //           Text(
            //             'An offer for Everyone',
            //             style: Theme.of(context)
            //                 .textTheme
            //                 .subtitle2!
            //                 .copyWith(fontSize: 18.0),
            //           ),
            //           // UIHelper.verticalSpaceExtraSmall(),
            //           // Text(
            //           //   'Delectable treats to double the excitement',
            //           //   style: Theme.of(context)
            //           //       .textTheme
            //           //       .bodyText1!
            //           //       .copyWith(color: Colors.grey),
            //           // ),
            //         ],
            //       ),
            //       UIHelper.verticalSpaceSmall(),
            //       TopOfferBannerView(),
            //     ],
            //   ),
            // ),
            // popularCurations != null
            //     ? RestaurantVerticalListView(
            //         title: 'Popular Curations',
            //         restaurants: popularCurations,
            //       )
            //     : Container(),
            // // Beverages(),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Text(
            //     "All Restaurants Nearby",
            //     style: Theme.of(context)
            //         .textTheme
            //         .headline4!
            //         .copyWith(fontSize: 20.0),
            //   ),
            // ),
            // takeAwayRestaturantList(),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            //   child: ElevatedButton(
            //     onPressed: () {
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => AllRestaurantsScreen(),
            //         ),
            //       );
            //     },
            //     child: Text("See All Restaurants"),
            //     style: ElevatedButton.styleFrom(
            //         minimumSize: Size(
            //           double.infinity,
            //           50,
            //         ),
            //         primary: darkOrange),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RestaurantViewModel(
                key: UniqueKey(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MeatBannerOfferView(
                key: UniqueKey(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: BakeryBannerOfferView(
                key: UniqueKey(),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: FoodCourtOfferView(
            //     key: UniqueKey(),
            //   ),
            //)
            // InTheSpotlightView(),

            // BottomBannerView(),
            // LiveForFoodView(),
          ],
        ),
      ),
    );
  }

  Future<bool> showExitPopup() async {
    return true;
    // showDialog(
    //   //show confirm dialogue
    //   context: context,
    //   builder: (context) => AlertDialog(
    //     titleTextStyle: TextStyle(
    //         color: Colors.red, fontWeight: FontWeight.bold, fontSize: 15),
    //     title: Text('EXIT APP'),
    //     content: Text('Exit this app?'),
    //     actions: [
    //       GestureDetector(
    //         onTap: () {
    //           Navigator.of(context).pop(false);
    //         },
    //         child: Padding(
    //           padding: const EdgeInsets.all(8.0),
    //           child: Text(
    //             'No',
    //             style: TextStyle(
    //                 color: Colors.blue,
    //                 fontWeight: FontWeight.bold,
    //                 fontSize: 15),
    //           ),
    //         ),
    //       ),
    //       UIHelper.horizontalSpaceSmall(),
    //       GestureDetector(
    //         onTap: () {
    //           Navigator.of(context).pop(true);
    //         },
    //         child: Padding(
    //           padding: const EdgeInsets.all(8.0),
    //           child: Text(
    //             'Yes',
    //             style: TextStyle(
    //                 color: Colors.red,
    //                 fontWeight: FontWeight.bold,
    //                 fontSize: 15),
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // ); //if showDialouge had returned null, then return false
  }

  Widget takeAwayRestaturantList() {
    final takeAwayAPIProvider = Provider.of<TakeAwayAPIProvider>(context);

    return takeAwayAPIProvider.ifLoading
        ? Center(
            child: SizedBox(
              height: 25,
              width: 25,
              child: CircularProgressIndicator(
                strokeWidth: 1,
              ),
            ),
          )
        : (takeAwayAPIProvider.takeAwayResponseModel != null &&
                takeAwayAPIProvider.takeAwayResponseModel!.newArrival != null)
            ? ListView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: takeAwayAPIProvider
                    .takeAwayResponseModel!.newArrival!.length,
                itemBuilder: (context, index) => Column(
                  children: <Widget>[
                    SpotlightBestTopFoodItem(
                      foods: takeAwayAPIProvider
                          .takeAwayResponseModel!.newArrival![index],
                      baseImagreUrl: takeAwayAPIProvider
                          .takeAwayResponseModel!.restaurantBaseurl!,
                    ),
                  ],
                ),
              )
            : Center(
                child: Text("Service not available in your location"),
              );
  }
}

placesAutoCompleteTextField(BuildContext context) {
  TextEditingController controller = TextEditingController();
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 0),
    child: GooglePlaceAutoCompleteTextField(
        textEditingController: controller,
        googleAPIKey: "AIzaSyCOkDpX71Oy1mximbSXxpWibnUlpVax7II",
        inputDecoration: InputDecoration(
          hintText: "Search your area,street name..",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          prefixIcon: Icon(
            Icons.search,
            color: swiggyOrange,
          ),
          // suffixIcon: IconButton(
          //   icon: Icon(
          //     Icons.clear,
          //     color: Colors.grey,
          //   ),
          //   onPressed: () {
          //     controller.clear();
          //   },
          // )
        ),
        debounceTime: 800,
        countries: ["in"],
        isLatLngRequired: true,
        getPlaceDetailWithLatLng: (Prediction prediction) async {
          var result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MapSample(
                latitude: double.tryParse(prediction.lat!),
                longitude: double.tryParse(prediction.lng!),
                isProceed: false,
              ),
            ),
          );
          if (result == "set") {
            Navigator.of(context).pop();
          }
        },
        itmClick: (Prediction prediction) {
          controller.text = prediction.description!;
          print("controller.text +${controller.text}");

          controller.selection = TextSelection.fromPosition(
              TextPosition(offset: prediction.description!.length));
          print("controller.selection +${controller.selection}");
        }
        // default 600 ms ,
        ),
  );
}

class LiveForFoodView extends StatelessWidget {
  const LiveForFoodView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      padding: const EdgeInsets.all(15.0),
      height: 400.0,
      color: Colors.grey[200],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'LIVE\nFOR\nFOOD',
            style: Theme.of(context).textTheme.headline4!.copyWith(
                  color: Colors.grey[400],
                  fontSize: 80.0,
                  letterSpacing: 0.2,
                  height: 0.8,
                ),
          ),
          Text(
            '  MADE BY FOOD LOVERS',
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(color: Colors.grey),
          ),
          Text(
            '  FOODIE',
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

class RestaurantVerticalListView extends StatefulWidget {
  final String title;
  final List<CategoryList>? restaurants;
  final bool isAllRestaurantNearby;

  const RestaurantVerticalListView({
    Key? key,
    required this.title,
    required this.restaurants,
    this.isAllRestaurantNearby = false,
  })  : assert(title != ''),
        super(key: key);

  @override
  State<RestaurantVerticalListView> createState() =>
      _RestaurantVerticalListViewState();
}

class _RestaurantVerticalListViewState
    extends State<RestaurantVerticalListView> {
  @override
  void initState() {
    super.initState();

    if (context.read<PopularCurationAPIProvider>().popularCurationResponse ==
        null) {
      context.read<PopularCurationAPIProvider>().getPopularCuration();
    }
  }

  @override
  Widget build(BuildContext context) {
    final popularCurationAPIProvider =
        Provider.of<PopularCurationAPIProvider>(context);
    return popularCurationAPIProvider.ifLoading
        ? Center(
            child: Utils.showLoading(),
          )
        : popularCurationAPIProvider.error
            ? Utils.showErrorMessage(popularCurationAPIProvider.errorMessage)
            : popularCurationAPIProvider.popularCurationResponse == null ||
                    popularCurationAPIProvider
                            .popularCurationResponse!.status ==
                        "0"
                ? Utils.showErrorMessage(popularCurationAPIProvider
                    .popularCurationResponse!.message!)
                : Container(
                    margin: const EdgeInsets.all(5.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.title,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4!
                                  .copyWith(fontSize: 20.0),
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                            //   child: InkWell(
                            //     onTap: () {
                            //       Navigator.push(
                            //         context,
                            //         MaterialPageRoute(
                            //           builder: (context) => AllRestaurantsScreen(),
                            //         ),
                            //       );
                            //     },
                            //     child: Row(
                            //       children: [
                            //         Text(
                            //           "See All",
                            //           style: Theme.of(context).textTheme.headline4.copyWith(fontSize: 15.0, color: swiggyOrange),
                            //         ),
                            //         Icon(Icons.arrow_forward_ios_sharp, size: 15, color: swiggyOrange)
                            //       ],
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                        widget.isAllRestaurantNearby
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  UIHelper.verticalSpaceExtraSmall(),
                                  Text(
                                    'Discover unique tastes near you',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(fontSize: 14.0),
                                  ),
                                ],
                              )
                            : SizedBox(),
                        UIHelper.verticalSpaceMedium(),
                        Container(
                          height: 130,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            physics: ScrollPhysics(),
                            itemCount: popularCurationAPIProvider
                                .popularCurationResponse!.categoryList!.length,
                            // widget.restaurants!.length,
                            itemBuilder: (context, index) => FoodListItemView(
                              restaurant: popularCurationAPIProvider
                                  .popularCurationResponse!
                                  .categoryList![index],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
  }
}

class FoodListItemView extends StatelessWidget {
  final CategoryList restaurant;

  const FoodListItemView({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PopularCurationsView(
              categoryId: restaurant.id,
              title: restaurant.name,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(10.0),
        child: Row(
          children: <Widget>[
            Column(
              children: [
                Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 2.0,
                      )
                    ],
                  ),
                  child: restaurant.image != ""
                      ? Image.network(
                          "https://foodieworlds.in/foodie/" + restaurant.image!,
                          height: 80.0,
                          width: 80.0,
                          fit: BoxFit.cover,
                        )
                      : Image.network(
                          "https://salautomotive.in/wp-content/uploads/2017/01/no-image-available.jpg",
                          height: 80.0,
                          width: 80.0,
                          fit: BoxFit.cover,
                        ),
                ),
                UIHelper.verticalSpaceSmall(),
                Text(
                  restaurant.name!,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2!
                      .copyWith(fontSize: 12.0),
                ),
              ],
            ),
            UIHelper.horizontalSpaceMedium(),
            // Column(
            //   mainAxisAlignment: MainAxisAlignment.start,
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: <Widget>[
            //     Text(
            //       restaurant.restaurantName,
            //       style: Theme.of(context).textTheme.subtitle2.copyWith(fontSize: 18.0),
            //     ),
            //     Text(restaurant.category,
            //         style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.grey[800], fontSize: 13.5)),
            //     UIHelper.verticalSpaceExtraSmall(),
            //     Text(
            //       "",
            //       style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.red[900], fontSize: 13.0),
            //     ),
            //     UIHelper.verticalSpaceSmall(),
            //     Row(
            //       children: <Widget>[
            //         Icon(
            //           Icons.star,
            //           size: 14.0,
            //           color: Colors.grey[600],
            //         ),
            //         Text(restaurant.rating)
            //       ],
            //     )
            //   ],
            // )
          ],
        ),
      ),
    );
  }

  Widget locationUpdate() {
    return Column(
      children: [],
    );
  }
}
