import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:mycityapp/Cab/Models/near_driver_list_model.dart';
import 'package:mycityapp/Cab/Services/location_services.dart/loaction_shared_preference.dart';
import 'package:mycityapp/Cab/Services/nearby_driver_api_provider.dart';
import 'package:mycityapp/Cab/pages/search_page.dart';
import 'package:mycityapp/common/common_styles.dart';
import 'package:marquee/marquee.dart';
import 'package:mycityapp/common/utils.dart';
import '../rentalPackages/rental_packages.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  LatLng _initialcameraposition = LatLng(20.5937, 78.9629);
  GoogleMapController? _controller;
  final Location _location = Location();

  bool selectRideScreen = false;

  Future<String> getJsonFile(String path) async {
    return await rootBundle.loadString(path);
  }

  void _onMapCreated(GoogleMapController _cntlr) {
    getJsonFile("assets/mapStyle.json")
        .then((value) => _cntlr.setMapStyle(value));
    getNearDriver();
    _controller = _cntlr;
    _controller!.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
            target:
                LatLng(SharedPreference.latitude!, SharedPreference.longitude!),
            zoom: 12),
      ),
    );
    // _location.onLocationChanged.listen((l) {});
    // homePageProvider.googleMapController = _cntlr;
    // homePageProvider.getDistance(
    //     double.parse("12.991652"), double.parse("77.559741"));
  }

  bool isvisible = false;
  void showToast() {
    setState(() {
      isvisible = !isvisible;
    });
  }

  // showSelectRide() {
  //   setState(() {
  //     selectRideScreen = !selectRideScreen;
  //   });
  // }

  showSelectRide() {
    setState(() {
      selectRideScreen = !selectRideScreen;
    });
  }

  // List<LocationDetailsCopy>? _list;

  late BitmapDescriptor nearByVehicle;
  late BitmapDescriptor autoMarkerIcon;
  late BitmapDescriptor cabMarkerIcon;
  late BitmapDescriptor truckMakerIcon;

  final Set<Marker> _markers = <Marker>{};

  getMarkerIcon() async {
    autoMarkerIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(devicePixelRatio: 2.5),
      'assets/auto.png',
    );
    cabMarkerIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(devicePixelRatio: 2.5),
      'assets/d_pin.png',
    );
    truckMakerIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(devicePixelRatio: 2.5),
      'assets/d_pin.png',
    );
  }

  List<NearByVehicleList> vehicleList = [];
  Future<void> getNearDriver() async {
    final nearByDriverList =
        Provider.of<NearbyDriverListAPIProvider>(context, listen: false);

    _markers.clear();

    await nearByDriverList
        .nearByDriverList(SharedPreference.latitude.toString(),
            SharedPreference.longitude.toString(), "", type.toString())
        .whenComplete(() {
      if (nearByDriverList.nearByDriverListModel!.status != "0") {
        vehicleList = nearByDriverList.nearByDriverListModel!.vehicleList!;
        print("--------------------------------------------------------------");

        for (var element in vehicleList) {
          print("ELement " + element.driverName!);
          var pinPosition = LatLng(double.parse(element.latitude!),
              double.parse(element.longitude!));
          print("Wheel TYPE =---------------" +
              element.vehicleWheelType.toString());

          if (element.vehicleWheelType == "0") {
            _markers.add(Marker(
                markerId: MarkerId(element.id!),
                position: pinPosition,
                /*       rotation: double.parse(heading),*/
                draggable: false,
                zIndex: 2,
                flat: true,
                anchor: const Offset(0.5, 0.5),
                icon: autoMarkerIcon));
          } else if (element.vehicleWheelType == "1") {
            _markers.add(Marker(
                markerId: MarkerId(element.id!),
                position: pinPosition,
                /*       rotation: double.parse(heading),*/
                draggable: false,
                zIndex: 2,
                flat: true,
                anchor: const Offset(0.5, 0.5),
                icon: cabMarkerIcon));
          } else if (element.vehicleWheelType == "2") {
            _markers.add(Marker(
                markerId: MarkerId(element.id!),
                position: pinPosition,
                /*       rotation: double.parse(heading),*/
                draggable: false,
                zIndex: 2,
                flat: true,
                anchor: const Offset(0.5, 0.5),
                icon: truckMakerIcon));
          }
        }
      }
      setState(() {});
    });
    print("Fetching vehicle List");
    print("Type -------" + type.toString());

    /*  if (nearByDriverList.ifLoading) {
      CircularProgressIndicator();
    } else {*/
    // }
  }

  initialize() async {
    // final databaseService =
    //     Provider.of<DatabaseService>(context, listen: false);

    // await context.read<DatabaseService>().futureLocation().then((value) {
    //   setState(() {
    //     _list = value;
    //   });
    // });
  }

  List<String> tripType = ["Daily Ride", "Goods", "Rentals"];

  List<String> vechileType = [
    "assets/dailyRide.png",
    "assets/goods.png",
    "assets/rental.png",
  ];
  List<Color> colorizeColors = [
    Colors.amber,
    Colors.blue,
    Colors.yellow,
    Colors.red,
  ];

  var isSelected = 0;

  int type = 1;

  @override
  void initState() {
    getMarkerIcon();

    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final homePageProvider = Provider.of<HomePageProvider>(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      key: scaffoldKey,
      body: buildBody(),
    );
  }

  buildBody() {
    return Stack(
      children: [
        buildMap(),
        buildMapPickLocation(),
        buildTab(),
        // buildMapSelectDifferentLocaiton(),
        goToLocationMap(),

        Positioned(
          top: 35,
          child: Neumorphic(
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            style: NeumorphicStyle(color: Colors.white),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.98,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Column(
                  children: [
                    Row(
                      children: [
                        //  Icon(Icons.menu),
                        Expanded(
                          flex: 5,
                          child: SizedBox(
                            height: 70,
                            child: NeumorphicButton(
                              style: NeumorphicStyle(color: Colors.white),
                              margin: EdgeInsets.only(right: 0),
                              // elevation: 20,

                              child: Center(
                                child: InkWell(
                                  onTap: () async {
                                    print("TYPE -->>>>" + type.toString());

                                    final String result = await Navigator.of(
                                            context)
                                        .push(MaterialPageRoute(
                                            builder: (context) => SearchPage(
                                                  initialLogin: true,
                                                  type: isSelected.toString(),
                                                )));
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        flex: 4,
                                        child: Marquee(
                                          text:
                                              SharedPreference.currentAddress!,
                                          style: CommonStyles.green12(),
                                          scrollAxis: Axis.horizontal,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          blankSpace: 20.0,
                                          velocity: 100.0,
                                          startPadding: 2,
                                          pauseAfterRound:
                                              const Duration(seconds: 3),
                                          accelerationDuration:
                                              const Duration(seconds: 1),
                                          accelerationCurve: Curves.linear,
                                          decelerationDuration:
                                              const Duration(milliseconds: 500),
                                          decelerationCurve: Curves.easeOut,
                                        ),
                                      ),
                                      Icon(
                                        Icons.where_to_vote,
                                        size: 30,
                                        color: Colors.indigo[800],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    /*if (isSelected == 0)
                      SizedBox(
                        height: 100,
                        child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: recentSearch.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.only(left: 10.0, top: 10),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.history,
                                          color: Colors.blue,
                                          size: 18,
                                        ),
                                        Utils.getSizedBox(width: 20),
                                        Text(recentSearch[index])
                                      ],
                                    ),
                                    Utils.getSizedBox(height: 20)
                                  ],
                                ),
                              );
                            }),
                      )*/
                  ],
                ),
              ),
            ),
          ),
        ),

        // Visibility(visible: !selectRideScreen, child: ),
        // DraggableScrollableSheet(
        //     minChildSize: 0.2,
        //     maxChildSize: 0.7,
        //     initialChildSize: 0.4,
        //     builder: (context, dragableController) {
        //       return SingleChildScrollView(
        //         controller: dragableController,
        //         primary: false,
        //         physics: const BouncingScrollPhysics(),
        //         child: SelectRideScreen(
        //           function: showSelectRide,
        //         ),
        //       );
        //     }),
      ],
    );
  }

  buildMap() {
    // final homePageProvider = Provider.of<HomePageProvider>(context);

    // if (_list == null ||
    //     homePageProvider.state == HomePageProviderState.Uninitialized) {
    //   return const Center(
    //     child: SizedBox(
    //       height: 25,
    //       width: 25,
    //       child: CircularProgressIndicator(
    //         strokeWidth: 1,
    //       ),
    //     ),
    //   );
    // }

    return SizedBox(
      // height: MediaQuery.of(context).size.height * 0.5,
      child: GoogleMap(
        initialCameraPosition: CameraPosition(target: _initialcameraposition),
        mapType: MapType.terrain,
        myLocationButtonEnabled: false,
        // polylines: Set<Polyline>.of(homePageProvider.polylines.values),
        onMapCreated: _onMapCreated,
        markers: _markers,
        myLocationEnabled: true,
        mapToolbarEnabled: false,
      ),
    );
  }

  buildMapPickLocation() {
    // final homePageProvider = Provider.of<HomePageProvider>(context);

    // if (_list == null ||
    //     homePageProvider.state == HomePageProviderState.Uninitialized) {
    //   return const Center(
    //     child: SizedBox(
    //       height: 25,
    //       width: 25,
    //       child: CircularProgressIndicator(
    //         strokeWidth: 1,
    //       ),
    //     ),
    //   );
    // }

    return Positioned(
      top: (deviceHeight(context) - 105) / 2,
      right: (deviceWidth(context) - 35) / 2,
      child: const Align(
        alignment: Alignment.center,
        child: Icon(
          FontAwesomeIcons.mapPin,
          color: Colors.green,
          size: 35,
        ),
      ),
    );
  }

  goToLocationMap() {
    // final homePageProvider = Provider.of<HomePageProvider>(context);

    // if (_list == null ||
    //     homePageProvider.state == HomePageProviderState.Uninitialized) {
    //   return const Center(
    //     child: SizedBox(
    //       height: 25,
    //       width: 25,
    //       child: CircularProgressIndicator(
    //         strokeWidth: 1,
    //       ),
    //     ),
    //   );
    // }

    return Positioned(
      top: (deviceHeight(context) - 35 - 70 - 60) / 2,
      right: 10,
      child: Align(
        alignment: Alignment.center,
        child: InkWell(
          onTap: () {
            _controller!.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                    target: LatLng(SharedPreference.latitude!,
                        SharedPreference.longitude!),
                    zoom: 15),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.indigo[800],
                border: Border.all(color: Colors.blue)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.my_location_outlined,
                color: Colors.white.withOpacity(0.95),
              ),
            ),
          ),
        ),
      ),
    );
  }

  buildMapSelectDifferentLocaiton() {
    // final homePageProvider = Provider.of<HomePageProvider>(context);

    // if (_list == null ||
    //     homePageProvider.state == HomePageProviderState.Uninitialized) {
    //   return const Center(
    //     child: SizedBox(
    //       height: 25,
    //       width: 25,
    //       child: CircularProgressIndicator(
    //         strokeWidth: 1,
    //       ),
    //     ),
    //   );
    // }

    return Positioned(
      top: (deviceHeight(context) - 30 - 30 - 150) / 2,
      left: (deviceWidth(context) - 180) / 2,
      child: Align(
        alignment: Alignment.center,
        child: Container(
          height: 30,
          width: 180,
          decoration: BoxDecoration(
              color: const Color(0xFFF9AA33),
              borderRadius: BorderRadius.circular(8)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Marquee(
                  text: SharedPreference.currentAddress!,
                  style: CommonStyles.white12(),
                  scrollAxis: Axis.horizontal,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  blankSpace: 20.0,
                  velocity: 100.0,
                  startPadding: 2,
                  pauseAfterRound: const Duration(seconds: 3),
                  accelerationDuration: const Duration(seconds: 1),
                  accelerationCurve: Curves.linear,
                  decelerationDuration: const Duration(milliseconds: 500),
                  decelerationCurve: Curves.easeOut,
                ),
              ),
              Utils.getSizedBox(width: 3),
              InkWell(
                onTap: () async {
                  print("Type ------->>>" + isSelected.toString());

                  final String result =
                      await Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SearchPage(
                                initialLogin: true,
                                type: isSelected.toString(),
                              )));
                  // final String result = await Navigator.of(context)
                  //     .push(MaterialPageRoute(builder: (context) {
                  //   return const PlacePickGoogleMaps();
                  // }));
                  if (result.isNotEmpty) {
                    _controller!.animateCamera(
                      CameraUpdate.newCameraPosition(
                        CameraPosition(
                            target: LatLng(SharedPreference.latitude!,
                                SharedPreference.longitude!),
                            zoom: 15),
                      ),
                    );
                  }
                  setState(() {});
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Change",
                      style: CommonStyles.black10thin(),
                    ),
                    const Icon(
                      Icons.keyboard_arrow_right_sharp,
                      size: 18,
                      color: Colors.black,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTab() {
    return Positioned(
      //alignment: Alignment.bottomCenter,
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 330,
        child: Neumorphic(
          style: NeumorphicStyle(color: Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 90,
                padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: tripType.length,
                    itemBuilder: (context, index) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: 0,
                            ),
                            /*    decoration: BoxDecoration(
                                color: isSelected == index
                                    ? Colors.amber
                                    : Colors.white,
                                border: isSelected == index
                                    ? Border.all(
                                        width: 0.9,
                                        style: BorderStyle.solid,
                                        color: Colors.amber)
                                    : null,
                                borderRadius: BorderRadius.circular(15)),*/
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 5),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    print("Selected -------->>>> " +
                                        isSelected.toString());
                                    isSelected = index;
                                    print("Selected -------->>>> " +
                                        isSelected.toString());

                                    //  type = isSelected + 1;
                                    if (index == 0) {
                                      type = 1;
                                    } else if (index == 1) {
                                      type = 2;
                                    } else {
                                      type = 3;
                                    }
                                    getNearDriver();

                                    print(
                                        "+ Value -------- " + type.toString());
                                  });
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      vechileType[index],
                                      height: 30,
                                      width: 70,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    AnimatedTextKit(
                                      animatedTexts: [
                                        ColorizeAnimatedText(tripType[index],
                                            textStyle:
                                                CommonStyles.black13thinW54(),
                                            textAlign: TextAlign.right,
                                            colors: colorizeColors)
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
              ),
              Card(
                margin: EdgeInsets.symmetric(horizontal: 10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                elevation: 10,
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                      child: Neumorphic(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        style: NeumorphicStyle(color: Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 15, bottom: 15.0, right: 15, left: 15),
                          child: Center(
                            child: InkWell(
                              onTap: () async {
                                print("TYPE -->>>>" + type.toString());

                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => SearchPage(
                                          type: type.toString(),
                                        )));
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Search Destination ',
                                    style: CommonStyles.red12(),
                                  ),
                                  Icon(
                                    Icons.search,
                                    size: 30,
                                    color: Colors.indigo[800],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.forward,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  "Rajaji Nagar, Bangalore, India",
                                  style: CommonStyles.black13(),
                                )
                              ],
                            ),
                          );
                        })
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SelectRideScreen extends StatefulWidget {
  const SelectRideScreen({Key? key, required this.function}) : super(key: key);

  final VoidCallback function;

  @override
  _SelectRideScreenState createState() => _SelectRideScreenState();
}

class _SelectRideScreenState extends State<SelectRideScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: buildvehicalType(),
    );
    // return AnimatedContainer(
    //   height: 500,
    //   duration: const Duration(seconds: 1),
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.end,
    //     children: [
    //       buildvehicalType(),
    //       // Container(
    //       //   alignment: Alignment.bottomCenter,
    //       //   width: MediaQuery.of(context).size.width,
    //       //   decoration: BoxDecoration(
    //       //       borderRadius: const BorderRadius.only(
    //       //           topLeft: Radius.circular(20),
    //       //           topRight: Radius.circular(20)),
    //       //       color: Colors.blueGrey[50]),
    //       //   child: Column(
    //       //     children: [
    //       //       const SizedBox(
    //       //         height: 10,
    //       //       ),
    //       //       Row(
    //       //         mainAxisAlignment: MainAxisAlignment.spaceAround,
    //       //         children: [
    //       //           InkWell(
    //       //             onTap: () async {
    //       //               Prediction? predectionResult =
    //       //                   // await Navigator.pushNamed(context, 'SearchPage');
    //       //                   await Navigator.of(context).push(MaterialPageRoute(
    //       //                       builder: (context) => const SearchPage()));

    //       //               if (predectionResult != null) {
    //       //                 homePageProvider.getDistance(
    //       //                     double.parse(predectionResult.lat!),
    //       //                     double.parse(predectionResult.lng!));
    //       //                 widget.function();
    //       //               }
    //       //             },
    //       //             child: Container(
    //       //               width: 180,
    //       //               decoration: BoxDecoration(
    //       //                 color: const Color.fromARGB(255, 88, 26, 22),
    //       //                 borderRadius: BorderRadius.circular(50),
    //       //                 boxShadow: [
    //       //                   BoxShadow(
    //       //                     color: Colors.black.withOpacity(.3),
    //       //                     blurRadius: 10.0,
    //       //                     spreadRadius: 2.0,
    //       //                     offset: const Offset(
    //       //                       5.0,
    //       //                       5.0,
    //       //                     ),
    //       //                   )
    //       //                 ],
    //       //               ),
    //       //               child: Padding(
    //       //                 padding: const EdgeInsets.all(8.0),
    //       //                 child: Row(
    //       //                   mainAxisAlignment: MainAxisAlignment.center,
    //       //                   children: const [
    //       //                     Icon(
    //       //                       Icons.home_outlined,
    //       //                       color: Colors.white,
    //       //                       size: 25,
    //       //                     ),
    //       //                     Text(
    //       //                       'ON DEMAND',
    //       //                       style: TextStyle(
    //       //                           color: Colors.white,
    //       //                           fontSize: 10,
    //       //                           fontWeight: FontWeight.w400),
    //       //                     ),
    //       //                   ],
    //       //                 ),
    //       //               ),
    //       //             ),
    //       //           ),
    //       //           // InkWell(
    //       //           //   onTap: () {
    //       //           //     Navigator.pushNamed(context, 'RentelPackages');
    //       //           //   },
    //       //           //   child: Container(
    //       //           //     width: 180,
    //       //           //     decoration: BoxDecoration(
    //       //           //       color: Colors.white,
    //       //           //       borderRadius: BorderRadius.circular(50),
    //       //           //       boxShadow: [
    //       //           //         BoxShadow(
    //       //           //           color: Colors.black.withOpacity(.3),
    //       //           //           blurRadius: 10.0,
    //       //           //           spreadRadius: 2.0,
    //       //           //           offset: const Offset(
    //       //           //             5.0,
    //       //           //             5.0,
    //       //           //           ),
    //       //           //         )
    //       //           //       ],
    //       //           //     ),
    //       //           //     child: Padding(
    //       //           //       padding: const EdgeInsets.all(8.0),
    //       //           //       child: Row(
    //       //           //         mainAxisAlignment: MainAxisAlignment.center,
    //       //           //         children: [
    //       //           //           const Icon(
    //       //           //             Icons.home_outlined,
    //       //           //             color: Colors.black,
    //       //           //             size: 25,
    //       //           //           ),
    //       //           //           Text(
    //       //           //             'DailyRentels'.toUpperCase(),
    //       //           //             style: const TextStyle(
    //       //           //                 color: Colors.black,
    //       //           //                 fontSize: 10,
    //       //           //                 fontWeight: FontWeight.w400),
    //       //           //           ),
    //       //           //         ],
    //       //           //       ),
    //       //           //     ),
    //       //           //   ),
    //       //           // ),
    //       //         ],
    //       //       ),
    //       //       SizedBox(
    //       //         height: 20,
    //       //       ),
    //       //     ],
    //       //   ),
    //       // ),
    //     ],
    //   ),
    // );
  }

  buildvehicalType() {
    return Container(
      width: double.maxFinite,
      // height: 310,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 3, bottom: 3),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.blueGrey[200],
                ),
                height: 5,
                width: 50,
              ),
            ),
            Container(
              color: Colors.amber[100],
              child: const Padding(
                padding: EdgeInsets.all(5.0),
                child: Text(
                  'Drop Should be within city Boundary',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Padding(
              padding: EdgeInsets.all(3.0),
              child: VehicleCategoriesListWidget(),
            ),
            // const VehicleRideDetails(),

            // Container(
            //   color: Colors.white,
            //   child: Padding(
            //     padding: const EdgeInsets.all(12.0),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //       children: const [
            //         Text('Pickup Contact',
            //             style: TextStyle(
            //                 color: Colors.black,
            //                 fontSize: 12,
            //                 fontWeight: FontWeight.w600,
            //                 letterSpacing: 0.3)),
            //         Text('7848026262 Arun G',
            //             style: TextStyle(
            //                 color: Color.fromARGB(255, 88, 26, 22),
            //                 fontSize: 12,
            //                 fontWeight: FontWeight.w700,
            //                 letterSpacing: 0)),
            //       ],
            //     ),
            //   ),
            // ),
            Container(
              height: 2,
              color: Colors.grey[200],
            ),
          ],
        ),
      ),
    );
  }
}
