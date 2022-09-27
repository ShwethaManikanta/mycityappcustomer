import 'package:flutter/material.dart';
import 'package:mycityapp/Cab/Services/api_services.dart';
import 'package:mycityapp/Food/CommonWidgets/common_styles.dart';
import 'package:mycityapp/Food/CommonWidgets/utils.dart';
import 'package:provider/provider.dart';
import 'package:mycityapp/Food/Models/edit_profile_models.dart';
import 'package:mycityapp/Food/Services/firebase_auth_service.dart';
import 'package:mycityapp/Food/Services/profile_update_api_provider.dart';
import 'package:mycityapp/Food/pages/changelocation.dart';
import 'package:mycityapp/Food/pages/homePage/Home.dart';
import 'package:mycityapp/Food/pages/utils/loaction_shared_preference.dart';

class LocationInitialize extends StatefulWidget {
  const LocationInitialize({Key? key}) : super(key: key);

  @override
  _LocationInitializeState createState() => _LocationInitializeState();
}

class _LocationInitializeState extends State<LocationInitialize> {
  @override
  void initState() {
    super.initState();
    SharedPreference.setValues().then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    if (SharedPreference.initializeSharedPreference ==
        InitializeSharedPreference.uninitialize) {
      return ifLoading();
    } else {
      return HomeBottomNavigationScreen();
    }
  }

  ifLoading() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircularProgressIndicator(
          strokeWidth: 0.5,
          color: Colors.blue,
        ),
        Utils.getSizedBox(height: 10),
        Text(
          'Loading',
          style: CommonStyles.blueText12BoldW500(),
        )
      ],
    );
  }
}

class GetUserNameAndLocation extends StatefulWidget {
  const GetUserNameAndLocation({Key? key, this.isSkipLoginCheck = false})
      : super(key: key);
  final bool isSkipLoginCheck;
  @override
  _GetUserNameState createState() => _GetUserNameState();
}

class _GetUserNameState extends State<GetUserNameAndLocation> {
  bool showNextScreen = false;
  String? deviceToken;

  final formKey = GlobalKey<FormState>();
  final nameKey = GlobalKey<FormState>();
  final phoneNumberKey = GlobalKey<FormState>();
  final emailKey = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();

  TextEditingController phoneNumberController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  PageController pageController = PageController();

  bool isLocationInitialized = false;

  bool nameVerified = false, emailVerified = false, phoneNumberVerified = false;

  @override
  void initState() {
    initialize();
    initializeNameNumber();
    super.initState();
  }

  initializeNameNumber() {
    final loggedInUser = Provider.of<LoggedInUser>(context, listen: false);
    name.text = loggedInUser.name;
    phoneNumberController.text = loggedInUser.phoneNo.length > 9
        ? loggedInUser.phoneNo.substring(3, loggedInUser.phoneNo.length)
        : loggedInUser.phoneNo;
    if (loggedInUser.phoneNo.length > 10) {
      if (loggedInUser.phoneNo
              .substring(3, loggedInUser.phoneNo.length)
              .length ==
          10) {
        phoneNumberVerified = true;
      }
    }

    emailController.text = loggedInUser.email;
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if (regex.hasMatch(loggedInUser.email)) {
      setState(() {
        emailVerified = true;
      });
    }
    name.text = loggedInUser.name;
    if (loggedInUser.name != "NA" && loggedInUser.name.length > 3) {
      nameVerified = true;
    }
    print(nameVerified.toString() +
        "-------" +
        emailVerified.toString() +
        "-------" +
        phoneNumberVerified.toString());

    setState(() {});
  }

