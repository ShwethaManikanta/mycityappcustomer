import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mycityapp/Cab/Services/api_services.dart';
import 'package:mycityapp/Food/CommonWidgets/common_styles.dart';
import 'package:mycityapp/Food/CommonWidgets/screen_width_and_height.dart';
import 'package:mycityapp/Food/CommonWidgets/utils.dart';
import 'package:mycityapp/Food/Models/OrderHistory.dart';
import 'package:mycityapp/Food/Services/ApiServices.dart';
import 'package:mycityapp/Food/Services/beverage_list_api.dart';
import 'package:mycityapp/Food/Services/cart_api_provider.dart';
import 'package:mycityapp/Food/Services/login_api_provider.dart';
import 'package:mycityapp/Food/Services/order_history_api_provider.dart';
import 'package:mycityapp/Food/Services/popular_restaurant_api_provider.dart';
import 'package:mycityapp/Food/Services/popularcuration_list_api_provider.dart';
import 'package:mycityapp/Food/Services/profile_update_api_provider.dart';
import 'package:mycityapp/Food/Services/profile_view_api_provider.dart';
import 'package:mycityapp/Food/Services/restaurant_details_api_provider.dart';
import 'package:mycityapp/Food/Services/takeaway_api_service.dart';
import 'package:mycityapp/Food/pages/accountScreen/ongoing_order_details.dart';
import 'package:mycityapp/Food/pages/dotted_seperator_view.dart';
import 'package:mycityapp/Food/pages/utils/loaction_shared_preference.dart';
import 'package:provider/provider.dart';
import 'package:mycityapp/backend/service/firebase_auth_service.dart';
import '../../Models/OngoingOrderModel.dart';
import '../../Services/banner_api_provider.dart';
import '../../Services/ongoing_order_api.dart';
import '../app_colors.dart';
import '../ui_helper.dart';
import 'package:url_launcher/url_launcher.dart';

class AccountScreen extends StatefulWidget {
  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  void initState() {
    super.initState();
    // apiServices.orderHistory();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.popAndPushNamed(context, 'Home');
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
              physics: BouncingScrollPhysics(), child: buildBody()),
        ),
      ),
    );
  }

  buildBody() {
    final firebaseAuthService = Provider.of<FirebaseAuthService>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _AppBar(),
        _PastOrderListView(),
        // Card(
        //   color: Colors.redAccent[700],
        //   margin: EdgeInsets.all(10),
        //   child: InkWell(
        //     onTap: () async {
        //       // final sharedPreferenceProvider =
        //       //     Provider.of<SharedPreferencesProvider>(context,
        //       //         listen: false);

        //       showLogoutDialog();

        //       // Navigator.of(context).pop();
        //       // await sharedPreferenceProvider.setIsUserLoggedIn(
        //       //     userLoginStatus: false);

        //       // ApiServices.sharedPreferences.remove("user").then((value) {
        //       // ApiServices.userId = null;
        //       // Navigator.pushNamedAndRemoveUntil(
        //       //     context, "Login", (route) => false);
        //       // });
        //     },
        //     child: Row(
        //       children: <Widget>[
        //         Container(
        //           alignment: Alignment.centerLeft,
        //           padding: const EdgeInsets.only(left: 15.0),
        //           height: 50.0,
        //           child: Text(
        //             'LOGOUT',
        //             style: TextStyle(color: Colors.white),
        //           ),
        //         ),
        //         Spacer(),
        //         Icon(
        //           Icons.power_settings_new,
        //           color: Colors.white,
        //         ),
        //         SizedBox(
        //           width: 15,
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
      ],
    );
  }

  Future<dynamic> showLogoutDialog() {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.power_settings_new,
                    color: Colors.red,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text("Do you want to LogOut ?",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () async {
                          final firebaseAuthService =
                              Provider.of<FirebaseAuthService>(context,
                                  listen: false);

                          context.read<OngoingOrderAPIProvider>().initialize();
                          context
                              .read<MeatBannerListAPIProvider>()
                              .initialize();

                          context.read<LoginAPIProvider>().initialize();
                          context.read<CartListAPIProvider>().initialize();
                          context
                              .read<PopularCurationAPIProvider>()
                              .initialize();
                          context.read<TakeAwayAPIProvider>().initialize();
                          context.read<BannerListAPIProvider>().initialize();
                          context.read<BottomBannerAPIProvider>().initialize();
                          context
                              .read<RestaurantOfferBannerAPIProvider>()
                              .initialize();

                          context
                              .read<FrontPageBannerAPIProvider>()
                              .initialize();
                          context
                              .read<RestaurantDetailsAPIProvider>()
                              .initialize();
                          context
                              .read<PopularRestaurantAPIProvider>()
                              .initialize();
                          context.read<PopularMeatAPIProvider>().initialize();
                          context.read<BeverageListAPIProvider>().initialize();
                          context
                              .read<VerifyUserLoginAPIProvider>()
                              .initialize();
                          context.read<OrderHistoryAPIProvider>().initialize();
                          context.read<ProfileViewApiProvider>().initialize();
                          context
                              .read<BakeryBannerListAPIProvider>()
                              .initialize();
                          context
                              .read<EditUserProfileAPIProvider>()
                              .initialize();

                          await firebaseAuthService.signOut(
                              googleSignIn:
                                  await firebaseAuthService.isGoogleLoggedIn());
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 25, vertical: 10),
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(6)),
                          child: Text("Yes",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500)),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 25, vertical: 10),
                          decoration: BoxDecoration(
                              color: Colors.deepOrange,
                              borderRadius: BorderRadius.circular(6)),
                          child: Text("No",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500)),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}

class _AppBar extends StatefulWidget {
  @override
  State<_AppBar> createState() => _AppBarState();
}

class _AppBarState extends State<_AppBar> {
  final _formKey = GlobalKey<FormBuilderState>();
  final _addressformKey = GlobalKey<FormBuilderState>();
  @override
  void initState() {
    if (context.read<ProfileViewApiProvider>().profileViewResponseModel ==
        null) {
      context.read<ProfileViewApiProvider>().getProfileView();
    }
    super.initState();
  }

  List<Color> colorizeColors = [
    Colors.purple,
    Colors.blue,
    Colors.yellow,
    Colors.red,
  ];

