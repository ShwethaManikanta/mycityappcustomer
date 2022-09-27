import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:google_place/google_place.dart';
import 'package:provider/provider.dart';
import 'package:mycityapp/Cab/Services/apiProvider/registration_api_provider.dart';
import 'package:mycityapp/Cab/Services/apiProvider/vehicle_categories_api_provider.dart';
import 'package:mycityapp/Cab/Services/location_services.dart/loaction_shared_preference.dart';
import 'package:mycityapp/Cab/pages/bookPage/book_vehicle.dart';
import 'package:mycityapp/common/common_styles.dart';
import 'package:mycityapp/common/utils.dart';

// import 'ConfirmLocation.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key, required this.type, this.initialLogin = false})
      : super(key: key);

  final String type;

  final bool initialLogin;

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late GooglePlace googlePlace;
  List<AutocompletePrediction> predictions = [];

  final _autocompleteLocationController = TextEditingController();

  @override
  void initState() {
    googlePlace = GooglePlace('AIzaSyCoCUX3aEbxcwud60ocZ-XcA7D4Ac-aNXE');
    super.initState();
  }

  bool isvisible = true;

  void showToast() {
    setState(() {
      isvisible = isvisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: buildBody(),
    );
  }

  buildBody() {
    return Column(
      children: [
        buildWelcome(),
        // placesAutoCompleteTextField(context),
        buildSearch(),
        buildListOfLocality(),
        // buildRecentdrop(),
        // buildRecentdropList()
      ],
    );
  }

  bool _fetchingAutoComplete = false;

  void autoCompleteSearch(String value) async {
    setState(() {
      _fetchingAutoComplete = true;
    });
    var result = await googlePlace.autocomplete.get(value);
    if (result != null && result.predictions != null && mounted) {
      predictions = result.predictions!;
      _fetchingAutoComplete = false;
    }
    setState(() {});
  }

  buildWelcome() {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back_outlined,
                color: Colors.black,
                size: 30,
              ),
            ),
          ),
          Text('Enter Drop Location', style: CommonStyles.black57S17()),
        ],
      ),
    );
  }

  buildSearch() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      width: double.infinity,
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        elevation: 10,
        child: Row(
          children: [
            const Padding(
              padding: EdgeInsets.all(5.0),
              child: Icon(
                Icons.search_rounded,
                color: Colors.black54,
              ),
            ),
            Expanded(
              child: TextFormField(
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    autoCompleteSearch(value);
                  }
                },
                cursorColor: Colors.black,
                readOnly: false,
                controller: _autocompleteLocationController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                style: CommonStyles.black13thin(),
                decoration: const InputDecoration(
                    hintText: 'Search your area,street name.. ',
                    isDense: false,
                    contentPadding:
                        EdgeInsets.only(top: 10, bottom: 10, left: 8, right: 8),
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    disabledBorder: InputBorder.none),
              ),
            ),
          ],
        ),
      ),
    );
  }

  buildListOfLocality() {
    return Expanded(
      child: _autocompleteLocationController.text.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Search your locaiton on search box",
                    style: CommonStyles.blue13900(),
                  )
                ],
              ),
            )
          : _fetchingAutoComplete
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        strokeWidth: 1,
                        backgroundColor: Colors.black12,
                        color: Colors.green[900],
                      ),
                      Utils.getSizedBox(height: 15),
                      Text(
                        "Loading...",
                        style: CommonStyles.blue12(),
                      )
                    ],
                  ),
                )
              : predictions.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Oops! We could not find location your searching.",
                            style: CommonStyles.red12(),
                          )
                        ],
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Search Results",
                            style: CommonStyles.black13thin(),
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            padding: const EdgeInsets.all(0),
                            shrinkWrap: true,
                            itemCount: predictions.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  width: deviceWidth(context) * 0.9,
                                  child: InkWell(
                                    onTap: () async {
                                      // Utils.showLoaderDialog(context);
                                      DetailsResponse? result =
                                          await googlePlace.details
                                              .get(predictions[index].placeId!);
                                      Navigator.of(context).pop();
                                      if (result != null) {
                                        Location locaiton =
                                            result.result!.geometry!.location!;

                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    PlacePickGoogleMaps(
                                                      type: widget.type,
                                                      latitude: locaiton.lat!,
                                                      longitude: locaiton.lng!,
                                                      initialScreen:
                                                          widget.initialLogin,
                                                    )));
                                      } else {
                                        Utils.showSnackBar(
                                            context: context,
                                            text:
                                                "Oops! Something went wrong!!");
                                      }

                                      // if (result != null &&
                                      //     result.predictions != null &&
                                      //     mounted) {
                                      //   predictions = result.predictions!;
                                      //   _fetchingAutoComplete = false;
                                      // }
                                    },
                                    child: Row(
                                      children: [
                                        const Icon(Icons.location_on_rounded),
                                        Utils.getSizedBox(width: 10),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                predictions[index].description!,
                                                maxLines: 2,
                                                style: CommonStyles.black13(),
                                              ),
                                              Utils.getSizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                predictions[index]
                                                    .structuredFormatting!
                                                    .mainText!,
                                                style: CommonStyles
                                                    .black1254thin(),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );

                              // return ListTile(
                              //   contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                              //   dense: true,
                              //   leading: const Icon(
                              //     Icons.location_on,
                              //     color: Colors.black,
                              //   ),
                              //   title: Text(
                              //     predictions[index].description!,
                              //     style: CommonStyles.black13(),
                              //   ),
                              //   subtitle:  Text(
                              //     predictions[index].description!,
                              //     style: CommonStyles.black13(),
                              //   )
                              //   onTap: () {
                              //     debugPrint(predictions[index].placeId);
                              //     Navigator.pushNamed(context, "ConfirmLocation",
                              //         arguments: predictions[index].description);
                              //   },
                              // );
                            },
                          ),
                        ),
                      ],
                    ),
    );
  }

  // buildRecentdrop() {
  //   return Visibility(
  //     visible: isvisible,
  //     child: Container(
  //       alignment: Alignment.topLeft,
  //       child: Padding(
  //         padding: const EdgeInsets.only(top: 5, left: 15),
  //         child: Text(
  //           'Recent drops',
  //           style: TextStyle(
  //               fontSize: 12,
  //               color: Colors.black,
  //               fontWeight: FontWeight.w500,
  //               letterSpacing: 0),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // buildRecentdropList() {
  //   return Expanded(
  //     flex: 1,
  //     child: Container(
  //       child: ListView.builder(
  //           physics: BouncingScrollPhysics(),
  //           itemCount: 2,
  //           itemBuilder: (BuildContext context, int index) {
  //             return Padding(
  //               padding: const EdgeInsets.only(top: 0),
  //               child: InkWell(
  //                 onTap: () {
  //                   Navigator.pushNamed(context, 'ConfirmLocation');
  //                 },
  //                 child: ListTile(
  //                     leading: Icon(
  //                       Icons.timelapse_rounded,
  //                       size: 35,
  //                     ),
  //                     title: Text('Govindraja Nagar',
  //                         style: TextStyle(
  //                             fontSize: 15,
  //                             color: Colors.black,
  //                             fontWeight: FontWeight.w800,
  //                             letterSpacing: 0)),
  //                     subtitle: Text(
  //                       'CHBS LAYOUT, MC LAYOUT,VIJAYANAGAR',
  //                       style: TextStyle(
  //                           fontSize: 8,
  //                           color: Colors.black,
  //                           fontWeight: FontWeight.w400,
  //                           letterSpacing: 0),
  //                     ),
  //                     trailing:
  //                         IconButton(icon: Icon(Icons.star), onPressed: () {})),
  //               ),
  //             );
  //           }),
  //     ),
  //   );
  // }
}