  initialize() async {
    await SharedPreference.setValues().whenComplete(() {
      setState(() {
        isLocationInitialized = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Utils.showSnackBar(
            context: context,
            text:
                "We need these details to make delivery smoother. Please give valid Details.");
        return false;
      },
      child: Scaffold(
        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: pageController,
          children: [
            customerName()

            // , selectLocationPage()
          ],
        ),
      ),
    );
  }

  selectLocationPage() {
    if (!isLocationInitialized) {
      return Center(
        child: Utils.showLoadingCustomText("Loading Please Wait", context),
      );
    }
    return MapSample(
      latitude: SharedPreference.latitudeValue,
      longitude: SharedPreference.longitudeValue,
      isProceed: true,
      initialLogin: true,
      userName: name.text,
      email: emailController.text,
      phoneNumber: phoneNumberController.text,
    );
  }

  customerName() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Row(
          //   children: [
          //     InkWell(
          //         onTap: () {
          //           Navigator.of(context).pop();
          //         },
          //         child: Icon(FontAwesomeIcons.arrowLeft))
          //   ],
          // ),
          SizedBox(
            height: 80,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Text(
              "Step 1 of 1 : Add Personal Details",
              style: CommonStyles.black12(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Text(
              "Adding these details is a one time process. Next time, checkout will be a breeze",
              maxLines: 2,
              style: CommonStyles.blackw54s9Thin(),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Form(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10),
              child: TextFormField(
                controller: phoneNumberController,
                onChanged: (value) {
                  if (value.length == 10) {
                    setState(() {
                      phoneNumberVerified = true;
                    });
                  } else {
                    setState(() {
                      phoneNumberVerified = false;
                    });
                  }
                },
                maxLength: 10,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                    prefix: Text(
                      "+91  ",
                      style: CommonStyles.blackS15(),
                    ),
                    counterText: "",
                    hintStyle: CommonStyles.blackw54s9Thin(),
                    hintText: "Phone Number",
                    errorStyle: CommonStyles.green9()),
                validator: (value) {
                  if (value!.isEmpty || value.length != 10) {
                    return "Please enter valid phone number";
                  }
                  return null;
                },
              ),
            ),
            key: phoneNumberKey,
          ),
          Utils.getSizedBox(height: 20),
          Form(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10),
              child: TextFormField(
                controller: name,
                // autovalidateMode: true,
                autovalidateMode: AutovalidateMode.onUserInteraction,

                onChanged: (value) {
                  if (value.length >= 3) {
                    setState(() {
                      nameVerified = true;
                    });
                    print("Is name verified" + nameVerified.toString());
                  } else {
                    setState(() {
                      nameVerified = false;
                    });
                  }
                },
                decoration: InputDecoration(
                    hintStyle: CommonStyles.blackw54s9Thin(),
                    hintText: "Name",
                    errorStyle: CommonStyles.green9()),
                validator: (value) {
                  if (value!.isEmpty || value.length <= 2) {
                    return "Minimum Length is 3";
                  }
                  return null;
                },
              ),
            ),
            key: nameKey,
          ),
          Utils.getSizedBox(height: 20),
          Form(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10),
              child: TextFormField(
                controller: emailController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onChanged: (value) {
                  RegExp regex = RegExp(
                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
                  //   String pattern =
                  //       r'/^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i';
                  // = RegExp(pattern);
                  if (regex.hasMatch(value)) {
                    setState(() {
                      emailVerified = true;
                    });
                  } else {
                    setState(() {
                      emailVerified = false;
                    });
                  }
                  print("email virified" + emailVerified.toString());
                },
                decoration: InputDecoration(
                    hintStyle: CommonStyles.blackw54s9Thin(),
                    hintText: "Email",
                    errorStyle: CommonStyles.green9()),
                validator: (value) {
                  String pattern =
                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                  RegExp regex = RegExp(pattern);
                  if (!regex.hasMatch(value!)) {
                    return "Enter Valid email";
                  }
                  return null;
                },
              ),
            ),
            key: emailKey,
          ),
          Utils.getSizedBox(height: 20),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
              child: MaterialButton(
                elevation: 18.0,
                //Wrap with Material
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0)),
                minWidth: 100.0,
                height: 45,
                color: nameVerified && emailVerified && phoneNumberVerified
                    ? Color(0xFF801E48)
                    : Colors.grey,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    new Text('Next', style: CommonStyles.whiteText12BoldW500()),
                    Utils.getSizedBox(width: 10),
                    Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    )
                  ],
                ),
                onPressed: nameVerified && emailVerified && phoneNumberVerified
                    ? () async {
                        //                                                           Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeBottomNavigationScreen()));
                        showLoadDialog(context);

                        await SharedPreference.setValues();

                        if (nameKey.currentState!.validate() &&
                            emailKey.currentState!.validate() &&
                            phoneNumberKey.currentState!.validate()) {
                          print(phoneNumberController.text + "--------");
                          await context
                              .read<EditUserProfileAPIProvider>()
                              .updateProfileRequest(
                                  editProfileRequestModel:
                                      EditProfileRequestModel(
                                          address: SharedPreference.address
                                              .toString(),
                                          email:
                                              emailController.text.toString(),
                                          lat: SharedPreference.latitudeValue
                                              .toString(),
                                          long: SharedPreference.longitudeValue
                                              .toString(),
                                          mobile: "+91 " +
                                              phoneNumberController.text
                                                  .toString(),
                                          userName: name.text,
                                          userId: ApiServices.userId!))
                              .whenComplete(() async {
                            print("----------____------");
                            if (widget.isSkipLoginCheck) {
                              Navigator.of(context).pop();
                            }
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        HomeBottomNavigationScreen(
                                          pageIndex: 2,
                                        )));
                          });
                          // await apiServices.selectAddress(typeId);

                          // if (context.read<VerifyUserLoginAPIProvider>().loginResponse ==
                          //     null) {
                          //   await SharedPreferences.getInstance().then((value) {
                          //     value.setString("userID", context.read<VerifyUserLoginAPIProvider>().loginResponse!.driverDetails!.id!);
                          //   });
                          // }
                          // FocusManager.instance.primaryFocus?.unfocus();
                          // nameKey.currentState!.save();
                          // pageController.nextPage(
                          //     duration: Duration(milliseconds: 150),
                          //     curve: Curves.ease);
                        }
                      }
                    : () {
                        // pageController.nextPage(
                        //     duration: Duration(milliseconds: 150),
                        //     curve: Curves.ease);
                        print(nameVerified.toString() +
                            "-------" +
                            emailVerified.toString() +
                            "-------" +
                            phoneNumberVerified.toString());
                      },
              ),
            ),
          )
        ],
      ),
    );
  }