  @override
  Widget build(BuildContext context) {
    // final List<UserModel> user = ApiServices.userdata;

    final firebaseAuthService = Provider.of<FirebaseAuthService>(context);
    // return FutureBuilder<UserApi>(
    //     future: apiServices.fetchAlbum(),
    //     builder: (context, snapshot) {

    final profileViewAPIProvider = Provider.of<ProfileViewApiProvider>(context);
    if (profileViewAPIProvider.ifLoading) {
      return Container();
    } else if (profileViewAPIProvider.error) {
      return Utils.showErrorMessage(profileViewAPIProvider.errorMessage);
    } else if (profileViewAPIProvider.profileViewResponseModel!.status == "0") {
      return Utils.showErrorMessage(
          profileViewAPIProvider.profileViewResponseModel!.message!);
    } else {
      final user = profileViewAPIProvider.profileViewResponseModel;
      return firebaseAuthService.isAnonymusSignIn()
          ? SizedBox(
              height: 300,
              width: deviceWidth(context),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "You are signed in anonymously! No Profile to Show!",
                    style: CommonStyles.black13(),
                    maxLines: 2,
                  ),
                ],
              ),
            )
          : Container(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Column(
                  //   children: user.map((e) => Text(e.customer_name)).toList(),
                  // ),
                  // user!.userDetails!.customerName == null ||
                  //         user.userDetails!.customerName == ""
                  // ? Align(
                  //     alignment: Alignment.center,
                  //     child: MaterialButton(
                  //       onPressed: () {
                  //         // showModalBottomSheet(
                  //         //     context: context,
                  //         //     isScrollControlled: true,
                  //         //     builder: (context) {
                  //         //       return Padding(
                  //         //         padding: EdgeInsets.only(
                  //         //             bottom: MediaQuery.of(context)
                  //         //                 .viewInsets
                  //         //                 .bottom),
                  //         //         child: Column(
                  //         //           mainAxisSize: MainAxisSize.min,
                  //         //           children: <Widget>[
                  //         //             ListTile(
                  //         //               leading: IconButton(
                  //         //                 icon: Icon(
                  //         //                   Icons.clear,
                  //         //                   size: 20,
                  //         //                   color: darkOrange,
                  //         //                 ),
                  //         //                 onPressed: () {
                  //         //                   Navigator.pop(context);
                  //         //                 },
                  //         //               ),
                  //         //               title: Text(
                  //         //                 'EDIT PROFILE',
                  //         //                 style: Theme.of(context)
                  //         //                     .textTheme
                  //         //                     .headline6!
                  //         //                     .copyWith(
                  //         //                         fontSize: 17.0,
                  //         //                         color: Colors.blueAccent),
                  //         //               ),
                  //         //               trailing: IconButton(
                  //         //                 icon: Icon(
                  //         //                   Icons.check,
                  //         //                   size: 20,
                  //         //                   color: darkOrange,
                  //         //                 ),
                  //         //                 onPressed: () async {
                  //         //                   _formKey.currentState!.save();
                  //         //                   if (_formKey.currentState!
                  //         //                       .validate()) {
                  //         //                     Map param = {};
                  //         //                     param.addAll({
                  //         //                       "user_id":
                  //         //                           ApiServices.userId,
                  //         //                     });
                  //         //                     param.addAll(_formKey
                  //         //                         .currentState!.value);
                  //         //                     await apiServices
                  //         //                         .editProfile(param)
                  //         //                         .then((value) =>
                  //         //                             Navigator.pop(
                  //         //                                 context));
                  //         //                   } else {
                  //         //                     print("validation failed");
                  //         //                   }
                  //         //                 },
                  //         //               ),
                  //         //             ),
                  //         //             FormBuilder(
                  //         //               key: _formKey,
                  //         //               child: Padding(
                  //         //                 padding:
                  //         //                     const EdgeInsets.all(8.0),
                  //         //                 child: Column(
                  //         //                   children: [
                  //         //                     Padding(
                  //         //                       padding:
                  //         //                           const EdgeInsets.all(
                  //         //                               5.0),
                  //         //                       child: FormBuilderTextField(
                  //         //                         name: 'user_name',
                  //         //                         keyboardType:
                  //         //                             TextInputType.name,
                  //         //                         initialValue: user
                  //         //                             .userDetails!
                  //         //                             .customerName,
                  //         //                         decoration:
                  //         //                             InputDecoration(
                  //         //                           border:
                  //         //                               OutlineInputBorder(),
                  //         //                           labelText: "User name",
                  //         //                         ),
                  //         //                       ),
                  //         //                     ),
                  //         //                     Padding(
                  //         //                       padding:
                  //         //                           const EdgeInsets.all(
                  //         //                               5.0),
                  //         //                       child: FormBuilderTextField(
                  //         //                         name: 'email',
                  //         //                         initialValue: user
                  //         //                             .userDetails!.email,
                  //         //                         keyboardType:
                  //         //                             TextInputType
                  //         //                                 .emailAddress,
                  //         //                         decoration:
                  //         //                             InputDecoration(
                  //         //                           border:
                  //         //                               OutlineInputBorder(),
                  //         //                           labelText: "Email",
                  //         //                         ),
                  //         //                       ),
                  //         //                     ),
                  //         //                     Padding(
                  //         //                       padding:
                  //         //                           const EdgeInsets.all(
                  //         //                               5.0),
                  //         //                       child: FormBuilderTextField(
                  //         //                         keyboardType:
                  //         //                             TextInputType.number,
                  //         //                         name: 'mobile',
                  //         //                         validator: (value) {
                  //         //                           if (value == null ||
                  //         //                               value.length <
                  //         //                                   10) {}
                  //         //                         },
                  //         //                         initialValue: user
                  //         //                                     .userDetails!
                  //         //                                     .mobile!
                  //         //                                     .length !=
                  //         //                                 10
                  //         //                             ? (user.userDetails!
                  //         //                                     .mobile)!
                  //         //                                 .substring(
                  //         //                                     4,
                  //         //                                     user
                  //         //                                         .userDetails!
                  //         //                                         .mobile!
                  //         //                                         .length)
                  //         //                             : user.userDetails!
                  //         //                                 .mobile!,
                  //         //                         decoration:
                  //         //                             InputDecoration(
                  //         //                           border:
                  //         //                               OutlineInputBorder(),
                  //         //                           labelText: "Mobile",
                  //         //                         ),
                  //         //                       ),
                  //         //                     ),
                  //         //                   ],
                  //         //                 ),
                  //         //               ),
                  //         //             )
                  //         //           ],
                  //         //         ),
                  //         //       );
                  //         //     });
                  //       },
                  //       color: Colors.brown,
                  //       minWidth: deviceWidth(context) * 0.9,
                  //       height: 34,
                  //       highlightColor: Colors.blue.withOpacity(0.6),
                  //       splashColor: Colors.blue.withOpacity(0.6),
                  //       visualDensity: VisualDensity.compact,
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(4),
                  //         side: BorderSide(
                  //           color: Colors.blue,
                  //           width: 0.4,
                  //         ),
                  //       ),
                  //       child: Text(
                  //         "Add Details",
                  //         style: CommonStyles.whiteText12BoldW500(),
                  //       ),
                  //     ),
                  //   )
                  // :
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      // user!.userDetails!.customerName == null ||
                      //         user.userDetails!.customerName == ""
                      //     ? Text(
                      //         'No name',
                      //         style: Theme.of(context).textTheme.headline6!.copyWith(
                      //             fontWeight: FontWeight.bold, fontSize: 18.0),
                      //       )
                      //     :

                      //  user!.userDetails!.customerName!.isNotEmpty ||
                      user!.userDetails!.customerName != null
                          ? AnimatedTextKit(
                              animatedTexts: [
                                ColorizeAnimatedText(
                                    '${user.userDetails!.customerName}',
                                    textStyle: CommonStyles.black57S18(),
                                    textAlign: TextAlign.right,
                                    colors: colorizeColors)
                              ],
                            )
                          : AnimatedTextKit(
                              animatedTexts: [
                                ColorizeAnimatedText('My City',
                                    textStyle: CommonStyles.black57S18(),
                                    textAlign: TextAlign.right,
                                    colors: colorizeColors)
                              ],
                            ),

                      InkWell(
                        child: Text(
                          'EDIT',
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(fontSize: 17.0, color: darkOrange),
                        ),
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (context) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                      bottom: MediaQuery.of(context)
                                          .viewInsets
                                          .bottom),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      ListTile(
                                        leading: IconButton(
                                          icon: Icon(
                                            Icons.clear,
                                            size: 20,
                                            color: darkOrange,
                                          ),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                        title: Text(
                                          'EDIT PROFILE',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6!
                                              .copyWith(
                                                  fontSize: 17.0,
                                                  color: Colors.blueAccent),
                                        ),
                                        trailing: IconButton(
                                          icon: Icon(
                                            Icons.check,
                                            size: 20,
                                            color: darkOrange,
                                          ),
                                          onPressed: () async {
                                            _formKey.currentState!.save();
                                            if (_formKey.currentState!
                                                .validate()) {
                                              Map param = {};
                                              param.addAll({
                                                "user_id": ApiServices.userId,
                                              });
                                              param.addAll(
                                                  _formKey.currentState!.value);
                                              await apiService
                                                  .editProfile(param)
                                                  .then((value) =>
                                                      Navigator.pop(context));
                                            } else {
                                              print("validation failed");
                                            }
                                          },
                                        ),
                                      ),
                                      FormBuilder(
                                        key: _formKey,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: FormBuilderTextField(
                                                  name: 'user_name',
                                                  initialValue: user
                                                      .userDetails!
                                                      .customerName,
                                                  decoration: InputDecoration(
                                                    border:
                                                        OutlineInputBorder(),
                                                    labelText: "User name",
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: FormBuilderTextField(
                                                  name: 'email',
                                                  initialValue:
                                                      user.userDetails!.email,
                                                  decoration: InputDecoration(
                                                    border:
                                                        OutlineInputBorder(),
                                                    labelText: "Email",
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: FormBuilderTextField(
                                                  name: 'mobile',
                                                  initialValue:
                                                      user.userDetails!.mobile,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  maxLength: 10,
                                                  decoration: InputDecoration(
                                                    counterText: "",
                                                    border:
                                                        OutlineInputBorder(),
                                                    labelText: "Mobile",
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              });
                        },
                      )
                    ],
                  ),
                  UIHelper.verticalSpaceSmall(),
                  Row(
                    children: <Widget>[
                      Text('${user.userDetails!.mobile}',
                          style: CommonStyles.black12thin()),
                      // UIHelper.horizontalSpaceSmall(),
                      // ClipOval(
                      //   child: Container(
                      //     height: 3.0,
                      //     width: 3.0,
                      //     color: Colors.grey[700],
                      //   ),
                      // ),
                    ],
                  ),
                  UIHelper.verticalSpaceSmall(),

                  Row(
                    children: [
                      Text('${user.userDetails!.email}',
                          style: CommonStyles.black12thin()),
                    ],
                  ),
                  UIHelper.verticalSpaceSmall(),
                  // user.userDetails!.address == null ||
                  //         user.userDetails!.address == ""
                  //     ? Align(
                  //         alignment: Alignment.center,
                  //         child: MaterialButton(
                  //           onPressed: () {
                  //             showModalBottomSheet(
                  //                 context: context,
                  //                 isScrollControlled: true,
                  //                 builder: (context) {
                  //                   return Padding(
                  //                     padding: EdgeInsets.only(
                  //                         bottom: MediaQuery.of(context)
                  //                             .viewInsets
                  //                             .bottom),
                  //                     child: Column(
                  //                       mainAxisSize: MainAxisSize.min,
                  //                       children: <Widget>[
                  //                         ListTile(
                  //                           leading: IconButton(
                  //                             icon: Icon(
                  //                               Icons.clear,
                  //                               size: 20,
                  //                               color: darkOrange,
                  //                             ),
                  //                             onPressed: () {
                  //                               Navigator.pop(context);
                  //                             },
                  //                           ),
                  //                           title: Text(
                  //                             'EDIT ADDRESS',
                  //                             style: Theme.of(context)
                  //                                 .textTheme
                  //                                 .headline6!
                  //                                 .copyWith(
                  //                                     fontSize: 17.0,
                  //                                     color: Colors.blueAccent),
                  //                           ),
                  //                           trailing: IconButton(
                  //                             icon: Icon(
                  //                               Icons.check,
                  //                               size: 20,
                  //                               color: darkOrange,
                  //                             ),
                  //                             onPressed: () {
                  //                               _addressformKey.currentState!
                  //                                   .save();
                  //                               Map param = {};
                  //                               param.addAll({
                  //                                 "user_id": ApiServices.userId
                  //                               });
                  //                               param.addAll(_addressformKey
                  //                                   .currentState!.value);
                  //                               if (_addressformKey
                  //                                   .currentState!
                  //                                   .validate()) {
                  //                                 setState(() async {
                  //                                   await apiServices
                  //                                       .editAddress(
                  //                                         param,
                  //                                       )
                  //                                       .then((value) =>
                  //                                           Navigator.pop(
                  //                                               context));
                  //                                 });
                  //                               } else {
                  //                                 print("validation failed");
                  //                               }
                  //                             },
                  //                           ),
                  //                         ),
                  //                         FormBuilder(
                  //                           key: _addressformKey,
                  //                           child: Padding(
                  //                             padding:
                  //                                 const EdgeInsets.all(8.0),
                  //                             child: Column(
                  //                               children: [
                  //                                 Padding(
                  //                                   padding:
                  //                                       const EdgeInsets.all(
                  //                                           5.0),
                  //                                   child: FormBuilderTextField(
                  //                                     name: 'address',
                  //                                     initialValue: user
                  //                                         .userDetails!.address,
                  //                                     decoration:
                  //                                         InputDecoration(
                  //                                       border:
                  //                                           OutlineInputBorder(),
                  //                                       labelText: "Address",
                  //                                     ),
                  //                                   ),
                  //                                 ),
                  //                               ],
                  //                             ),
                  //                           ),
                  //                         )
                  //                       ],
                  //                     ),
                  //                   );
                  //                 });
                  //           },
                  //           color: Colors.brown,
                  //           minWidth: deviceWidth(context) * 0.9,
                  //           height: 34,
                  //           highlightColor: Colors.blue.withOpacity(0.6),
                  //           splashColor: Colors.blue.withOpacity(0.6),
                  //           visualDensity: VisualDensity.compact,
                  //           shape: RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(4),
                  //             side: BorderSide(
                  //               color: Colors.blue,
                  //               width: 0.5,
                  //             ),
                  //           ),
                  //           child: Text(
                  //             "Add Address",
                  //             style: CommonStyles.whiteText12BoldW500(),
                  //           ),
                  //         ),
                  //       )
                  //     : Row(
                  //         children: [
                  //           Text('${user.userDetails!.address}',
                  //               style: CommonStyles.black12thin()),
                  //           UIHelper.horizontalSpaceSmall(),
                  //           InkWell(
                  //             child: Icon(
                  //               Icons.edit,
                  //               size: 13,
                  //             ),
                  //             onTap: () {
                  //               showModalBottomSheet(
                  //                   context: context,
                  //                   isScrollControlled: true,
                  //                   builder: (context) {
                  //                     return Padding(
                  //                       padding: EdgeInsets.only(
                  //                           bottom: MediaQuery.of(context)
                  //                               .viewInsets
                  //                               .bottom),
                  //                       child: Column(
                  //                         mainAxisSize: MainAxisSize.min,
                  //                         children: <Widget>[
                  //                           ListTile(
                  //                             leading: IconButton(
                  //                               icon: Icon(
                  //                                 Icons.clear,
                  //                                 size: 20,
                  //                                 color: darkOrange,
                  //                               ),
                  //                               onPressed: () {
                  //                                 Navigator.pop(context);
                  //                               },
                  //                             ),
                  //                             title: Text(
                  //                               'EDIT ADDRESS',
                  //                               style: Theme.of(context)
                  //                                   .textTheme
                  //                                   .headline6!
                  //                                   .copyWith(
                  //                                       fontSize: 17.0,
                  //                                       color:
                  //                                           Colors.blueAccent),
                  //                             ),
                  //                             trailing: IconButton(
                  //                               icon: Icon(
                  //                                 Icons.check,
                  //                                 size: 20,
                  //                                 color: darkOrange,
                  //                               ),
                  //                               onPressed: () {
                  //                                 _addressformKey.currentState!
                  //                                     .save();
                  //                                 Map param = {};
                  //                                 param.addAll({
                  //                                   "user_id":
                  //                                       ApiServices.userId
                  //                                 });
                  //                                 param.addAll(_addressformKey
                  //                                     .currentState!.value);
                  //                                 if (_addressformKey
                  //                                     .currentState!
                  //                                     .validate()) {
                  //                                   setState(() async {
                  //                                     await apiServices
                  //                                         .editAddress(
                  //                                           param,
                  //                                         )
                  //                                         .then((value) =>
                  //                                             Navigator.pop(
                  //                                                 context));
                  //                                   });
                  //                                 } else {
                  //                                   print("validation failed");
                  //                                 }
                  //                               },
                  //                             ),
                  //                           ),
                  //                           FormBuilder(
                  //                             key: _addressformKey,
                  //                             child: Padding(
                  //                               padding:
                  //                                   const EdgeInsets.all(8.0),
                  //                               child: Column(
                  //                                 children: [
                  //                                   Padding(
                  //                                     padding:
                  //                                         const EdgeInsets.all(
                  //                                             5.0),
                  //                                     child:
                  //                                         FormBuilderTextField(
                  //                                       name: 'address',
                  //                                       initialValue: user
                  //                                           .userDetails!
                  //                                           .address,
                  //                                       decoration:
                  //                                           InputDecoration(
                  //                                         border:
                  //                                             OutlineInputBorder(),
                  //                                         labelText: "Address",
                  //                                       ),
                  //                                     ),
                  //                                   ),
                  //                                 ],
                  //                               ),
                  //                             ),
                  //                           )
                  //                         ],
                  //                       ),
                  //                     );
                  //                   });
                  //             },
                  //           )
                  //         ],
                  //       )
                ],
              ),
            );
    }
  }
}