class PlacePickGoogleMaps extends StatefulWidget {
  const PlacePickGoogleMaps(
      {Key? key,
      required this.type,
      this.latitude,
      this.longitude,
      this.initialScreen = false})
      : super(key: key);

  final double? latitude, longitude;
  final bool initialScreen;
  final String type;

  @override
  _PlacePickGoogleMapsState createState() => _PlacePickGoogleMapsState();
}

class _PlacePickGoogleMapsState extends State<PlacePickGoogleMaps> {
  Location location = Location();

  TextEditingController controllerAddress = TextEditingController();

  late LatLng latLngCamera;

  final Completer<GoogleMapController> _controller = Completer();
  late GoogleMapController mapController;

  @override
  void initState() {
    print("Init state pronted");
    print("Destination Type" + widget.type);

    super.initState();
    if (widget.latitude == null || widget.longitude == null) {
      latLngCamera =
          LatLng(SharedPreference.latitude!, SharedPreference.longitude!);
    } else {
      latLngCamera = LatLng(widget.latitude!, widget.longitude!);
    }

    print(latLngCamera.latitude.toString() +
        "Lat long camera" +
        latLngCamera.longitude.toString());
    // context.read<ProfileApiProvder>().profileModel!.userDetails!.latitude;
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<String> getJsonFile(String path) async {
    return await rootBundle.loadString(path);
  }

  bool _isWidgetLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          SizedBox(
            height: deviceHeight(context),
            width: deviceWidth(context),
            child: GoogleMap(
              mapType: MapType.normal,
              myLocationEnabled: true,
              zoomGesturesEnabled: true,
              scrollGesturesEnabled: true,
              // padding: const EdgeInsets.only(top: 180),
              rotateGesturesEnabled: true,
              tiltGesturesEnabled: true,
              initialCameraPosition: CameraPosition(
                  target: LatLng(latLngCamera.latitude, latLngCamera.longitude),
                  zoom: 15),
              onMapCreated: (GoogleMapController controller) {
                getJsonFile("assets/mapStyle.json")
                    .then((value) => controller.setMapStyle(value));
                _controller.complete(controller);
                mapController = controller;
              },
              onCameraIdle: () {
                setState(() {
                  _isWidgetLoading = false;
                });
              },
              onCameraMove: (value) {
                latLngCamera = value.target;
              },
              onCameraMoveStarted: () {
                setState(() {
                  _isWidgetLoading = true;
                });
              },
            ),
          ),
          Positioned(
            top: (deviceHeight(context) - 70) / 2,
            right: (deviceWidth(context) - 35) / 2,
            child: const Align(
              alignment: Alignment.center,
              child: Icon(
                FontAwesomeIcons.mapPin,
                color: Colors.blue,
                size: 35,
              ),
            ),
          ),
          Positioned(
              top: 50.0,
              right: 15.0,
              left: 15.0,
              child: _isWidgetLoading
                  ? Container(
                      height: 100,
                      width: deviceWidth(context) * 0.9,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(width: 1, color: Colors.amber),
                          color: Colors.blue),
                      child: const Center(
                        child: SizedBox(
                          height: 25,
                          child: CircularProgressIndicator(
                            strokeWidth: 1,
                            color: Colors.white,
                          ),
                          width: 25,
                        ),
                      ),
                    )
                  : ReverseGeoCodingTextFormField(
                      latitude: latLngCamera.latitude,
                      longitude: latLngCamera.longitude,
                      controllerAddress: controllerAddress,
                    ))
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: widget.type == "2"
          ? FloatingActionButton.extended(
              isExtended: true,
              onPressed: _isWidgetLoading
                  ? () {}
                  : widget.initialScreen
                      ? () async {
                          await SharedPreference.getLocationData(
                              latLngCamera.latitude, latLngCamera.longitude);
                          Navigator.of(context).pop();
                          Navigator.of(context).pop("Hello");
                        }
                      :
                      //widget.type == "2"?
                      () async {
                          // Navigator.pushNamed(context, 'RentelPackages');
                          final result = await showModalBottomSheet(
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(12),
                                      topRight: Radius.circular(12))),
                              context: context,
                              builder: (context) => const ShowDetails());