// selectLocation() {
//   var height = MediaQuery.of(context).size.height;
//   var width = MediaQuery.of(context).size.width;
//   var textController = TextEditingController();
//   return Container(
//     height: height,
//     width: width,
//     child: Scaffold(
//       body: Stack(
//         children: [
//           // MapPicker(
//           //   // pass icon widget
//           //   iconWidget: Icon(
//           //     Icons.location_pin,
//           //     size: 50,
//           //     color: Color(0xFF16264C),
//           //   ),
//           //   //add map picker controller
//           //   mapPickerController: mapPickerController,
//           // child:
//           GoogleMap(
//             zoomControlsEnabled: true,
//             // hide location button
//             myLocationButtonEnabled: true,
//             mapType: MapType.normal,
//             //  camera position
//             initialCameraPosition: _initialLocation!,
//             onMapCreated: (GoogleMapController controller) {
//               mapController = controller;
//             },
//             onCameraMoveStarted: () {
//               // notify map is moving
//               // mapPickerController.mapMoving();
//             },
//             onCameraMove: (cameraPosition) async {
//               this._initialLocation = cameraPosition;
//               cameraMovenewlat = cameraPosition.target.latitude;
//               cameraMovenewlong = cameraPosition.target.longitude;
//               setState(() {
//                 _setLocation(
//                   cameraMovenewlat,
//                   cameraMovenewlong,
//                 );
//               });
//               print("${currentAddress} ");
//             },
//             onCameraIdle: () async {
//               // notify map stopped moving
//               // mapPickerController.mapFinishedMoving();
//               //get address name from camera position
//               List<Placemark> addresses = await GeocodingPlatform.instance
//                   .placemarkFromCoordinates(_initialLocation!.target.latitude,
//                       _initialLocation!.target.longitude);
//               // update the ui with the address
//               textController.text =
//                   '${addresses.first.subAdministrativeArea ?? ''}';
//             },
//           ),
//           // ),