class _PastOrderListView extends StatefulWidget {
  @override
  State<_PastOrderListView> createState() => _PastOrderListViewState();
}

class _PastOrderListViewState extends State<_PastOrderListView> {
  final List<String> restaurants = [
    'Sea Emperor',
    'Fireflies Restaurant',
    'Chai Truck',
    'Mayura Hotel'
  ];

  // List<OrderHistory>? orderHistories = ApiServices.orderHistories;

  final List<String> foods = [
    'Pepper BBQ x 1',
    'Chicken Noodles x 1',
    'Milk Tea x 1',
    'Malasa Dose x 1',
  ];

  @override
  void initState() {
    super.initState();
    if (context.read<OngoingOrderAPIProvider>().orderHistoryResponseModel ==
        null) {
      context.read<OngoingOrderAPIProvider>().getOrderHistory();
    }

    // setState(() {
    //   apiServices.orderHistory().then((value) {
    //     setState(() {
    //       orderHistories = ApiServices.orderHistories;
    //       print("orderHistories +${orderHistories}");
    //     });
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return successBody();
  }

  //  successBody(OngoingOrderResponseModel orderHistory) {
  //   return SizedBox(
  //     height: 65.0,
  //     child: Column(
  //       children: [
  //         Padding(
  //           padding: const EdgeInsets.all(2.0),
  //           child: Container(
  //             height: 60.0,
  //             width: MediaQuery.of(context).size.width,
  //             child: ListView.builder(
  //                 shrinkWrap: true,
  //                 physics: ScrollPhysics(),
  //                 scrollDirection: Axis.horizontal,
  //                 itemCount: orderHistory.orderOngoing!.length,
  //                 itemBuilder: (context, index) {
  //                   return Padding(
  //                     padding: const EdgeInsets.all(2.0),
  //                     child: Container(
  //                       color: Colors.pinkAccent.withOpacity(0.2),
  //                       width: MediaQuery.of(context).size.width,
  //                       child: Padding(
  //                         padding: const EdgeInsets.all(8.0),
  //                         child: Row(
  //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                           children: [
  //                             Row(
  //                               children: [
  //                                 Column(
  //                                   mainAxisAlignment: MainAxisAlignment.start,
  //                                   crossAxisAlignment:
  //                                       CrossAxisAlignment.start,
  //                                   children: [
  //                                     Text(
  //                                       orderHistory.orderOngoing![index]
  //                                           .hotelDetails!.outletName!,
  //                                       style: TextStyle(
  //                                           fontWeight: FontWeight.bold),
  //                                     ),
  //                                     SizedBox(
  //                                       height: 5,
  //                                     ),
  //                                     Text(
  //                                       orderHistory
  //                                           .orderOngoing![index].status!,
  //                                       style: TextStyle(fontSize: 12),
  //                                     ),
  //                                   ],
  //                                 ),
  //                               ],
  //                             ),
  //                             InkWell(
  //                                 onTap: () {
  //                                   Navigator.push(
  //                                     context,
  //                                     MaterialPageRoute(
  //                                         builder: (context) => OngoingOrders(
  //                                               orderId: orderHistory
  //                                                   .orderOngoing![index].id,
  //                                             )),
  //                                   );
  //                                 },
  //                                 child: Text("View")),
  //                           ],
  //                         ),
  //                       ),
  //                     ),
  //                   );
  //                 }),
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }

  successBody() {
    final ongoingOrderHistoryProvider =
        Provider.of<OngoingOrderAPIProvider>(context);
    if (ongoingOrderHistoryProvider.ifLoading) {
      print("Loading Details");
      return Center(
        child: Utils.showLoading(),
      );
    } else if (ongoingOrderHistoryProvider.error) {
      print("Error Found");

      return Utils.showErrorMessage(ongoingOrderHistoryProvider.errorMessage);
    } else if (ongoingOrderHistoryProvider.orderHistoryResponseModel != null &&
        ongoingOrderHistoryProvider.orderHistoryResponseModel!.status == '0') {
      print("Status is 0");

      return Utils.showErrorMessage(
          ongoingOrderHistoryProvider.orderHistoryResponseModel!.message!);
    }
    print("Success Status");

    final firebaseAuthService = Provider.of<FirebaseAuthService>(context);
    List<OrderOngoing>? orderHistories =
        ongoingOrderHistoryProvider.orderHistoryResponseModel!.orderOngoing;

    // print("The order History length " + orderHistories!.length.toString());
    return Column(
      children: [
        !firebaseAuthService.isAnonymusSignIn()
            ? orderHistories != null &&
                    orderHistories.isNotEmpty &&
                    orderHistories.length != 0
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(left: 15.0),
                        height: 50.0,
                        color: Colors.grey[200],
                        child: Text(
                          'ONGOING ORDERS',
                          style: CommonStyles.black57S14(),
                        ),
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: orderHistories.length,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 10.0),
                              child: Card(
                                elevation: 10,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Order ID : " +
                                                "#C2BPDOID0" +
                                                orderHistories[index].id!,
                                            style: CommonStyles.black12(),
                                          ),
                                          GestureDetector(
                                              onTap: () {
                                                showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return Dialog(
                                                          insetPadding:
                                                              EdgeInsets.zero,
                                                          child:
                                                              SelectReasonForHelp(
                                                            orderId: "#C2BPDOID0" +
                                                                orderHistories[
                                                                        index]
                                                                    .id!,
                                                          ));
                                                    });
                                              },
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Help",
                                                    style: CommonStyles
                                                        .black10Thin(),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Icon(
                                                    Icons.help,
                                                    color: Colors.blue[800],
                                                  ),
                                                ],
                                              ))
                                        ],
                                      ),
                                      Divider(
                                        thickness: 1,
                                        color: Colors.black54,
                                      ),
                                      Container(
                                        padding: const EdgeInsets.only(
                                          top: 10.0,
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  ongoingOrderHistoryProvider
                                                      .orderHistoryResponseModel!
                                                      .orderOngoing![index]
                                                      .hotelDetails!
                                                      .outletName!,
                                                  style: CommonStyles.black12(),
                                                ),
                                                UIHelper
                                                    .verticalSpaceExtraSmall(),
                                                Text(
                                                  orderHistories[index]
                                                      .address!,
                                                  style: CommonStyles.black12(),
                                                ),
                                                UIHelper
                                                    .verticalSpaceExtraSmall(),
                                                Text(
                                                  orderHistories[index]
                                                      .customerName!
                                                      .createdAt!,
                                                  style: CommonStyles
                                                      .black10Thin(),
                                                ),
                                                UIHelper.verticalSpaceMedium(),
                                              ],
                                            ),
                                            Spacer(),
                                            Text(orderHistories[index].status!,
                                                style:
                                                    CommonStyles.black10Thin()),
                                            UIHelper.horizontalSpaceSmall(),
                                            ClipOval(
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(2.2),
                                                color: Colors.green,
                                                child: Icon(Icons.check,
                                                    color: Colors.white,
                                                    size: 14.0),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      RatingBar.builder(
                                        glowColor: Colors.blue,
                                        initialRating: 0,
                                        itemSize: 10,
                                        minRating: 2,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemPadding: EdgeInsets.symmetric(
                                            horizontal: 4.0),
                                        itemBuilder: (context, _) => Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        onRatingUpdate: (rating) {
                                          apiService.rating(
                                              context,
                                              orderHistories[index].outletId,
                                              rating,
                                              "");
                                          print(rating);
                                        },
                                      ),
                                      UIHelper.verticalSpaceExtraSmall(),
                                      DottedSeperatorView(),
                                      Container(
                                        // height: MediaQuery.of(context).size.height * 0.40,
                                        child: ListView(
                                          shrinkWrap: true,
                                          padding: EdgeInsets.zero,
                                          physics: ScrollPhysics(),
                                          children: orderHistories[index]
                                              .productDetails!
                                              .map((e) {
                                            return Wrap(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Text(
                                                        e.productName!,
                                                        style: CommonStyles
                                                            .black11(),
                                                      ),
                                                      UIHelper
                                                          .verticalSpaceExtraSmall(),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            "${e.qty} Qty",
                                                            style: CommonStyles
                                                                .black10Thin(),
                                                          ),
                                                          Text(
                                                            " - ",
                                                          ),
                                                          Text(
                                                            "Rs. " +
                                                                e.price
                                                                    .toString(),
                                                            style: CommonStyles
                                                                .black10Thin(),
                                                          ),
                                                        ],
                                                      ),

                                                      // CustomDividerView(dividerHeight: 1.5, color: Colors.black)
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                      DottedSeperatorView(),
                                      MaterialButton(
                                          color: Colors.black54,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Center(
                                                child: Text(
                                              "Details",
                                              style: CommonStyles
                                                  .whiteText15BoldW500(),
                                            )),
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        OngoingOrderDetailsPage(
                                                          index: index,
                                                        )));
                                          })
                                      // Row(
                                      //   mainAxisAlignment:
                                      //       MainAxisAlignment.spaceEvenly,
                                      //   children: <Widget>[
                                      //     Expanded(
                                      //       child: TextButton(
                                      //         style: TextButton.styleFrom(
                                      //             primary: darkOrange,
                                      //             side: BorderSide(
                                      //                 width: 1.5,
                                      //                 color:
                                      //                     Colors.orange[800]!),
                                      //             minimumSize: Size(
                                      //                 double.infinity, 40)),
                                      //         child: Text(
                                      //           'REORDER',
                                      //           style: CommonStyles.black12(),
                                      //         ),
                                      //         onPressed: () {},
                                      //       ),
                                      //     ),
                                      //     UIHelper.horizontalSpaceMedium(),
                                      //     Expanded(
                                      //       child: TextButton(
                                      //         style: TextButton.styleFrom(
                                      //             primary: Colors.black,
                                      //             side: BorderSide(
                                      //                 width: 1.5,
                                      //                 color: Colors.black),
                                      //             minimumSize: Size(
                                      //                 double.infinity, 40)),
                                      //         child: Text(
                                      //           'RATE',
                                      //           style: CommonStyles.black12(),
                                      //         ),
                                      //         onPressed: () {},
                                      //       ),
                                      //     )
                                      //   ],
                                      // ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 15),
                      //   child: TextButton(
                      //     child: Text(
                      //       'VIEW MORE ORDERS',
                      //       style: TextStyle(color: darkOrange),
                      //     ),
                      //     style: TextButton.styleFrom(primary: darkOrange, minimumSize: Size(double.infinity, 50)),
                      //     onPressed: () {},
                      //   ),
                      // ),
                    ],
                  )
                : SizedBox(
                    height: deviceHeight(context) * 0.3,
                    width: deviceWidth(context),
                    child: Center(
                      child: Text(
                        "No order History",
                        style: CommonStyles.black12(),
                      ),
                    ),
                  )
            : SizedBox(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextButton(
                child: Text(
                  'View All Orders'.toUpperCase(),
                  style: TextStyle(color: darkOrange),
                  textAlign: TextAlign.start,
                ),
                style: TextButton.styleFrom(
                    primary: darkOrange,
                    minimumSize: Size(double.infinity, 50),
                    alignment: Alignment.centerLeft),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => OrderHistoryPage()));
                },
              ),
            ),
            Card(
              color: Colors.redAccent[700],
              margin: EdgeInsets.all(10),
              child: InkWell(
                onTap: () async {
                  // final sharedPreferenceProvider =
                  //     Provider.of<SharedPreferencesProvider>(context,
                  //         listen: false);

                  showLogoutDialog();

                  // Navigator.of(context).pop();
                  // await sharedPreferenceProvider.setIsUserLoggedIn(
                  //     userLoginStatus: false);

                  // ApiServices.sharedPreferences.remove("user").then((value) {
                  // ApiServices.userId = null;
                  // Navigator.pushNamedAndRemoveUntil(
                  //     context, "Login", (route) => false);
                  // });
                },
                child: Row(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 15.0),
                      height: 50.0,
                      child: Text(
                        'LOGOUT',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Spacer(),
                    Icon(
                      Icons.power_settings_new,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextButton(
                child: Text(
                  'Cancellation and Refund Policy'.toUpperCase(),
                  style: TextStyle(color: darkOrange),
                  textAlign: TextAlign.start,
                ),
                style: TextButton.styleFrom(
                    primary: darkOrange,
                    minimumSize: Size(double.infinity, 50),
                    alignment: Alignment.centerLeft),
                onPressed: () {
                  PDFDocument.fromAsset(
                          'assets/Cancellation and Refund Policy Foodie worlds.pdf')
                      .then((doc) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            insetPadding: EdgeInsets.zero,
                            child: Column(
                              children: [
                                AppBar(
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                ),
                                Expanded(
                                  child: PDFViewer(
                                    document: doc,
                                    showIndicator: false,
                                    showPicker: false,
                                  ),
                                ),
                              ],
                            ),
                          );
                        });
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextButton(
                child: Text(
                  'Terms and conditions'.toUpperCase(),
                  style: TextStyle(color: darkOrange),
                ),
                style: TextButton.styleFrom(
                    primary: darkOrange,
                    minimumSize: Size(double.infinity, 50),
                    alignment: Alignment.centerLeft),
                onPressed: () {
                  PDFDocument.fromAsset(
                          'assets/Foodie Worlds  Terms and conditions.pdf')
                      .then((doc) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            insetPadding: EdgeInsets.zero,
                            child: Column(
                              children: [
                                AppBar(
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                ),
                                Expanded(
                                  child: PDFViewer(
                                    document: doc,
                                    showIndicator: false,
                                    showPicker: false,
                                  ),
                                ),
                              ],
                            ),
                          );
                        });
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextButton(
                child: Text(
                  'Privacy Policy'.toUpperCase(),
                  style: TextStyle(color: darkOrange),
                ),
                style: TextButton.styleFrom(
                    primary: darkOrange,
                    minimumSize: Size(double.infinity, 50),
                    alignment: Alignment.centerLeft),
                onPressed: () {
                  PDFDocument.fromAsset(
                          'assets/Foodie worlds Privacy Policy.pdf')
                      .then((doc) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            insetPadding: EdgeInsets.zero,
                            child: Column(
                              children: [
                                AppBar(
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                ),
                                Expanded(
                                    child: PDFViewer(
                                  document: doc,
                                  showIndicator: false,
                                  showPicker: false,
                                )),
                              ],
                            ),
                          );
                        });
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextButton(
                child: Text(
                  'Help'.toUpperCase(),
                  style: TextStyle(color: darkOrange),
                ),
                style: TextButton.styleFrom(
                    primary: darkOrange,
                    minimumSize: Size(double.infinity, 50),
                    alignment: Alignment.centerLeft),
                onPressed: () {
                  PDFDocument.fromAsset(
                          'assets/Foodie worlds Privacy Policy.pdf')
                      .then((doc) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                              insetPadding: EdgeInsets.zero,
                              child: SelectReasonForHelp());
                        });
                  });
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<dynamic> showLogoutDialog() {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.power_settings_new,
                    color: Colors.red,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text("Do you want to LogOut ?",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () async {
                          final firebaseAuthService =
                              Provider.of<FirebaseAuthService>(context,
                                  listen: false);

                          context.read<OngoingOrderAPIProvider>().initialize();
                          context
                              .read<MeatBannerListAPIProvider>()
                              .initialize();

                          context.read<LoginAPIProvider>().initialize();
                          context.read<CartListAPIProvider>().initialize();
                          context
                              .read<PopularCurationAPIProvider>()
                              .initialize();
                          context.read<TakeAwayAPIProvider>().initialize();
                          context.read<BannerListAPIProvider>().initialize();
                          context.read<BottomBannerAPIProvider>().initialize();
                          context
                              .read<RestaurantOfferBannerAPIProvider>()
                              .initialize();

                          context
                              .read<FrontPageBannerAPIProvider>()
                              .initialize();
                          context
                              .read<RestaurantDetailsAPIProvider>()
                              .initialize();
                          context
                              .read<PopularRestaurantAPIProvider>()
                              .initialize();
                          context.read<PopularMeatAPIProvider>().initialize();
                          context.read<BeverageListAPIProvider>().initialize();
                          context
                              .read<VerifyUserLoginAPIProvider>()
                              .initialize();
                          context.read<OrderHistoryAPIProvider>().initialize();
                          context.read<ProfileViewApiProvider>().initialize();
                          context
                              .read<BakeryBannerListAPIProvider>()
                              .initialize();
                          context
                              .read<EditUserProfileAPIProvider>()
                              .initialize();

                          await firebaseAuthService.signOut(
                              googleSignIn:
                                  await firebaseAuthService.isGoogleLoggedIn());
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 25, vertical: 10),
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(6)),
                          child: Text("Yes",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500)),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 25, vertical: 10),
                          decoration: BoxDecoration(
                              color: Colors.deepOrange,
                              borderRadius: BorderRadius.circular(6)),
                          child: Text("No",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500)),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}