                          if (result['name'] == "" ||
                              result['name'] == null ||
                              result['phone'] == "" ||
                              result['phone'] == null) {
                            Utils.showSnackBar(
                                context: context, text: "Details not given");
                          } else {
                            selectedLongLat
                                .setSelectedLatitude(latLngCamera.latitude);
                            selectedLongLat
                                .setSelectedLongitude(latLngCamera.longitude);

                            showModalBottomSheet(
                                context: context,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(12),
                                        topRight: Radius.circular(12))),
                                builder: (context) {
                                  print("Desitination type" + widget.type);

                                  return VerifyAddressBottomSheet(
                                    type: widget.type,
                                    toAddress: controllerAddress.text,
                                    toLatitude: latLngCamera.latitude,
                                    toLongitude: latLngCamera.longitude,
                                    pickUpContactName: result['name'],
                                    pickUpContactNumber: result['phone'],
                                  );
                                });
                          }

                          // showModalBottomSheet(
                          //   context: context,
                          //   builder: (context) {
                          //     return const ShowDetails();
                          //   },
                          //   isScrollControlled: true,
                          //   shape: const RoundedRectangleBorder(
                          //     borderRadius: BorderRadius.only(
                          //         topLeft: Radius.circular(10),
                          //         topRight: Radius.circular(10)),
                          //   ),
                          // );

                          // Navigator.of(context).pop(EditCartAddressRequestModel(
                          //     userId: ApiService.userID!,
                          //     address: controllerAddress.text,
                          //     latitude: latLngCamera.latitude.toString(),
                          //     longitude: latLngCamera.longitude.toString()));
                          // setState(() {
                          //   _goToTheLake(latLngCamera.latitude, latLngCamera.longitude);
                          // });
                        }
              /*: Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => BookVehiclePage(
                            type: "type",
                            toLatitude: "toLatitude",
                            toLongitude: "toLongitude",
                            address: "address",
                            pickupContactName: "pickupContactName",
                            pickupContactPhone: "pickupContactPhone")))*/
              ,
              tooltip: 'Press to Select Location',
              label: Text(
                "Select Location",
                style: CommonStyles.whiteText15BoldW500(),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            )
          : FloatingActionButton.extended(
              isExtended: true,
              onPressed: _isWidgetLoading
                  ? () {}
                  : widget.initialScreen
                      ? () async {
                          await SharedPreference.getLocationData(
                              latLngCamera.latitude, latLngCamera.longitude);
                          Navigator.of(context).pop();
                          Navigator.of(context).pop("Hello");
                        }
                      :
                      //widget.type == "2"?
                      () async {
                          print("Mobile No ---------------- >>>>>>>>>>>. " +
                              context
                                  .read<ProfileViewAPIProvider>()
                                  .profileViewResponse!
                                  .userDetails!
                                  .orderMobile!);

                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => BookVehiclePage(
                                  type: widget.type,
                                  toLatitude: latLngCamera.latitude,
                                  toLongitude: latLngCamera.longitude,
                                  address: controllerAddress.text,
                                  pickupContactName: context
                                      .read<ProfileViewAPIProvider>()
                                      .profileViewResponse!
                                      .userDetails!
                                      .userName!,
                                  pickupContactPhone: context
                                      .read<ProfileViewAPIProvider>()
                                      .profileViewResponse!
                                      .userDetails!
                                      .orderMobile!)));
                        },
              tooltip: 'Press to Select Location',
              label: Text(
                "Select Location",
                style: CommonStyles.whiteText15BoldW500(),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
    );
  }

  final globalFormKey = GlobalKey<FormState>();

  enterNameAndPhoneNumber() {
    return Form(
      key: globalFormKey,
      child: Column(
        children: [
          TextFormField(),
          TextFormField(),
        ],
      ),
    );
  }
}