//           DraggableScrollableSheet(
//             initialChildSize: .27,
//             minChildSize: .27,
//             maxChildSize: .6,
//             builder:
//                 (BuildContext context, ScrollController scrollController) {
//               return StatefulBuilder(builder: (context, state) {
//                 return Container(
//                     color: Colors.white,
//                     child: Padding(
//                       padding: const EdgeInsets.all(8),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "SELECT DELIVERY LOCATION",
//                             style: TextStyle(
//                                 color: Colors.grey,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                           UIHelper.verticalSpaceMedium(),
//                           Row(
//                             children: [
//                               Icon(
//                                 Icons.location_on,
//                                 color: swiggyOrange,
//                               ),
//                               UIHelper.horizontalSpaceSmall(),
//                               currentAddress != null
//                                   ? Text(
//                                       currentAddress,
//                                       style: TextStyle(
//                                           color: Colors.black,
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 18),
//                                     )
//                                   : Container(),
//                             ],
//                           ),
//                           UIHelper.verticalSpaceLarge(),
//                           currentAddress != null
//                               ? Text(currentAddressNew)
//                               : Container(),
//                           // Text(currentAddress),
//                           // Padding(
//                           //   padding: const EdgeInsets.all(8.0),
//                           //   child: Column(
//                           //     children: [
//                           //       Text(newlat.toString()),
//                           //       Text(newlang.toString()),
//                           //     ],
//                           //   ),
//                           // ),
//                           UIHelper.verticalSpaceMedium(),
//                           Padding(
//                             padding:
//                                 const EdgeInsets.only(left: 8.0, right: 8),
//                             child: currentAddress != null
//                                 ? widget.isProceed
//                                     ? InkWell(
//                                         onTap: () async {
//                                           double latValue =
//                                               cameraMovenewlat != null
//                                                   ? cameraMovenewlat!
//                                                   : widget.latitude;
//                                           double lngValue =
//                                               cameraMovenewlat != null
//                                                   ? cameraMovenewlong!
//                                                   : widget.longitude;
//                                           List<Placemark> placemarks =
//                                               await placemarkFromCoordinates(
//                                                   latValue, lngValue);

//                                           Placemark place = placemarks[0];