class SelectReasonForHelp extends StatefulWidget {
  const SelectReasonForHelp({Key? key, this.orderId}) : super(key: key);
  final String? orderId;
  @override
  _SelectReasonForHelpState createState() => _SelectReasonForHelpState();
}

class _SelectReasonForHelpState extends State<SelectReasonForHelp> {
  List<String> helpReasons = [
    'Food not delivered.',
    'Money deducted from account but order not placed.',
    'Delivery boy misbehaved.',
    'My reason not listed here.',
  ];
  @override
  void initState() {
    // if (context.read<UnitListAPIProvider>().unitListResponseModel == null) {
    //   context.read<UnitListAPIProvider>().fetchUnit();
    // }

    // if (context.read<ListGoodTypeAPIProvider>().goodsTypeResponseModel ==
    //     null) {
    //   context.read<ListGoodTypeAPIProvider>().fetchData().whenComplete(() {
    //     selectedGoodTye = List.generate(
    //         context
    //             .read<ListGoodTypeAPIProvider>()
    //             .goodsTypeResponseModel!
    //             .categoryList!
    //             .length,
    //         (index) => false);
    //     textEditingController = List.generate(
    //         context
    //             .read<ListGoodTypeAPIProvider>()
    //             .goodsTypeResponseModel!
    //             .categoryList!
    //             .length,
    //         (index) => TextEditingController());
    //     selectedUnit = List.generate(
    //         context
    //             .read<ListGoodTypeAPIProvider>()
    //             .goodsTypeResponseModel!
    //             .categoryList!
    //             .length,
    //         (index) => null);
    //   });

    // }

    //  else {
    //   selectedGoodTye = List.generate(
    //       context
    //           .read<ListGoodTypeAPIProvider>()
    //           .goodsTypeResponseModel!
    //           .categoryList!
    //           .length,
    //       (index) => false);
    //   textEditingController = List.generate(
    //       context
    //           .read<ListGoodTypeAPIProvider>()
    //           .goodsTypeResponseModel!
    //           .categoryList!
    //           .length,
    //       (index) => TextEditingController());
    //   selectedUnit = List.generate(
    //       context
    //           .read<ListGoodTypeAPIProvider>()
    //           .goodsTypeResponseModel!
    //           .categoryList!
    //           .length,
    //       (index) => null);
    // }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // appBar: appBar(),
      body: body(),
    );
  }

  body() {
    // final goodTypeAPIProvider = Provider.of<ListGoodTypeAPIProvider>(context);
    // if (goodTypeAPIProvider.ifLoading) {
    //   return SizedBox(
    //     child: Utils.getCenterLoading(),
    //     height: 300,
    //     width: deviceWidth(context),
    //   );
    // } else if (goodTypeAPIProvider.error) {
    //   print("------error ----------------");
    //   return SizedBox(
    //     height: 300,
    //     width: deviceWidth(context),
    //     child: Utils.showErrorMessage(goodTypeAPIProvider.errorMessage),
    //   );
    // } else if (goodTypeAPIProvider.goodsTypeResponseModel != null &&
    //     goodTypeAPIProvider.goodsTypeResponseModel!.status! == "0") {
    //   return Utils.showErrorMessage(
    //       goodTypeAPIProvider.goodsTypeResponseModel!.message!);
    // } else {
    //   final listCategory =
    //       goodTypeAPIProvider.goodsTypeResponseModel!.categoryList!;
    return SafeArea(
      child: Column(
        children: [
          Utils.getSizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(
                    Icons.arrow_back,
                    size: 25,
                    color: Colors.brown[900],
                  )),
              Utils.getSizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Select your help/query reason",
                    style: CommonStyles.black57S14(),
                  ),
                  Visibility(
                      visible: widget.orderId != null,
                      child: Column(
                        children: [
                          Utils.getSizedBox(height: 2, width: 0),
                          Text(
                            "Order ID : ${widget.orderId}",
                            style: CommonStyles.black10Thin(),
                          ),
                        ],
                      ))
                ],
              ),
            ],
          ),
          // Utils.getSizedBox(height: 20),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   children: [
          //     Padding(
          //       padding: const EdgeInsets.only(left: 8.0),
          //       child: Text(
          //         "Please select your reason for help/query.\n",
          //         style: CommonStyles.black10Thin(),
          //         textAlign: TextAlign.start,
          //       ),
          //     ),
          //   ],
          // ),
          Utils.getSizedBox(height: 20),
          Expanded(
            // margin: const EdgeInsets.only(top: 0),
            child: ListView.builder(
                itemCount: helpReasons.length,
                shrinkWrap: true,
                itemBuilder: ((context, index) {
                  bool _isSelected = false;
                  return InkWell(
                      onTap: () async {
                        //   final result = await showModalBottomSheet(
                        //       context: context,
                        //       isScrollControlled: true,
                        //       shape: const RoundedRectangleBorder(
                        //           borderRadius: BorderRadius.only(
                        //               topLeft: Radius.circular(10),
                        //               topRight: Radius.circular(10))),
                        //       builder: (context) {

                        //   }

                        final Uri params = Uri(
                          scheme: 'mailto',
                          path: 'closetobuy@gmail.com',
                          query: widget.orderId == null
                              ? 'subject=${helpReasons[index]}&body="I need urgent help as ${helpReasons[index]}"'
                              : 'subject="${helpReasons[index]} related to OID : ${widget.orderId}"&body="I need urgent help as ${helpReasons[index]}"', //add subject and body here
                        );

                        var url = params.toString();
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          throw 'Could not launch $url';
                        }

                        setState(() {
                          _isSelected = true;
                        });
                      },
                      child: ListViewGoodTypeWidget(
                        isSelected: _isSelected,
                        categoryName: helpReasons[index],
                        index: index,
                        key: UniqueKey(),
                      ));
                })),
          ),
          Utils.getSizedBox(height: 20),
          // Padding(
          //   padding: const EdgeInsets.only(right: 20, left: 20),
          //   child: MaterialButton(
          //       shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(8)),
          //       color: Colors.blue[900],
          //       height: 40,
          //       onPressed: () {
          //         // print("any element ----=" +
          //         //     selectedGoodTye.any((element) => true).toString());
          //         // if (selectedGoodTye.any((element) => true)) {
          //         //   final selInd = selectedGoodTye
          //         //       .indexWhere((element) => element == true);
          //         //   Map<String, dynamic> map = {
          //         //     'goodtype': listCategory[selInd].categoryName,
          //         //     'unit': textEditingController[selInd].text,
          //         //     'properUnit': selectedUnit[selInd]!.units!,
          //         //   };
          //         //   Navigator.of(context).pop(map);
          //         // } else {
          //         //   Utils.showSnackBar(
          //         //       context: context,
          //         //       text: "Atleast one selection mandatory");
          //         // }
          //         // showModalBottomSheet(
          //         //     context: context,
          //         //     builder: (context) {
          //         //       return Verify30PercentPayment(
          //         //         toLatitude: widget.toLatitude,
          //         //         toLongitude: widget.toLongitude,
          //         //         toAddress: widget.toAddress,
          //         //         vehicleList: widget.vehicleList,
          //         //       );
          //         //     });
          //         // Navigator.of(context).pop(selectedIndex);
          //       },
          //       child: Center(
          //         child: Text(
          //           " Update ",
          //           style: CommonStyles.whiteText12BoldW500(),
          //         ),
          //       )),
          // )
        ],
      ),
    );
  }
}