class VerifyAddressBottomSheet extends StatefulWidget {
  const VerifyAddressBottomSheet(
      {Key? key,
      required this.type,
      required this.toAddress,
      required this.toLatitude,
      required this.toLongitude,
      required this.pickUpContactName,
      required this.pickUpContactNumber})
      : super(key: key);
  final String toAddress, pickUpContactName, pickUpContactNumber;
  final double toLatitude, toLongitude;
  final String type;
  @override
  _VerifyAddressBottomSheetState createState() =>
      _VerifyAddressBottomSheetState();
}

class _VerifyAddressBottomSheetState extends State<VerifyAddressBottomSheet> {
  List<Model> list = [];

  @override
  void initState() {
    super.initState();
    initialize();
    // list.add(Model("Vijayawada", Colors.blue));
  }

  initialize() {
    list.clear();
    list.add(Model(SharedPreference.currentAddress!, Colors.green));
    list.add(Model(widget.toAddress, Colors.red));
  }

  // void addNew() {
  //   setState(() {
  //     list.add(Model("Karnool", Colors.black));
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final getVechileList = Provider.of<VehicleCategoriesAPIProvider>(context);

    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Review Location",
            style: CommonStyles.blackS18(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: ListView.builder(
                itemCount: list.length,
                shrinkWrap: true,
                itemBuilder: (con, ind) {
                  return ind != 0
                      ? Column(mainAxisSize: MainAxisSize.min, children: [
                          Row(children: [
                            Column(
                              children: List.generate(
                                4,
                                (ii) => Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10, top: 5, bottom: 5),
                                    child: Container(
                                      height: 3,
                                      width: 2,
                                      color: Colors.grey,
                                    )),
                              ),
                            ),
                            // Expanded(
                            //     child: Container(
                            //   color: Colors.grey.withAlpha(60),
                            //   height: 0.5,
                            //   padding: EdgeInsets.only(
                            //     left: 10,
                            //     right: 20,
                            //   ),
                            // ))
                          ]),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            },
                            child: Row(children: [
                              Icon(Icons.location_on, color: list[ind].color),
                              Flexible(
                                child: Text(list[ind].address,
                                    maxLines: 3, style: CommonStyles.red12()),
                              )
                            ]),
                          )
                        ])
                      : InkWell(
                          onTap: () async {
                            print("pressing change initial location page");
                            await Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return PlacePickGoogleMaps(
                                type: widget.type,
                              );
                            }));
                            setState(() {
                              initialize();
                            });
                            // if (result.isNotEmpty) {
                            //   // _controller!.animateCamera(
                            //   //   CameraUpdate.newCameraPosition(
                            //   //     CameraPosition(
                            //   //         target: LatLng(
                            //   //             SharedPreference.latitude!,
                            //   //             SharedPreference.longitude!),
                            //   //         zoom: 15),
                            //   //   ),
                            //   // );
                            // }
                          },
                          child: Row(children: [
                            Icon(Icons.location_on, color: list[ind].color),
                            Flexible(
                              child: Text(list[ind].address,
                                  maxLines: 3, style: CommonStyles.green12()),
                            )
                          ]),
                        );
                }),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 12.0,
            ),
            child: MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                color: Colors.amber,
                height: 40,
                onPressed: () {
                  print("Type from Location  ------->>>" + widget.type);

                  // showModalBottomSheet(
                  //     context: context,
                  //     builder: (context) {
                  //       return Verify30PercentPayment(
                  //         toLatitude: widget.toLatitude,
                  //         toLongitude: widget.toLongitude,
                  //         toAddress: widget.toAddress,
                  //         vehicleList: widget.vehicleList,
                  //       );
                  //     });

                  print("To Lat " + widget.toLatitude.toString());
                  print("To Lng " + widget.toLongitude.toString());

                  //    print("KM LIMIT ----" + context.read<VehicleCategoriesAPIProvider>().vehicleCategoriesResponseModel!.kmLimitStatus.toString());

                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => BookVehiclePage(
                            type: widget.type,
                            toLatitude: widget.toLatitude,
                            toLongitude: widget.toLongitude,
                            address: widget.toAddress,
                            pickupContactName: context
                                .read<ProfileViewAPIProvider>()
                                .profileViewResponse!
                                .userDetails!
                                .userName!,
                            pickupContactPhone: context
                                .read<ProfileViewAPIProvider>()
                                .profileViewResponse!
                                .userDetails!
                                .mobile!,
                          )));
                },
                child: Center(
                  child: Text(
                    "Confirm Location",
                    style: CommonStyles.black13thin(),
                  ),
                )),
          )
        ],
      ),
    );

    // Scaffold(
    //     appBar: AppBar(
    //         backgroundColor: Colors.black,
    //         title:
    //             Text('Custom Stepper', style: TextStyle(color: Colors.white)),
    //         actions: [
    //           IconButton(
    //               icon: Icon(Icons.add_circle, color: Colors.white),
    //               onPressed: addNew)
    //         ]),
    //     body:

    //     );
  }
}