//                                           var saveAddressField =
//                                               "${place.street} ${place.subLocality},${place.locality},${place.subAdministrativeArea}";
//                                           await showModalBottomSheet(
//                                               isScrollControlled: true,
//                                               shape: RoundedRectangleBorder(
//                                                 borderRadius:
//                                                     BorderRadius.circular(
//                                                         10.0),
//                                               ),
//                                               context: context,
//                                               builder: (builder) {
//                                                 return Padding(
//                                                   padding: EdgeInsets.only(
//                                                       bottom: MediaQuery.of(
//                                                               context)
//                                                           .viewInsets
//                                                           .bottom),
//                                                   child: Wrap(
//                                                     children: [
//                                                       Padding(
//                                                         padding:
//                                                             EdgeInsets.all(8),
//                                                         child: Column(
//                                                           crossAxisAlignment:
//                                                               CrossAxisAlignment
//                                                                   .start,
//                                                           mainAxisSize:
//                                                               MainAxisSize
//                                                                   .min,
//                                                           children: <Widget>[
//                                                             Padding(
//                                                               padding:
//                                                                   const EdgeInsets
//                                                                           .only(
//                                                                       top:
//                                                                           8.0,
//                                                                       bottom:
//                                                                           8,
//                                                                       left:
//                                                                           5),
//                                                               child: Text(
//                                                                 'Enter address details',
//                                                                 style: Theme.of(
//                                                                         context)
//                                                                     .textTheme
//                                                                     .headline6!
//                                                                     .copyWith(
//                                                                         fontSize:
//                                                                             17.0),
//                                                               ),
//                                                             ),
//                                                             FormBuilder(
//                                                               key: _formKey,
//                                                               child: Padding(
//                                                                 padding:
//                                                                     const EdgeInsets
//                                                                             .all(
//                                                                         8.0),
//                                                                 child: Column(
//                                                                   mainAxisAlignment:
//                                                                       MainAxisAlignment
//                                                                           .start,
//                                                                   crossAxisAlignment:
//                                                                       CrossAxisAlignment
//                                                                           .start,
//                                                                   children: [
//                                                                     Text(
//                                                                       "Your location"
//                                                                           .toUpperCase(),
//                                                                       style: TextStyle(
//                                                                           color:
//                                                                               Colors.grey,
//                                                                           fontSize: 13),
//                                                                     ),
//                                                                     UIHelper
//                                                                         .verticalSpaceSmall(),
//                                                                     Container(
//                                                                         width: MediaQuery.of(context).size.width *
//                                                                             0.9,
//                                                                         child:
//                                                                             Text(
//                                                                           saveAddressField,
//                                                                           style:
//                                                                               TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
//                                                                         )),
//                                                                     UIHelper
//                                                                         .verticalSpaceSmall(),
//                                                                     Padding(
//                                                                       padding:
//                                                                           const EdgeInsets.all(5.0),
//                                                                       child:
//                                                                           FormBuilderTextField(
//                                                                         name:
//                                                                             'address',
//                                                                         decoration:
//                                                                             InputDecoration(
//                                                                           contentPadding:
//                                                                               EdgeInsets.all(5), //  <- you can it to 0.0 for no space
//                                                                           isDense:
//                                                                               true,
//                                                                           enabledBorder:
//                                                                               UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
//                                                                           focusedBorder:
//                                                                               UnderlineInputBorder(borderSide: BorderSide(color: Colors.red[400]!)),
//                                                                           labelText:
//                                                                               "Complete Address",
//                                                                         ),
//                                                                         controller:
//                                                                             addressController,
//                                                                       ),
//                                                                     ),
//                                                                     UIHelper
//                                                                         .verticalSpaceSmall(),
//                                                                     Padding(
//                                                                       padding:
//                                                                           const EdgeInsets.all(5.0),
//                                                                       child:
//                                                                           FormBuilderTextField(
//                                                                         name:
//                                                                             'land_mark',
//                                                                         decoration:
//                                                                             InputDecoration(
//                                                                           contentPadding:
//                                                                               EdgeInsets.all(5), //  <- you can it to 0.0 for no space
//                                                                           isDense:
//                                                                               true,
//                                                                           enabledBorder:
//                                                                               UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
//                                                                           focusedBorder:
//                                                                               UnderlineInputBorder(borderSide: BorderSide(color: Colors.red[400]!)),
//                                                                           labelText:
//                                                                               "Nearby landmark (Optional)",
//                                                                         ),
//                                                                         controller:
//                                                                             landmarkController,
//                                                                       ),
//                                                                     ),
//                                                                     UIHelper
//                                                                         .verticalSpaceSmall(),
//                                                                     Padding(
//                                                                       padding:
//                                                                           const EdgeInsets.all(5.0),
//                                                                       child:
//                                                                           FormBuilderTextField(
//                                                                         name:
//                                                                             'floor',
//                                                                         decoration:
//                                                                             InputDecoration(
//                                                                           contentPadding:
//                                                                               EdgeInsets.all(5), //  <- you can it to 0.0 for no space
//                                                                           isDense:
//                                                                               true,
//                                                                           enabledBorder:
//                                                                               UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
//                                                                           focusedBorder:
//                                                                               UnderlineInputBorder(borderSide: BorderSide(color: Colors.red[400]!)),
//                                                                           labelText:
//                                                                               "Floor (Optional)",
//                                                                         ),
//                                                                         controller:
//                                                                             floorController,
//                                                                       ),
//                                                                     ),
//                                                                     UIHelper
//                                                                         .verticalSpaceSmall(),
//                                                                     Padding(
//                                                                       padding:
//                                                                           const EdgeInsets.all(5.0),
//                                                                       child:
//                                                                           FormBuilderTextField(
//                                                                         name:
//                                                                             'reach',
//                                                                         decoration:
//                                                                             InputDecoration(
//                                                                           contentPadding:
//                                                                               EdgeInsets.all(5), //  <- you can it to 0.0 for no space
//                                                                           isDense:
//                                                                               true,
//                                                                           enabledBorder:
//                                                                               UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
//                                                                           focusedBorder:
//                                                                               UnderlineInputBorder(borderSide: BorderSide(color: Colors.red[400]!)),
//                                                                           labelText:
//                                                                               "How to reach (Optional)",
//                                                                         ),
//                                                                         controller:
//                                                                             reachController,
//                                                                       ),
//                                                                     ),
//                                                                     FormBuilderChoiceChip(
//                                                                       spacing:
//                                                                           10,
//                                                                       onChanged:
//                                                                           (dynamic
//                                                                               val) {
//                                                                         typeId =
//                                                                             val;
//                                                                       },
//                                                                       name:
//                                                                           'type',
//                                                                       decoration:
//                                                                           InputDecoration(
//                                                                         labelText:
//                                                                             'Tag this location for later',
//                                                                       ),
//                                                                       options: [
//                                                                         FormBuilderFieldOption(
//                                                                             value: '1',
//                                                                             child: Padding(
//                                                                               padding: const EdgeInsets.all(5.0),
//                                                                               child: Text('Home'),
//                                                                             )),
//                                                                         FormBuilderFieldOption(
//                                                                             value: '2',
//                                                                             child: Padding(
//                                                                               padding: const EdgeInsets.all(5.0),
//                                                                               child: Text('Work'),
//                                                                             )),
//                                                                         FormBuilderFieldOption(
//                                                                             value: '3',
//                                                                             child: Padding(
//                                                                               padding: const EdgeInsets.all(5.0),
//                                                                               child: Text('Other'),
//                                                                             )),
//                                                                       ],
//                                                                     ),
//                                                                     GestureDetector(
//                                                                       onTap:
//                                                                           () {
//                                                                         _formKey
//                                                                             .currentState!
//                                                                             .save();
//                                                                         if (_formKey
//                                                                             .currentState!
//                                                                             .validate()) {
//                                                                           double? lat = cameraMovenewlat != null
//                                                                               ? cameraMovenewlat
//                                                                               : widget.latitude;