TextEditingController quanitytController = TextEditingController();
final quantityKey = GlobalKey<FormState>();

Widget listViewGoodType(String helpDescription, int index, bool isSelected) {
  return AnimatedContainer(
    duration: const Duration(milliseconds: 400),
    height: 40,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                helpDescription,
                style: CommonStyles.black13(),
              ),
              // Visibility(
              //     visible: selectedGoodTye[index],
              //     child: const Icon(
              //       Icons.check,
              //       color: Colors.green,
              //     ))
            ],
          ),
          // Visibility(
          //     visible: selectedGoodTye[index],
          //     child: Row(
          //       children: [
          //         Text(
          //           "Quantity :",
          //           style: CommonStyles.black1154(),
          //         ),
          //         Text(
          //           textEditingController[index].text,
          //           style: CommonStyles.black1654thin(),
          //         ),
          //         //  selectedUnit[index] == null
          //         //       ? ""
          //         //       : selectedUnit[index]!.units!
          //       ],
          //     ))
        ],
      ),
    ),
  );
}

class ListViewGoodTypeWidget extends StatefulWidget {
  const ListViewGoodTypeWidget(
      {Key? key,
      required this.isSelected,
      required this.categoryName,
      required this.index})
      : super(key: key);
  final bool isSelected;

  final int index;
  final String categoryName;

