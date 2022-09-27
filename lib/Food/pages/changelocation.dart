import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mycityapp/Food/CommonWidgets/utils.dart';
import 'package:mycityapp/Food/Models/edit_profile_models.dart';
import 'package:mycityapp/Food/Services/ApiServices.dart';
import 'package:mycityapp/Food/Services/profile_view_api_provider.dart';
import 'package:mycityapp/Food/pages/homePage/Home.dart';
import 'package:mycityapp/Food/pages/ui_helper.dart';
import 'package:mycityapp/Food/pages/utils/loaction_shared_preference.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Services/login_api_provider.dart';
import '../Services/profile_update_api_provider.dart';

class MapSample extends StatefulWidget {
  final dynamic latitude;
  final dynamic longitude;
  final bool isProceed;
  final bool initialLogin;
  final String userName;
  final String phoneNumber;
  final String email;
  MapSample(
      {this.latitude,
      this.longitude,
      this.isProceed = false,
      this.initialLogin = false,
      this.userName = "",
      this.phoneNumber = "",
      this.email = ""});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  GoogleMapController? mapController;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  CameraPosition? _initialLocation;

  dynamic currentAddress,
      currentAddressNew,
      myaddress,
      newlatvalue,
      newlongvalue;
  List<Placemark>? placemarks;
  Placemark? place;
  double? newlat, newlang, newlats, cameraMovenewlat, cameraMovenewlong;
  CameraPosition? cameraMove;
  // MapPickerController mapPickerController = MapPickerController();

  final _formKey = GlobalKey<FormBuilderState>();

  TextEditingController addressController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();

  TextEditingController reachController = TextEditingController();

  TextEditingController floorController = TextEditingController();

  dynamic typeId;

  @override
  void initState() {
    super.initState();
    _setLocation(
      widget.latitude,
      widget.longitude,
    );
  }

  @override
  void dispose() {
    addressController.dispose();
    landmarkController.dispose();
    reachController.dispose();
    floorController.dispose();
    super.dispose();
  }

  _setLocation(dynamic lat, dynamic long) async {
    _initialLocation = CameraPosition(
        target: LatLng(
          SharedPreference.latitude,
          SharedPreference.longitude,
        ),
        zoom: 15);
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);

    Placemark place = placemarks[0];