//                                                                           double? long = cameraMovenewlong != null
//                                                                               ? cameraMovenewlong
//                                                                               : widget.longitude;

//                                                                           apiServices.editSearchAddress(type: typeId, address: addressController.text, land_mark: landmarkController.text, floor: floorController.text, reach: reachController.text, lat: lat, long: long).then((value) {
//                                                                             if (value['status'] == true) {
//                                                                               // Navigator.pushNamed(context, 'CartScreen');
//                                                                               Navigator.of(context).pop("set");
//                                                                             }
//                                                                           });
//                                                                         } else {
//                                                                           print("validation failed");
//                                                                         }
//                                                                       },
//                                                                       child:
//                                                                           Container(
//                                                                         width: MediaQuery.of(context)
//                                                                             .size
//                                                                             .width,
//                                                                         decoration: BoxDecoration(
//                                                                             borderRadius: BorderRadius.circular(5),
//                                                                             color: swiggyOrange),
//                                                                         child:
//                                                                             Padding(
//                                                                           padding:
//                                                                               const EdgeInsets.all(10.0),
//                                                                           child: Center(
//                                                                               child: Text(
//                                                                             "Save Address",
//                                                                             style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),
//                                                                           )),
//                                                                         ),
//                                                                       ),
//                                                                     )
//                                                                   ],
//                                                                 ),
//                                                               ),
//                                                             )
//                                                           ],
//                                                         ),
//                                                       )
//                                                     ],
//                                                   ),
//                                                 );
//                                               });
//                                         },
//                                         child: Container(
//                                             width: MediaQuery.of(context)
//                                                 .size
//                                                 .width,
//                                             decoration: BoxDecoration(
//                                                 borderRadius:
//                                                     BorderRadius.circular(
//                                                         5.0),
//                                                 color: swiggyOrange),
//                                             child: Padding(
//                                               padding:
//                                                   const EdgeInsets.all(8.0),
//                                               child: Center(
//                                                   child: Text(
//                                                 "Confirm Location & Proceed"
//                                                     .toUpperCase(),
//                                                 style: TextStyle(
//                                                     color: Colors.white,
//                                                     fontWeight:
//                                                         FontWeight.bold),
//                                               )),
//                                             )),
//                                       )
//                                     : InkWell(
//                                         onTap: () async {
//                                           double latValue =
//                                               cameraMovenewlat != null
//                                                   ? cameraMovenewlat!
//                                                   : widget.latitude;
//                                           double lngValue =
//                                               cameraMovenewlat != null
//                                                   ? cameraMovenewlong!
//                                                   : widget.longitude;
//                                           SharedPreference.getLocationData(
//                                               latValue, lngValue);
//                                           SharedPreferences sharedPreference =
//                                               await SharedPreferences
//                                                   .getInstance();
//                                           sharedPreference.setDouble(
//                                               "LATITUDE", latValue);
//                                           newlatvalue = sharedPreference
//                                               .getDouble("LATITUDE");
//                                           sharedPreference.setDouble(
//                                               "LONGITUDE", lngValue);
//                                           newlongvalue = sharedPreference
//                                               .getDouble("LONGITUDE");
//                                           Navigator.of(context).pop("set");
//                                         },
//                                         child: Container(
//                                             width: MediaQuery.of(context)
//                                                 .size
//                                                 .width,
//                                             decoration: BoxDecoration(
//                                                 borderRadius:
//                                                     BorderRadius.circular(
//                                                         5.0),
//                                                 color: swiggyOrange),
//                                             child: Padding(
//                                               padding:
//                                                   const EdgeInsets.all(8.0),
//                                               child: Center(
//                                                   child: Text(
//                                                 "Confirm Location"
//                                                     .toUpperCase(),
//                                                 style: TextStyle(
//                                                     color: Colors.white,
//                                                     fontWeight:
//                                                         FontWeight.bold),
//                                               )),
//                                             )),
//                                       )
//                                 : InkWell(
//                                     onTap: () async {
//                                       double latValue =
//                                           cameraMovenewlat != null
//                                               ? cameraMovenewlat!
//                                               : widget.latitude;
//                                       double lngValue =
//                                           cameraMovenewlat != null
//                                               ? cameraMovenewlong!
//                                               : widget.longitude;
//                                       SharedPreference.getLocationData(
//                                           latValue, lngValue);
//                                       SharedPreferences sharedPreference =
//                                           await SharedPreferences
//                                               .getInstance();
//                                       sharedPreference.setDouble(
//                                           "LATITUDE", latValue);
//                                       newlatvalue = sharedPreference
//                                           .getDouble("LATITUDE");
//                                       sharedPreference.setDouble(
//                                           "LONGITUDE", lngValue);
//                                       newlongvalue = sharedPreference
//                                           .getDouble("LONGITUDE");
//                                       Navigator.of(context).pop("set");
//                                       // Navigator.pop(context, "set");
//                                     },
//                                     child: Container(
//                                         width:
//                                             MediaQuery.of(context).size.width,
//                                         decoration: BoxDecoration(
//                                             borderRadius:
//                                                 BorderRadius.circular(5.0),
//                                             color: swiggyOrange),
//                                         child: Padding(
//                                           pcaring: const EdgeInsets.all(8.0),
//                                           child: Center(
//                                               child: Text(
//                                             "Confirm Location".toUpperCase(),
//                                             style: TextStyle(
//                                                 color: Colors.white,
//                                                 fontWeight: FontWeight.bold),
//                                           )),
//                                         )),
//                                   ),
//                           ),
//                         ],
//                       ),
//                     ));
//               });
//             },
//           ),

//           Align(
//             alignment: Alignment.center,
//             child: Icon(
//               Icons.location_pin,
//               color: Colors.black54,
//               size: 50,
//             ),
//           )

//           // GoogleMap(
//           //   mapType: MapType.normal,
//           //   myLocationEnabled: true,
//           //   // markers: Set<Marker>.from(startMarker),
//           //   myLocationButtonEnabled: false,
//           //   // zoomGesturesEnabled: true,
//           //   initialCameraPosition: _initialLocation,
//           //   onMapCreated: (GoogleMapController controller) {
//           //     mapController = controller;
//           //   },
//           // ),
//         ],
//       ),
//     ),
//   );
// }
}