  @override
  _ListViewGoodTypeWidgetState createState() => _ListViewGoodTypeWidgetState();
}

class _ListViewGoodTypeWidgetState extends State<ListViewGoodTypeWidget> {
  TextEditingController quanitytController = TextEditingController();
  final quantityKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    print("widget is selected  +" + widget.isSelected.toString());

    return SizedBox(
      key: widget.key,
      width: 200,
      // duration: const Duration(milliseconds: 400),
      // decoration:
      //     BoxDecoration(border: Border.all(width: 2, color: Colors.black)),
      height: 40,
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0, left: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.categoryName,
                  style: CommonStyles.black13Thin(),
                ),
                if (widget.isSelected)
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: InkWell(
                        onTap: () {
                          // setState(() {
                          //   selectedGoodTye[widget.index] = false;
                          // });
                        },
                        child: const Icon(
                          Icons.check,
                          color: Colors.green,
                          size: 26,
                        )),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({Key? key}) : super(key: key);

  @override
  State<OrderHistoryPage> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  @override
  void initState() {
    if (context.read<OrderHistoryAPIProvider>().orderHistoryResponseModel ==
        null) {
      context.read<OrderHistoryAPIProvider>().getOrderHistory(
          SharedPreference.latitude, SharedPreference.longitude, "");
    }
    super.initState();
  }