    setState(() {
      currentAddress = "${place.subLocality}";
      currentAddressNew = "${place.name},${place.locality},${place.country}";
    });
    print("${currentAddress} ");
  }

  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Container(
      height: height,
      width: width,
      child: Scaffold(
        key: _scaffoldKey,
        body: Stack(
          children: [
            // MapPicker(
            //   // pass icon widget
            //   iconWidget: Icon(
            //     Icons.location_pin,
            //     size: 50,
            //     color: Color(0xFF16264C),
            //   ),
            //   //add map picker controller
            //   mapPickerController: mapPickerController,
            // child:
            GoogleMap(
              zoomControlsEnabled: true,
              // hide location button
              myLocationButtonEnabled: true,
              mapType: MapType.normal,
              //  camera position
              initialCameraPosition: _initialLocation!,
              onMapCreated: (GoogleMapController controller) {
                mapController = controller;
              },
              onCameraMoveStarted: () {
                // notify map is moving
                // mapPickerController.mapMoving();
              },
              onCameraMove: (cameraPosition) async {
                this._initialLocation = cameraPosition;
                cameraMovenewlat = cameraPosition.target.latitude;
                cameraMovenewlong = cameraPosition.target.longitude;
                setState(() {
                  _setLocation(
                    cameraMovenewlat,
                    cameraMovenewlong,
                  );
                });
              },
              onCameraIdle: () async {
                // notify map stopped moving
                // mapPickerController.mapFinishedMoving();
                //get address name from camera position
                List<Placemark> addresses = await GeocodingPlatform.instance
                    .placemarkFromCoordinates(_initialLocation!.target.latitude,
                        _initialLocation!.target.longitude);
                // update the ui with the address
                textController.text =
                    '${addresses.first.subAdministrativeArea ?? ''}';
              },
            ),

            DraggableScrollableSheet(
              initialChildSize: .27,
              minChildSize: .27,
              maxChildSize: .6,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return StatefulBuilder(builder: (context, state) {
                  return Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "SELECT DELIVERY LOCATION",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold),
                              ),
                              UIHelper.verticalSpaceMedium(),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: Colors.yellow[900],
                                  ),
                                  UIHelper.horizontalSpaceSmall(),
                                  currentAddress != null
                                      ? Text(
                                          currentAddress,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        )
                                      : Container(),
                                ],
                              ),
                              UIHelper.verticalSpaceLarge(),
                              currentAddress != null
                                  ? Text(currentAddressNew)
                                  : Container(),
                              // Text(currentAddress),
                              // Padding(
                              //   padding: const EdgeInsets.all(8.0),
                              //   child: Column(
                              //     children: [
                              //       Text(newlat.toString()),
                              //       Text(newlang.toString()),
                              //     ],
                              //   ),
                              // ),
                              UIHelper.verticalSpaceMedium(),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 8.0, right: 8),
                                child: currentAddress != null
                                    ? widget.isProceed
                                        ? InkWell(
                                            onTap: () async {
                                              double latValue =
                                                  cameraMovenewlat != null
                                                      ? cameraMovenewlat!
                                                      : widget.latitude;
                                              double lngValue =
                                                  cameraMovenewlat != null
                                                      ? cameraMovenewlong!
                                                      : widget.longitude;
                                              List<Placemark> placemarks =
                                                  await placemarkFromCoordinates(
                                                      latValue, lngValue);

                                              Placemark place = placemarks[0];

                                              var saveAddressField =
                                                  "${place.street} ${place.subLocality},${place.locality},${place.subAdministrativeArea}";
                                              final popNavigation =
                                                  await showModalBottomSheet(
                                                      isScrollControlled: true,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        10),
                                                                topRight: Radius
                                                                    .circular(
                                                                        10)),
                                                      ),
                                                      context: context,
                                                      builder:
                                                          (BuildContext ctxt) {
                                                        return Container(
                                                          padding: EdgeInsets.only(
                                                              bottom: MediaQuery
                                                                      .of(ctxt)
                                                                  .viewInsets
                                                                  .bottom),
                                                          child:
                                                              SingleChildScrollView(
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: <
                                                                  Widget>[
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      top: 8.0,
                                                                      bottom: 8,
                                                                      left: 5),
                                                                  child: Text(
                                                                    'Enter address details',
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .headline6!
                                                                        .copyWith(
                                                                            fontSize:
                                                                                17.0),
                                                                  ),
                                                                ),
                                                                FormBuilder(
                                                                  key: _formKey,
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child:
                                                                        Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .min,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                          "Your location"
                                                                              .toUpperCase(),
                                                                          style: TextStyle(
                                                                              color: Colors.grey,
                                                                              fontSize: 13),
                                                                        ),
                                                                        UIHelper
                                                                            .verticalSpaceSmall(),
                                                                        Container(
                                                                            width: MediaQuery.of(context).size.width *
                                                                                0.9,
                                                                            child:
                                                                                Text(
                                                                              saveAddressField,
                                                                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                                                                            )),
                                                                        UIHelper
                                                                            .verticalSpaceSmall(),
                                                                        Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(5.0),
                                                                          child:
                                                                              FormBuilderTextField(
                                                                            name:
                                                                                'address',
                                                                            validator:
                                                                                (value) {
                                                                              if (value!.isEmpty) {
                                                                                return "Please insert correct value";
                                                                              }
                                                                              return null;
                                                                            },
                                                                            decoration:
                                                                                InputDecoration(
                                                                              contentPadding: EdgeInsets.all(5), //  <- you can it to 0.0 for no space
                                                                              isDense: true,
                                                                              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                                                                              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red[400]!)),
                                                                              labelText: "Complete Address (Mandatory)",
                                                                            ),
                                                                            controller:
                                                                                addressController,
                                                                          ),
                                                                        ),
                                                                        UIHelper
                                                                            .verticalSpaceSmall(),
                                                                        Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(5.0),
                                                                          child:
                                                                              FormBuilderTextField(
                                                                            name:
                                                                                'land_mark',
                                                                            validator:
                                                                                (value) {
                                                                              if (value!.isEmpty) {
                                                                                return "Please insert correct value";
                                                                              }
                                                                              return null;
                                                                            },
                                                                            decoration:
                                                                                InputDecoration(
                                                                              contentPadding: EdgeInsets.all(5), //  <- you can it to 0.0 for no space
                                                                              isDense: true,
                                                                              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                                                                              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red[400]!)),
                                                                              labelText: "Nearby landmark (Mandatory)",
                                                                            ),
                                                                            controller:
                                                                                landmarkController,
                                                                          ),
                                                                        ),
                                                                        UIHelper
                                                                            .verticalSpaceSmall(),
                                                                        Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(5.0),
                                                                          child:
                                                                              FormBuilderTextField(
                                                                            name:
                                                                                'floor',
                                                                            // validator:
                                                                            //     (value) {
                                                                            //   if (value!
                                                                            //       .isEmpty) {
                                                                            //     return "Please insert correct value";
                                                                            //   }
                                                                            //   return null;
                                                                            // },
                                                                            decoration:
                                                                                InputDecoration(
                                                                              contentPadding: EdgeInsets.all(5), //  <- you can it to 0.0 for no space
                                                                              isDense: true,
                                                                              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                                                                              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red[400]!)),
                                                                              labelText: "Floor (Optional)",
                                                                            ),
                                                                            controller:
                                                                                floorController,
                                                                          ),
                                                                        ),
                                                                        UIHelper
                                                                            .verticalSpaceSmall(),
                                                                        Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(5.0),
                                                                          child:
                                                                              FormBuilderTextField(
                                                                            name:
                                                                                'reach',
                                                                            decoration:
                                                                                InputDecoration(
                                                                              contentPadding: EdgeInsets.all(5), //  <- you can it to 0.0 for no space
                                                                              isDense: true,
                                                                              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                                                                              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red[400]!)),
                                                                              labelText: "How to reach (Optional)",
                                                                            ),
                                                                            controller:
                                                                                reachController,
                                                                          ),
                                                                        ),
                                                                        /*      FormBuilderChoiceChip(
                                                            spacing:
                                                            10,
                                                            onChanged:
                                                                (dynamic val) {
                                                              typeId =
                                                                  val;
                                                            },
                                                            validator:
                                                                (val) {},
                                                            name:
                                                            'type',
                                                            decoration:
                                                            InputDecoration(
                                                              labelText:
                                                              'Tag this location for later (Mandatory)',
                                                            ),
                                                            options: [
                                                              FormBuilderFieldOption(
                                                                  value: '1',
                                                                  child: Padding(
                                                                    padding: const EdgeInsets.all(5.0),
                                                                    child: Text('Home'),
                                                                  )),
                                                              FormBuilderFieldOption(
                                                                  value: '2',
                                                                  child: Padding(
                                                                    padding: const EdgeInsets.all(5.0),
                                                                    child: Text('Work'),
                                                                  )),
                                                              FormBuilderFieldOption(
                                                                  value: '3',
                                                                  child: Padding(
                                                                    padding: const EdgeInsets.all(5.0),
                                                                    child: Text('Other'),
                                                                  )),
                                                            ],
                                                          ),*/
                                                                        GestureDetector(
                                                                          onTap:
                                                                              () async {
                                                                            _formKey.currentState!.save();
                                                                            if (_formKey.currentState!.validate() &&
                                                                                typeId != null) {
                                                                              double? lat = cameraMovenewlat != null ? cameraMovenewlat : widget.latitude;
                                                                              double? long = cameraMovenewlong != null ? cameraMovenewlong : widget.longitude;

                                                                              Utils.showLoaderDialog(context);
                                                                              await apiService.editSearchAddress(type: typeId, address: addressController.text, land_mark: landmarkController.text, floor: floorController.text, reach: reachController.text, lat: lat, long: long).then((value) async {
                                                                                print("Vlaue -         -------" + value.toString());
                                                                                if (widget.initialLogin) {
                                                                                  // final loggedInUser = Provider.of<LoggedInUser>(
                                                                                  //     context,
                                                                                  //     listen: false);

                                                                                  // await context.read<VerifyUserLoginAPIProvider>().getUser(
                                                                                  //     deviceToken: "deviceToken",
                                                                                  //     userFirebaseID: loggedInUser.uid,
                                                                                  //     phoneNumber: loggedInUser.phoneNo);
                                                                                  // ApiServices.userId = ApiServices.userdata = context
                                                                                  //     .read<VerifyUserLoginAPIProvider>()
                                                                                  //     .loginResponse!
                                                                                  //     .driverDetails!
                                                                                  //     .id!;
                                                                                  await context.read<EditUserProfileAPIProvider>().updateProfileRequest(editProfileRequestModel: EditProfileRequestModel(address: addressController.text, email: widget.email, lat: lat.toString(), long: long.toString(), mobile: "+91 " + widget.phoneNumber, userName: widget.userName, userId: context.read<VerifyUserLoginAPIProvider>().loginResponse!.driverDetails!.id!)).then((value) async {
                                                                                    print("----------____------");
                                                                                  });
                                                                                  await apiService.selectAddress(typeId);

                                                                                  // if (context.read<VerifyUserLoginAPIProvider>().loginResponse ==
                                                                                  //     null) {
                                                                                  //   await SharedPreferences.getInstance().then((value) {
                                                                                  //     value.setString("userID", context.read<VerifyUserLoginAPIProvider>().loginResponse!.driverDetails!.id!);
                                                                                  //   });
                                                                                  // }
                                                                                  Navigator.of(context).pop();

                                                                                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeBottomNavigationScreen()));
                                                                                } else {
                                                                                  if (value['status'] == true) {
                                                                                    // await context.read<EditUserProfileAPIProvider>().updateProfileRequest(editProfileRequestModel: EditProfileRequestModel(address: addressController.text, email: widget.email, lat: lat.toString(), long: long.toString(), mobile: "+91 " + widget.phoneNumber, userName: widget.userName, userId: context.read<VerifyUserLoginAPIProvider>().loginResponse!.driverDetails!.id!)).then((value) async {
                                                                                    //   print("----------____------");
                                                                                    // });
                                                                                    await apiService.selectAddress(typeId);

                                                                                    await context.read<ProfileViewApiProvider>().getProfileView();
                                                                                    // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ModelCartScreen("")));
                                                                                    Navigator.of(context).pop("pop");
                                                                                    Navigator.of(context).pop("pop");
                                                                                  }
                                                                                }
                                                                              });
                                                                            } else {
                                                                              if (typeId == null) {
                                                                                Utils.showSnackBar(context: ctxt, text: "Please tag a location.");
                                                                              }
                                                                            }
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                MediaQuery.of(context).size.width,
                                                                            decoration:
                                                                                BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.yellow[900]),
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.all(10.0),
                                                                              child: Center(
                                                                                  child: Text(
                                                                                "Save Address",
                                                                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),
                                                                              )),
                                                                            ),
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      });

                                              if (popNavigation == "pop") {
                                                Navigator.of(context)
                                                    .pop("pop");
                                              }
                                            },
                                            child: Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                    color: Colors.yellow[900]),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Center(
                                                      child: Text(
                                                    "Confirm Location & Proceed"
                                                        .toUpperCase(),
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                                )),
                                          )
                                        : InkWell(
                                            onTap: () async {
                                              double latValue =
                                                  cameraMovenewlat != null
                                                      ? cameraMovenewlat!
                                                      : widget.latitude;
                                              double lngValue =
                                                  cameraMovenewlat != null
                                                      ? cameraMovenewlong!
                                                      : widget.longitude;
                                              SharedPreference.getLocationData(
                                                  latValue, lngValue);
                                              SharedPreferences
                                                  sharedPreference =
                                                  await SharedPreferences
                                                      .getInstance();
                                              sharedPreference.setDouble(
                                                  "LATITUDE", latValue);
                                              newlatvalue = sharedPreference
                                                  .getDouble("LATITUDE");
                                              sharedPreference.setDouble(
                                                  "LONGITUDE", lngValue);
                                              newlongvalue = sharedPreference
                                                  .getDouble("LONGITUDE");
                                              Navigator.of(context).pop("set");
                                            },
                                            child: Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                    color: Colors.yellow[900]),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Center(
                                                      child: Text(
                                                    "Confirm Location"
                                                        .toUpperCase(),
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                                )),
                                          )
                                    : InkWell(
                                        onTap: () async {
                                          double latValue =
                                              cameraMovenewlat != null
                                                  ? cameraMovenewlat!
                                                  : widget.latitude;
                                          double lngValue =
                                              cameraMovenewlat != null
                                                  ? cameraMovenewlong!
                                                  : widget.longitude;
                                          SharedPreference.getLocationData(
                                              latValue, lngValue);
                                          SharedPreferences sharedPreference =
                                              await SharedPreferences
                                                  .getInstance();
                                          sharedPreference.setDouble(
                                              "LATITUDE", latValue);
                                          newlatvalue = sharedPreference
                                              .getDouble("LATITUDE");
                                          sharedPreference.setDouble(
                                              "LONGITUDE", lngValue);
                                          newlongvalue = sharedPreference
                                              .getDouble("LONGITUDE");
                                          Navigator.of(context).pop("set");
                                          // Navigator.pop(context, "set");
                                        },
                                        child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                                color: Colors.yellow[900]),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Center(
                                                  child: Text(
                                                "Confirm Location"
                                                    .toUpperCase(),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                            )),
                                      ),
                              ),
                            ],
                          ),
                        ),
                      ));
                });
              },
            ),
            Align(
              alignment: Alignment.center,
              child: Icon(
                FontAwesomeIcons.mapPin,
                color: Colors.yellow[900],
                size: 28,
              ),
            )

            // GoogleMap(
            //   mapType: MapType.normal,
            //   myLocationEnabled: true,
            //   // markers: Set<Marker>.from(startMarker),
            //   myLocationButtonEnabled: false,
            //   // zoomGesturesEnabled: true,
            //   initialCameraPosition: _initialLocation,
            //   onMapCreated: (GoogleMapController controller) {
            //     mapController = controller;
            //   },
            // ),
          ],
        ),
      ),
    );
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
}