class ShowDetails extends StatefulWidget {
  const ShowDetails({Key? key}) : super(key: key);

  @override
  _ShowDetailsState createState() => _ShowDetailsState();
}

class _ShowDetailsState extends State<ShowDetails> {
  final nameController = TextEditingController();
  final nameKey = GlobalKey<FormState>();

  final phoneNumberController = TextEditingController();
  final phoneNumberKey = GlobalKey<FormState>();

  bool? _isSelectedUseMyMobile;

  @override
  Widget build(BuildContext context) {
    final profileViewAPIProvider =
        Provider.of<ProfileViewAPIProvider>(context, listen: false);
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        // height: 255,
        // width: deviceWidth(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 12.0, left: 8, bottom: 8),
              child: Text(
                "Driver will call this contact at Pickup Location",
                style: CommonStyles.black11(),
              ),
            ),
            SizedBox(
              width: deviceWidth(context),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Form(
                        key: nameKey,
                        child: TextFormField(
                          autofocus: true,
                          style: CommonStyles.black13thin(),
                          validator: (value) {
                            if (value == null || value.length < 3) {
                              return "Enter valid name";
                            }
                            return null;
                          },
                          controller: nameController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              hintText: 'Passenger Name',
                              hintStyle: CommonStyles.black10thin(),
                              border: const OutlineInputBorder(),
                              contentPadding: const EdgeInsets.only(
                                  left: 10, top: 5, bottom: 5)),
                          cursorColor: (Colors.orange[900])!,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        width: deviceWidth(context) * 0.1,
                        child: IconButton(
                            onPressed: () async {
                              openContactBook();
                            },
                            icon: Icon(
                              Icons.contacts_rounded,
                              color: _fromPhoneBook
                                  ? Colors.blue[900]
                                  : Colors.black54,
                            )),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: phoneNumberKey,
                child: TextFormField(
                  autofocus: true,
                  style: CommonStyles.black13thin(),
                  maxLength: 10,
                  validator: (value) {
                    if (value == null || value.length != 10) {
                      return "Enter valid phone number";
                    }
                    return null;
                  },
                  controller: phoneNumberController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      counterText: "",
                      hintText: 'Enter The Passenger Phone Number',
                      hintStyle: CommonStyles.black10thin(),
                      border: const OutlineInputBorder(),
                      contentPadding:
                          const EdgeInsets.only(left: 10, top: 5, bottom: 5)),
                  cursorColor: (Colors.orange[900])!,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 3),
              child: Row(
                children: [
                  Checkbox(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                    visualDensity: VisualDensity.compact,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    onChanged: (value) {
                      if (value != null && value) {
                        nameController.text = profileViewAPIProvider
                            .profileViewResponse!.userDetails!.userName!;
                        phoneNumberController.text = profileViewAPIProvider
                            .profileViewResponse!.userDetails!.orderMobile!;
                      } else if (value != null && !value) {
                        nameController.clear();
                        phoneNumberController.clear();
                      }
                      setState(() {
                        _useUserDetails = value!;
                      });
                      // final loggenInUser =
                      //Get Details From usermodel from api and use it in name and phone number controller.
                      //
                    },
                    value: _useUserDetails,
                  ),
                  Utils.getSizedBox(width: 4),
                  RichText(
                      text: TextSpan(
                          text: "Use my mobile number :",
                          style: CommonStyles.black11(),
                          children: [
                        TextSpan(
                            text:
                                "  +91 ${profileViewAPIProvider.profileViewResponse!.userDetails!.orderMobile!}",
                            style: CommonStyles.black1154())
                      ]))
                ],
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: MaterialButton(
                onPressed: () {
                  if (nameKey.currentState!.validate() &&
                      phoneNumberKey.currentState!.validate()) {
                    Map<String, dynamic> map = {
                      'name': nameController.text,
                      'phone': phoneNumberController.text,
                    };
                    Navigator.of(context).pop(map);
                  }
                },
                minWidth: deviceWidth(context) * 0.8,
                height: 40,
                color: const Color.fromARGB(255, 0, 102, 255),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Save & Proceed",
                    style: CommonStyles.whiteText12BoldW500(),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  bool _fromPhoneBook = false;
  bool _useUserDetails = false;
  Future<String> openContactBook() async {
    final PhoneContact contact = await FlutterContactPicker.pickPhoneContact();
    if (contact.phoneNumber == null && contact.fullName == null) {
      Utils.showSnackBar(context: context, text: "Phone Number not selected");
    } else {
      if (contact.fullName != null) {
        nameController.text = contact.fullName!;
      }
      if (contact.phoneNumber != null) {
        PhoneNumber contactPhoneNumber = contact.phoneNumber!;

        // print("contact phone number " + contactPhoneNumber.number!.toString());
        // var phoneNumberString =
        //     contact.phoneNumber.toString().replaceAll(RegExp(r"\s+"), "");
        phoneNumberController.text = contactPhoneNumber.number!.toString();
      }
      setState(() {
        _fromPhoneBook = true;
      });
    }
    return "";
  }

  // Future<String> openContactBook() async {
  //   Contact contact = await ContactPicker().selectContact();
  //   if (contact != null) {

  //     return phoneNumber;
  //   }
  //   return "";
  // }
}

class ReverseGeoCodingTextFormField extends StatefulWidget {
  const ReverseGeoCodingTextFormField(
      {Key? key,
      required this.latitude,
      required this.longitude,
      required this.controllerAddress})
      : super(key: key);
  final double latitude, longitude;
  final TextEditingController controllerAddress;
  @override
  _ReverseGeoCodingTextFormFieldState createState() =>
      _ReverseGeoCodingTextFormFieldState();
}

class _ReverseGeoCodingTextFormFieldState
    extends State<ReverseGeoCodingTextFormField> {
  @override
  void initState() {
    initialize();
    super.initState();
  }

  initialize() async {
    await geocoding.GeocodingPlatform.instance
        .placemarkFromCoordinates(widget.latitude, widget.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: deviceWidth(context) * 0.9,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(width: 1, color: Colors.amber),
          color: Colors.blue),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Location From Map",
              style: CommonStyles.whiteText15BoldW500(),
            ),
          ),
          FutureBuilder<List<geocoding.Placemark>>(
              future: geocoding.GeocodingPlatform.instance
                  .placemarkFromCoordinates(widget.latitude, widget.longitude),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: SizedBox(
                      height: 25,
                      width: 25,
                      child: CircularProgressIndicator(
                        strokeWidth: 1,
                      ),
                    ),
                  );
                }
                if (snapshot.data != null) {
                  widget.controllerAddress.text = snapshot.data!.first.street! +
                      ", " +
                      snapshot.data!.first.subLocality! +
                      ", " +
                      snapshot.data!.first.locality! +
                      ", " +
                      snapshot.data!.first.postalCode! +
                      ", " +
                      snapshot.data!.first.administrativeArea!;
                  final url = "https://www.google.co.in/maps/@" +
                      widget.latitude.toString() +
                      "," +
                      widget.longitude.toString() +
                      ",19z";
                  print(url);
                } else {
                  widget.controllerAddress.text = "No Address Found";
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        child: Text(
                          widget.controllerAddress.text,
                          style: CommonStyles.whiteText12BoldW500(),
                        ),
                      ),
                    ),
                  ],
                );
              }),
        ],
      ),
    );
  }
}

class ChangeMapsStateProvider with ChangeNotifier {
  double _latitude = 0.00;
  double _longitude = 0.00;

  void setLatitudeLongitude(double latitude, double longitude) {
    _latitude = latitude;
    _longitude = longitude;
    notifyListeners();
  }

  double get latitude => _latitude;

  double get longitude => _longitude;
}

class LocationReviewPage extends StatefulWidget {
  const LocationReviewPage({Key? key}) : super(key: key);

  @override
  _LocationReviewPageState createState() => _LocationReviewPageState();
}

class _LocationReviewPageState extends State<LocationReviewPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