  body() {
    final orderHistoryAPIProvider =
        Provider.of<OrderHistoryAPIProvider>(context);
    if (orderHistoryAPIProvider.ifLoading) {
      return Container();
    } else if (orderHistoryAPIProvider.error) {
      return Utils.showErrorMessage(orderHistoryAPIProvider.errorMessage);
    } else if (orderHistoryAPIProvider.orderHistoryResponseModel!.status ==
        "0") {
      return Utils.showErrorMessage(
          orderHistoryAPIProvider.orderHistoryResponseModel!.message!);
    }
    List<OrderHistory>? orderHistories =
        orderHistoryAPIProvider.orderHistoryResponseModel!.orderHistory!;
    return Container(
      child: orderHistoryAPIProvider
              .orderHistoryResponseModel!.orderHistory!.isEmpty
          ? Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Utils.getSizedBox(height: 10),
                    InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Icon(
                          Icons.arrow_back,
                          size: 25,
                          color: Colors.brown[900],
                        )),
                    Utils.getSizedBox(width: 15),
                    Text(
                      "Past Orders",
                      style: CommonStyles.black57S14(),
                    ),
                  ],
                ),
                Utils.getSizedBox(height: 20),

                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 15.0),
                  height: 50.0,
                  color: Colors.grey[200],
                  child: Text(
                    'PAST ORDERS',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2!
                        .copyWith(color: Colors.grey[700], fontSize: 12.0),
                  ),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: orderHistories.length,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        orderHistories[index]
                                            .customerName!
                                            .customerName!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2,
                                      ),
                                      UIHelper.verticalSpaceExtraSmall(),
                                      Text(
                                        orderHistories[index].address!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(fontSize: 12.0),
                                      ),
                                      UIHelper.verticalSpaceSmall(),
                                      Text(orderHistories[index]
                                          .customerName!
                                          .createdAt!),
                                      UIHelper.verticalSpaceMedium(),
                                    ],
                                  ),
                                  Spacer(),
                                  Text(orderHistories[index].status!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2),
                                  UIHelper.horizontalSpaceSmall(),
                                  ClipOval(
                                    child: Container(
                                      padding: const EdgeInsets.all(2.2),
                                      color: Colors.green,
                                      child: Icon(Icons.check,
                                          color: Colors.white, size: 14.0),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: RatingBar.builder(
                                glowColor: Colors.blue,
                                initialRating: 0,
                                minRating: 2,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemPadding:
                                    EdgeInsets.symmetric(horizontal: 4.0),
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {
                                  apiService.rating(
                                      context,
                                      orderHistories[index].outletId,
                                      rating,
                                      "");
                                  print(rating);
                                },
                              ),
                            ),
                            UIHelper.verticalSpaceSmall(),
                            DottedSeperatorView(),
                            UIHelper.verticalSpaceMedium(),
                            Container(
                              // height: MediaQuery.of(context).size.height * 0.40,
                              child: ListView(
                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                children: orderHistories[index]
                                    .productDetails!
                                    .map((e) {
                                  return Wrap(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              e.productName!,
                                            ),
                                            UIHelper.verticalSpaceExtraSmall(),
                                            Row(
                                              children: [
                                                Text(
                                                  "${e.qty} Qty",
                                                ),
                                                Text(
                                                  " - ",
                                                ),
                                                Text(
                                                  "Rs. " + e.price.toString(),
                                                ),
                                              ],
                                            ),

                                            // CustomDividerView(dividerHeight: 1.5, color: Colors.black)
                                          ],
                                        ),
                                      )
                                    ],
                                  );
                                }).toList(),
                              ),
                            ),
                            DottedSeperatorView(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Expanded(
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                        primary: darkOrange,
                                        side: BorderSide(
                                            width: 1.5,
                                            color: Colors.orange[800]!),
                                        minimumSize: Size(double.infinity, 40)),
                                    child: Text(
                                      'REORDER',
                                      style: CommonStyles.black12(),
                                    ),
                                    onPressed: () {},
                                  ),
                                ),
                                UIHelper.horizontalSpaceMedium(),
                                Expanded(
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                        primary: Colors.black,
                                        side: BorderSide(
                                            width: 1.5, color: Colors.black),
                                        minimumSize: Size(double.infinity, 40)),
                                    child: Text(
                                      'RATE',
                                      style: CommonStyles.black12(),
                                    ),
                                    onPressed: () {},
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      );
                    }),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 15),
                //   child: TextButton(
                //     child: Text(
                //       'VIEW MORE ORDERS',
                //       style: TextStyle(color: darkOrange),
                //     ),
                //     style: TextButton.styleFrom(primary: darkOrange, minimumSize: Size(double.infinity, 50)),
                //     onPressed: () {},
                //   ),
                // ),
              ],
            )
          : SizedBox(
              height: deviceHeight(context) * 0.3,
              width: deviceWidth(context),
              child: Center(
                child: Text(
                  "No order History",
                  style: CommonStyles.black12(),
                ),
              ),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: body());
  }
}
