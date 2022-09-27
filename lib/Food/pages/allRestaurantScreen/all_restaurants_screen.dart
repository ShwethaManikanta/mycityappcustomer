import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mycityapp/Food/CommonWidgets/cached_network_image.dart';
import 'package:mycityapp/Food/CommonWidgets/common_styles.dart';
import 'package:mycityapp/Food/CommonWidgets/custom_switch.dart';
import 'package:mycityapp/Food/CommonWidgets/utils.dart';
import 'package:mycityapp/Food/Models/PopularRestaurantModel.dart';
import 'package:mycityapp/Food/Services/popular_restaurant_api_provider.dart';
import 'package:mycityapp/Food/Services/restaurant_details_api_provider.dart';
import 'package:mycityapp/Food/pages/SearchScreen.dart';
import 'package:mycityapp/Food/pages/closeToBuyScreen/widgets/offer_banner_view.dart';
import 'package:mycityapp/Food/pages/restaurantDetailsPage/restaurant_detail_screen.dart';
import 'package:provider/provider.dart';
import 'package:mycityapp/Food/pages/utils/loaction_shared_preference.dart';
import '../../CommonWidgets/screen_width_and_height.dart';
import '../BottomSheet/bottom_sheet.dart';
import '../ui_helper.dart';

class AllRestaurantsScreen extends StatefulWidget {
  final String storeType;

  const AllRestaurantsScreen({Key? key, required this.storeType})
      : super(key: key);
  @override
  State<AllRestaurantsScreen> createState() => _AllRestaurantsScreenState();
}

class _AllRestaurantsScreenState extends State<AllRestaurantsScreen> {
  // final restaurantListOne = AllRestaurant.getRestaurantListOne();

  // final restaurantListTwo = AllRestaurant.getRestaurantListTwo();

  // final restaurantListThree = AllRestaurant.getRestaurantListThree();
  String? radioItem = '';
  // Future? _postData;

  List<PopularRestaurantModel>? foods = [];

  bool _switchValue = false;

  @override
  void initState() {
    super.initState();
    initialize();
    // setState(() {
    //   _postData = _post(5);
    // });
  }

  initialize({String? foodType}) async {
    if (widget.storeType == "1") {
      context.read<PopularRestaurantAPIProvider>().initialize();

      context.read<PopularRestaurantAPIProvider>().getPopularRestaurant(
          lat: SharedPreference.latitude.toString(),
          long: SharedPreference.longitude.toString(),
          filter: "1",
          type: widget.storeType,
          foodType: foodType == null ? "3" : foodType);
    } else if (widget.storeType == "2") {
      context.read<PopularMeatAPIProvider>().initialize();

      context.read<PopularMeatAPIProvider>().getPopularRestaurant(
          lat: SharedPreference.latitude.toString(),
          long: SharedPreference.longitude.toString(),
          filter: "1",
          type: widget.storeType,
          foodType: foodType == null ? "3" : foodType);
    } else if (widget.storeType == "3") {
      context.read<PopularBakeryAPIProvider>().initialize();
      context.read<PopularBakeryAPIProvider>().getPopularRestaurant(
          lat: SharedPreference.latitude.toString(),
          long: SharedPreference.longitude.toString(),
          filter: "1",
          type: widget.storeType,
          foodType: foodType == null ? "3" : foodType);
    }
  }

  // _post(int value) {
  //   setState(() {
  //     apiServices
  //         .getPopularRestaurants(SharedPreference.latitudeValue,
  //             SharedPreference.longitudeValue, value)
  //         .then((value) {
  //       setState(() {
  //         foods = ApiServices.popularRestaurants;
  //       });
  //     });
  //   });
  // }
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<Color> colorizeColors = [
    Colors.purple,
    Colors.blue,
    Colors.yellow,
    Colors.red,
  ];

  @override
  Widget build(BuildContext context) {
    // final popularRestaurantAPIProvider =
    //     Provider.of<PopularRestaurantAPIProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      bottomSheet: BottomCartSheet(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(190.0), // here the desired height
        child: AppBar(
          elevation: 0,
          bottom: PreferredSize(
              child: BottomBannerView(), preferredSize: Size.fromHeight(60.0)),
          backgroundColor: Colors.white,
          leading: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 8),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(Icons.arrow_back),
                ),
              ),
            ],
          ),

          //  IconButton(
          //   icon: Icon(
          //     Icons.arrow_back,
          //   ),
          //   onPressed: () {
          //     setState(() {
          //       Navigator.pop(context);
          //     });
          //     // Navigator.pushNamed(context, 'CartScreen');
          //   },
          // ),
          // title: Text("Restaurants"),
          actions: [
            Padding(
              padding: const EdgeInsets.only(left: 0.0, right: 10, top: 8),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: ((context) => SearchScreen())));
                },
                child: Icon(
                  Icons.search,
                  size: 24,
                ),
              ),
            )
          ],
          titleTextStyle: TextStyle(color: Colors.black, fontSize: 18),
          iconTheme: IconThemeData(color: Colors.black),
        ),
      ),
      body: SafeArea(
          child:
              // FutureBuilder(
              //     future: _postData,
              //     builder: (context, snapshot) {
              //       return
              SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Column(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     SizedBox(
                  //       height: 10,
                  //     ),
                  //     // Text(
                  //     //   "Close To Buy",
                  //     //   style: CommonStyles.bold12TextStyle(),
                  //     // ),

                  //     // Expanded(
                  //     //   flex: 2,
                  //     //   child: Container(
                  //     //     height: 100,
                  //     //     width: 100,
                  //     //     padding: EdgeInsets.only(top: 0),
                  //     //     child: Column(
                  //     //       children: [
                  //     //         Padding(
                  //     //             padding: EdgeInsets.only(
                  //     //                 top: 8.0, bottom: 4),
                  //     //             child: CircleAvatar(
                  //     //               backgroundColor: Colors.yellow,
                  //     //               radius: 30,
                  //     //               child: Image.asset(
                  //     //                 "assets/images/homeLogo.png",
                  //     //                 width: 28,
                  //     //               ),
                  //     //             )),
                  //     //         Text(
                  //     //           "Close To Buy",
                  //     //           style: TextStyle(
                  //     //               fontWeight: FontWeight.bold,
                  //     //               fontSize: 14),
                  //     //           textAlign: TextAlign.center,
                  //     //         ),
                  //     //         //   Text("C2B")
                  //     //       ],
                  //     //     ),
                  //     //   ),
                  //     // ),
                  //     // ListView.builder(
                  //     //     shrinkWrap: true,
                  //     //     physics: BouncingScrollPhysics(),
                  //     //     itemCount: foods!.length,
                  //     //     scrollDirection: Axis.vertical,
                  //     //     itemBuilder:
                  //     //         (BuildContext context, int index) {
                  //     //       print(
                  //     //           "foods lengtjh  ==== ${foods!.length}");
                  //     //       return Card(
                  //     //         elevation: 0,
                  //     //         child: Column(
                  //     //           mainAxisAlignment:
                  //     //               MainAxisAlignment.start,
                  //     //           children: [
                  //     //             Padding(
                  //     //                 padding: EdgeInsets.only(
                  //     //                     top: 8.0, bottom: 4),
                  //     //                 child: CircleAvatar(
                  //     //                   backgroundImage: NetworkImage(
                  //     //                       "https://chillkrt.in/closetobuy/uploads/restaurant/${foods![index].image}"),
                  //     //                   radius: 30,
                  //     //                   backgroundColor:
                  //     //                       Colors.transparent,
                  //     //                 )),
                  //     //             Padding(
                  //     //               padding: const EdgeInsets.all(2.0),
                  //     //               child: Text(
                  //     //                 foods![index].restaurantName!,
                  //     //                 style: TextStyle(
                  //     //                     fontWeight: FontWeight.bold,
                  //     //                     fontSize: 12),
                  //     //                 textAlign: TextAlign.center,
                  //     //               ),
                  //     //             ),
                  //     //           ],
                  //     //         ),
                  //     //       );
                  //     //     })
                  //   ],
                  // ),
                  /* InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AllRestaurantsScreen(),
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      height: 45.0,
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      color: darkOrange,
                      child: Row(
                        children: <Widget>[
                          Text(
                            'View all Restaruant',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .copyWith(color: Colors.white, fontSize: 18.0),
                          ),
                          UIHelper.horizontalSpaceSmall(),
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: 18.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),*/
                ],
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(
            //       top: 4.0, bottom: 4.0, left: 8, right: 8),
            //   child:
            // ),
            // SizedBox(
            //   height: 10,
            // ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Text(
                  //   "All Restaurants",
                  //   style: TextStyle(
                  //       fontSize: 18, fontWeight: FontWeight.bold),
                  // ),
                  AnimatedTextKit(
                    animatedTexts: [
                      // isRepeatingAnimation: true,
                      ColorizeAnimatedText(
                        "My City",
                        textStyle: CommonStyles.black57S18(),
                        textAlign: TextAlign.right,
                        colors: colorizeColors,
                      )
                    ],
                  ),
                  Visibility(
                    visible: widget.storeType != "2",
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Veg",
                              style: CommonStyles.black57S18(),
                            ),
                            Utils.getSizedBox(width: 5),
                            CustomSwitch(
                                value: _switchValue,
                                onChanged: (value) {
                                  setState(() {
                                    _switchValue = value;
                                  });
                                  if (value) {
                                    print("veg food type");
                                    initialize(foodType: "1");
                                  } else {
                                    print("non food type");
                                    initialize(foodType: "3");
                                  }
                                }),
                            // CupertinoSwitch(
                            //   value: _switchValue,
                            //   onChanged: (value) {
                            //     setState(() {
                            //       _switchValue = value;
                            //     });
                            //   },
                            // ),
                          ],
                        ),
                        // Utils.getSizedBox(width: 10),
                        // Row(
                        //   children: [
                        //     Text(
                        //       "Non-Veg",
                        //     ),
                        //     Utils.getSizedBox(width: 5),
                        //     CustomSwitch(
                        //         value: _switchValue,
                        //         onChanged: (value) {
                        //           setState(() {
                        //             _switchValue = value;
                        //           });
                        //         }),

                        //     // CupertinoSwitch(
                        //     //   value: _switchValue,
                        //     //   onChanged: (value) {
                        //     //     setState(() {
                        //     //       _switchValue = value;
                        //     //     });
                        //     //   },
                        //     // ),
                        //   ],
                        // ),
                      ],
                    ),
                  )

                  // InkWell(
                  //   onTap: () {
                  //     showModalBottomSheet(
                  //         context: context,
                  //         builder: (context) {
                  //           return StatefulBuilder(builder: (BuildContext
                  //                   context,
                  //               StateSetter
                  //                   setState /*You can rename this!*/) {
                  //             return Padding(
                  //               padding: const EdgeInsets.all(12.0),
                  //               child: Wrap(
                  //                 children: [
                  //                   Row(
                  //                     children: [
                  //                       IconButton(
                  //                           onPressed: () {
                  //                             Navigator.pop(context);
                  //                           },
                  //                           icon: Icon(Icons.clear)),
                  //                       Text(
                  //                         "Sort / Filter",
                  //                         style: TextStyle(
                  //                             fontSize: 12,
                  //                             fontWeight:
                  //                                 FontWeight.bold),
                  //                       ),
                  //                     ],
                  //                   ),
                  //                   RadioListTile(
                  //                     activeColor: Colors.blue,
                  //                     groupValue: radioItem,
                  //                     title: Text('All'),
                  //                     value: 'Item 0',
                  //                     onChanged: (dynamic val) {
                  //                       setState(() {
                  //                         radioItem = val;
                  //                         _postData = _post(1);
                  //                         Navigator.pop(context);
                  //                       });
                  //                     },
                  //                   ),
                  //                   RadioListTile(
                  //                     activeColor: Colors.blue,
                  //                     groupValue: radioItem,
                  //                     title: Text('Delivery'),
                  //                     value: 'Item 1',
                  //                     onChanged: (dynamic val) {
                  //                       setState(() {
                  //                         radioItem = val;
                  //                         _postData = _post(2);
                  //                         Navigator.pop(context);
                  //                         // apiServices.getPopularRestaurants(SharedPreference.latitudeValue, SharedPreference.longitudeValue,2).then((value) => Navigator.pop(context));
                  //                       });
                  //                     },
                  //                   ),
                  //                   RadioListTile(
                  //                     activeColor: Colors.blue,
                  //                     groupValue: radioItem,
                  //                     title: Text('Rating'),
                  //                     value: 'Item 2',
                  //                     onChanged: (dynamic val) {
                  //                       setState(() {
                  //                         radioItem = val;
                  //                         _postData = _post(3);
                  //                         Navigator.pop(context);
                  //                       });
                  //                     },
                  //                   ),
                  //                   RadioListTile(
                  //                     activeColor: Colors.blue,
                  //                     groupValue: radioItem,
                  //                     title: Text('Low to High'),
                  //                     value: 'Item 3',
                  //                     onChanged: (dynamic val) {
                  //                       setState(() {
                  //                         radioItem = val;
                  //                         _postData = _post(4);
                  //                         Navigator.pop(context);
                  //                       });
                  //                     },
                  //                   ),
                  //                   RadioListTile(
                  //                     activeColor: Colors.blue,
                  //                     groupValue: radioItem,
                  //                     title: Text('High to Low'),
                  //                     value: 'Item 4',
                  //                     onChanged: (dynamic val) {
                  //                       setState(() {
                  //                         radioItem = val;
                  //                         _postData = _post(5);
                  //                         Navigator.pop(context);
                  //                       });
                  //                     },
                  //                   ),
                  //                 ],
                  //               ),
                  //             );
                  //           });
                  //         });
                  //   },
                  //   child: Container(
                  //     padding: EdgeInsets.symmetric(horizontal: 5),
                  //     height: 40,
                  //     decoration: BoxDecoration(
                  //         color: Colors.white,
                  //         borderRadius: BorderRadius.circular(8)),
                  //     child: Row(
                  //       children: [
                  //         Icon(
                  //           Icons.filter_list_alt,
                  //           size: 25,
                  //           //   color: Colors.blue,
                  //         ),
                  //         Text(
                  //           "FILTER",
                  //           style: TextStyle(
                  //               //   color: Colors.blue,
                  //               fontSize: 15,
                  //               fontWeight: FontWeight.bold),
                  //         )
                  //       ],
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ),
            /* Divider(
              thickness: 1,
              color: Colors.black.withOpacity(0.5),
            ),*/
            PopularResturantNearByLocation(storeType: widget.storeType),
            Utils.getSizedBox(height: 50)
          ],
        ),
      )
          // }),
          ),

      // body: foods != null
      //     ? FutureBuilder(
      //         future: _postData,
      //         builder: (context, snapshot) {
      //           print("_postData +${_postData}");
      //           return SingleChildScrollView(
      //             child: Column(
      //               mainAxisSize: MainAxisSize.min,
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               children: <Widget>[
      //                 Padding(
      //                   padding: const EdgeInsets.all(8.0),
      //                   child: Row(
      //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                     children: [
      //                       Text("All Restaurants nearby"),
      //                       InkWell(
      //                         onTap: () {
      //                           showModalBottomSheet(
      //                               context: context,
      //                               builder: (context) {
      //                                 return StatefulBuilder(builder:
      //                                     (BuildContext context, StateSetter setState /*You can rename this!*/) {
      //                                   return Padding(
      //                                     padding: const EdgeInsets.all(12.0),
      //                                     child: Wrap(
      //                                       children: [
      //                                         Row(
      //                                           children: [
      //                                             IconButton(
      //                                                 onPressed: () {
      //                                                   Navigator.pop(context);
      //                                                 },
      //                                                 icon: Icon(Icons.clear)),
      //                                             Text(
      //                                               "Sort / Filter",
      //                                               style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      //                                             ),
      //                                           ],
      //                                         ),
      //                                         RadioListTile(
      //                                           activeColor: Colors.blue,
      //                                           groupValue: radioItem,
      //                                           title: Text('All'),
      //                                           value: 'Item 0',
      //                                           onChanged: (val) {
      //                                             setState(() {
      //                                               radioItem = val;
      //                                             });
      //                                           },
      //                                         ),
      //                                         RadioListTile(
      //                                           activeColor: Colors.blue,
      //                                           groupValue: radioItem,
      //                                           title: Text('Delivery'),
      //                                           value: 'Item 1',
      //                                           onChanged: (val) {
      //                                             setState(() {
      //                                               radioItem = val;
      //                                               _postData = apiServices.getPopularRestaurants(
      //                                                   SharedPreference.latitudeValue,
      //                                                   SharedPreference.longitudeValue,
      //                                                   2);
      //                                               Navigator.pop(context);
      //                                               // apiServices.getPopularRestaurants(SharedPreference.latitudeValue, SharedPreference.longitudeValue,2).then((value) => Navigator.pop(context));
      //                                             });
      //                                           },
      //                                         ),
      //                                         RadioListTile(
      //                                           activeColor: Colors.blue,
      //                                           groupValue: radioItem,
      //                                           title: Text('Rating'),
      //                                           value: 'Item 2',
      //                                           onChanged: (val) {
      //                                             setState(() {
      //                                               radioItem = val;
      //                                             });
      //                                           },
      //                                         ),
      //                                         RadioListTile(
      //                                           activeColor: Colors.blue,
      //                                           groupValue: radioItem,
      //                                           title: Text('Low to High'),
      //                                           value: 'Item 3',
      //                                           onChanged: (val) {
      //                                             setState(() {
      //                                               radioItem = val;
      //                                             });
      //                                           },
      //                                         ),
      //                                         RadioListTile(
      //                                           activeColor: Colors.blue,
      //                                           groupValue: radioItem,
      //                                           title: Text('High to Low'),
      //                                           value: 'Item 4',
      //                                           onChanged: (val) {
      //                                             setState(() {
      //                                               radioItem = val;
      //                                             });
      //                                           },
      //                                         ),
      //                                       ],
      //                                     ),
      //                                   );
      //                                 });
      //                               });
      //                         },
      //                         child: Row(
      //                           children: [
      //                             Icon(
      //                               Icons.filter_list_alt,
      //                               size: 15,
      //                               color: Colors.blue,
      //                             ),
      //                             Text(
      //                               "SORT/FILTER",
      //                               style: TextStyle(color: Colors.blue, fontSize: 12, fontWeight: FontWeight.bold),
      //                             )
      //                           ],
      //                         ),
      //                       )
      //                     ],
      //                   ),
      //                 ),
      //                 ListView.builder(
      //                   shrinkWrap: true,
      //                   physics: NeverScrollableScrollPhysics(),
      //                   itemCount: foods.length,
      //                   itemBuilder: (context, index) => InkWell(
      //                       onTap: () {
      //                         Navigator.push(
      //                           context,
      //                           MaterialPageRoute(
      //                             builder: (context) => RestaurantDetailScreen(
      //                               id: foods[index].id,
      //                             ),
      //                           ),
      //                         );
      //                       },
      //                       child: Container(
      //                         margin: const EdgeInsets.all(10.0),
      //                         child: Row(
      //                           crossAxisAlignment: CrossAxisAlignment.start,
      //                           children: <Widget>[
      //                             Stack(
      //                               children: [
      //                                 Container(
      //                                   clipBehavior: Clip.antiAlias,
      //                                   decoration: BoxDecoration(
      //                                     borderRadius: BorderRadius.circular(5.0),
      //                                     color: Colors.white,
      //                                     boxShadow: <BoxShadow>[
      //                                       BoxShadow(
      //                                         color: Colors.grey,
      //                                         blurRadius: 2.0,
      //                                       )
      //                                     ],
      //                                   ),
      //                                   child: foods[index].image != ""
      //                                       ? Image.network(
      //                                           "http://chillkrt.in/foodie/uploads/restaurant/${foods[index].image}",
      //                                           height: 110.0,
      //                                           width: 80.0,
      //                                           fit: BoxFit.cover,
      //                                         )
      //                                       : Image.network(
      //                                           "https://salautomotive.in/wp-content/uploads/2017/01/no-image-available.jpg",
      //                                           height: 110.0,
      //                                           width: 80.0,
      //                                           fit: BoxFit.cover,
      //                                         ),
      //                                 ),
      //                                 foods[index].offer != ""
      //                                     ? Positioned(
      //                                         bottom: 0,
      //                                         left: 5,
      //                                         // top: 100,
      //                                         child: Container(
      //                                           alignment: Alignment.center,
      //                                           transform: Matrix4.translationValues(0, 15, 0),
      //                                           width: 70.0,
      //                                           decoration: BoxDecoration(
      //                                             color: Colors.green,
      //                                             borderRadius: BorderRadius.circular(5.0),
      //                                           ),
      //                                           child: Center(
      //                                             child: Padding(
      //                                               padding: const EdgeInsets.all(7.0),
      //                                               child: Column(
      //                                                 children: [
      //                                                   Text(
      //                                                     foods[index].offer + " OFF",
      //                                                     style: Theme.of(context)
      //                                                         .textTheme
      //                                                         .subtitle2
      //                                                         .copyWith(fontSize: 11.0, color: Colors.white),
      //                                                   ),
      //                                                   Text(
      //                                                     "UPTO Rs. " + foods[index].up_to,
      //                                                     style: Theme.of(context)
      //                                                         .textTheme
      //                                                         .subtitle2
      //                                                         .copyWith(fontSize: 8.0, color: Colors.white),
      //                                                   ),
      //                                                 ],
      //                                               ),
      //                                             ),
      //                                           ),
      //                                         ),
      //                                       )
      //                                     : Container()
      //                               ],
      //                             ),
      //                             UIHelper.horizontalSpaceSmall(),
      //                             Expanded(
      //                               child: Column(
      //                                 mainAxisAlignment: MainAxisAlignment.start,
      //                                 crossAxisAlignment: CrossAxisAlignment.start,
      //                                 children: <Widget>[
      //                                   Text(
      //                                     foods[index].restaurantName,
      //                                     style: Theme.of(context).textTheme.subtitle2.copyWith(fontSize: 15.0),
      //                                   ),
      //                                   // Text(food.desc,
      //                                   //     style: Theme.of(context)
      //                                   //         .textTheme
      //                                   //         .bodyText1
      //                                   //         .copyWith(color: Colors.grey[600], fontSize: 13.5)),
      //                                   UIHelper.verticalSpaceSmall(),
      //                                   FittedBox(
      //                                     child: Row(
      //                                       children: [
      //                                         Row(
      //                                           children: <Widget>[
      //                                             Icon(
      //                                               Icons.star,
      //                                               size: 14.0,
      //                                               color: Colors.grey[600],
      //                                             ),
      //                                             UIHelper.horizontalSpaceSmall(),
      //                                             Text(foods[index].rating, style: TextStyle(fontSize: 12.0))
      //                                           ],
      //                                         ),
      //                                         UIHelper.horizontalSpaceSmall(),
      //                                         Row(
      //                                           children: <Widget>[
      //                                             Icon(
      //                                               Icons.fiber_manual_record,
      //                                               size: 10.0,
      //                                               color: Colors.grey[600],
      //                                             ),
      //                                             UIHelper.horizontalSpaceSmall(),
      //                                             Text(foods[index].durationLt, style: TextStyle(fontSize: 12.0))
      //                                           ],
      //                                         ),
      //                                         UIHelper.horizontalSpaceSmall(),
      //                                       ],
      //                                     ),
      //                                   ),
      //                                   UIHelper.verticalSpaceSmall(),
      //                                   Text(foods[index].category, style: TextStyle(fontSize: 12.0))
      //                                 ],
      //                               ),
      //                             )
      //                           ],
      //                         ),
      //                       )),
      //                 ),
      //               ],
      //             ),
      //           );
      //         })
      //     : Center(
      //         child: Column(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         crossAxisAlignment: CrossAxisAlignment.center,
      //         children: [
      //           Icon(
      //             Icons.error,
      //             size: 45,
      //             color: Colors.redAccent,
      //           ),
      //           UIHelper.verticalSpaceMedium(),
      //           Text("Service not available in your location"),
      //         ],
      //       )),
    );
  }
}

class AllFoodCourtsScreen extends StatefulWidget {
  final String mallId;

  const AllFoodCourtsScreen({Key? key, required this.mallId}) : super(key: key);
  @override
  State<AllFoodCourtsScreen> createState() => _AllFoodCourtsScreenState();
}

class _AllFoodCourtsScreenState extends State<AllFoodCourtsScreen> {
  // final restaurantListOne = AllRestaurant.getRestaurantListOne();

  // final restaurantListTwo = AllRestaurant.getRestaurantListTwo();

  // final restaurantListThree = AllRestaurant.getRestaurantListThree();
  String? radioItem = '';
  // Future? _postData;

  List<PopularRestaurantModel>? foods = [];

  bool _switchValue = false;

  @override
  void initState() {
    super.initState();
    initialize();
    // setState(() {
    //   _postData = _post(5);
    // });
  }

  initialize({String? foodType}) async {
    context.read<FoodCourtAPIProvider>().initialize();

    context.read<FoodCourtAPIProvider>().getPopularFoodCourt(
          lat: SharedPreference.latitude.toString(),
          long: SharedPreference.longitude.toString(),
          filter: "1",
          type: "4",
          foodType: foodType == null ? "4" : foodType,
        );
  }

  // _post(int value) {
  //   setState(() {
  //     apiServices
  //         .getPopularRestaurants(SharedPreference.latitudeValue,
  //             SharedPreference.longitudeValue, value)
  //         .then((value) {
  //       setState(() {
  //         foods = ApiServices.popularRestaurants;
  //       });
  //     });
  //   });
  // }
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<Color> colorizeColors = [
    Colors.purple,
    Colors.blue,
    Colors.yellow,
    Colors.red,
  ];

  @override
  Widget build(BuildContext context) {
    // final popularRestaurantAPIProvider =
    //     Provider.of<PopularRestaurantAPIProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      bottomSheet: BottomCartSheet(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(190.0), // here the desired height
        child: AppBar(
          elevation: 0,
          bottom: PreferredSize(
              child: BottomBannerView(), preferredSize: Size.fromHeight(60.0)),
          backgroundColor: Colors.white,
          leading: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 8),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(Icons.arrow_back),
                ),
              ),
            ],
          ),

          //  IconButton(
          //   icon: Icon(
          //     Icons.arrow_back,
          //   ),
          //   onPressed: () {
          //     setState(() {
          //       Navigator.pop(context);
          //     });
          //     // Navigator.pushNamed(context, 'CartScreen');
          //   },
          // ),
          // title: Text("Restaurants"),
          actions: [
            Padding(
              padding: const EdgeInsets.only(left: 0.0, right: 10, top: 8),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: ((context) => SearchScreen())));
                },
                child: Icon(
                  Icons.search,
                  size: 24,
                ),
              ),
            )
          ],
          titleTextStyle: TextStyle(color: Colors.black, fontSize: 18),
          iconTheme: IconThemeData(color: Colors.black),
        ),
      ),
      body: SafeArea(
          child:
              // FutureBuilder(
              //     future: _postData,
              //     builder: (context, snapshot) {
              //       return
              SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Column(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     SizedBox(
                  //       height: 10,
                  //     ),
                  //     // Text(
                  //     //   "Close To Buy",
                  //     //   style: CommonStyles.bold12TextStyle(),
                  //     // ),

                  //     // Expanded(
                  //     //   flex: 2,
                  //     //   child: Container(
                  //     //     height: 100,
                  //     //     width: 100,
                  //     //     padding: EdgeInsets.only(top: 0),
                  //     //     child: Column(
                  //     //       children: [
                  //     //         Padding(
                  //     //             padding: EdgeInsets.only(
                  //     //                 top: 8.0, bottom: 4),
                  //     //             child: CircleAvatar(
                  //     //               backgroundColor: Colors.yellow,
                  //     //               radius: 30,
                  //     //               child: Image.asset(
                  //     //                 "assets/images/homeLogo.png",
                  //     //                 width: 28,
                  //     //               ),
                  //     //             )),
                  //     //         Text(
                  //     //           "Close To Buy",
                  //     //           style: TextStyle(
                  //     //               fontWeight: FontWeight.bold,
                  //     //               fontSize: 14),
                  //     //           textAlign: TextAlign.center,
                  //     //         ),
                  //     //         //   Text("C2B")
                  //     //       ],
                  //     //     ),
                  //     //   ),
                  //     // ),
                  //     // ListView.builder(
                  //     //     shrinkWrap: true,
                  //     //     physics: BouncingScrollPhysics(),
                  //     //     itemCount: foods!.length,
                  //     //     scrollDirection: Axis.vertical,
                  //     //     itemBuilder:
                  //     //         (BuildContext context, int index) {
                  //     //       print(
                  //     //           "foods lengtjh  ==== ${foods!.length}");
                  //     //       return Card(
                  //     //         elevation: 0,
                  //     //         child: Column(
                  //     //           mainAxisAlignment:
                  //     //               MainAxisAlignment.start,
                  //     //           children: [
                  //     //             Padding(
                  //     //                 padding: EdgeInsets.only(
                  //     //                     top: 8.0, bottom: 4),
                  //     //                 child: CircleAvatar(
                  //     //                   backgroundImage: NetworkImage(
                  //     //                       "https://chillkrt.in/closetobuy/uploads/restaurant/${foods![index].image}"),
                  //     //                   radius: 30,
                  //     //                   backgroundColor:
                  //     //                       Colors.transparent,
                  //     //                 )),
                  //     //             Padding(
                  //     //               padding: const EdgeInsets.all(2.0),
                  //     //               child: Text(
                  //     //                 foods![index].restaurantName!,
                  //     //                 style: TextStyle(
                  //     //                     fontWeight: FontWeight.bold,
                  //     //                     fontSize: 12),
                  //     //                 textAlign: TextAlign.center,
                  //     //               ),
                  //     //             ),
                  //     //           ],
                  //     //         ),
                  //     //       );
                  //     //     })
                  //   ],
                  // ),
                  /* InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AllRestaurantsScreen(),
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      height: 45.0,
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      color: darkOrange,
                      child: Row(
                        children: <Widget>[
                          Text(
                            'View all Restaruant',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .copyWith(color: Colors.white, fontSize: 18.0),
                          ),
                          UIHelper.horizontalSpaceSmall(),
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: 18.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),*/
                ],
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(
            //       top: 4.0, bottom: 4.0, left: 8, right: 8),
            //   child:
            // ),
            // SizedBox(
            //   height: 10,
            // ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Text(
                  //   "All Restaurants",
                  //   style: TextStyle(
                  //       fontSize: 18, fontWeight: FontWeight.bold),
                  // ),
                  AnimatedTextKit(
                    animatedTexts: [
                      // isRepeatingAnimation: true,
                      ColorizeAnimatedText(
                        "Food Courts Near You",
                        textStyle: CommonStyles.black57S14(),
                        textAlign: TextAlign.right,
                        colors: colorizeColors,
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Veg",
                            style: CommonStyles.black57S18(),
                          ),
                          Utils.getSizedBox(width: 5),
                          CustomSwitch(
                              value: _switchValue,
                              onChanged: (value) {
                                setState(() {
                                  _switchValue = value;
                                });
                                if (value) {
                                  print("veg food type");
                                  initialize(foodType: "1");
                                } else {
                                  print("non food type");
                                  initialize(foodType: "3");
                                }
                              }),
                          // CupertinoSwitch(
                          //   value: _switchValue,
                          //   onChanged: (value) {
                          //     setState(() {
                          //       _switchValue = value;
                          //     });
                          //   },
                          // ),
                        ],
                      ),
                      // Utils.getSizedBox(width: 10),
                      // Row(
                      //   children: [
                      //     Text(
                      //       "Non-Veg",
                      //     ),
                      //     Utils.getSizedBox(width: 5),
                      //     CustomSwitch(
                      //         value: _switchValue,
                      //         onChanged: (value) {
                      //           setState(() {
                      //             _switchValue = value;
                      //           });
                      //         }),

                      //     // CupertinoSwitch(
                      //     //   value: _switchValue,
                      //     //   onChanged: (value) {
                      //     //     setState(() {
                      //     //       _switchValue = value;
                      //     //     });
                      //     //   },
                      //     // ),
                      //   ],
                      // ),
                    ],
                  )
                ],
              ),
            ),
            /* Divider(
              thickness: 1,
              color: Colors.black.withOpacity(0.5),
            ),*/
            FoodCourtListingsScreen(
              foodCourtID: widget.mallId,
              key: UniqueKey(),
            ),
            Utils.getSizedBox(height: 50)
          ],
        ),
      )
          // }),
          ),
    );
  }
}

// class _FoodHorizontalListView extends StatelessWidget {
//   final List<PopularRestaurantModel>? foods = ApiServices.popularRestaurants;
//   final restaurants = AllRestaurant.getPopularBrands();

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: MediaQuery.of(context).size.height / 4,
//       margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//       child: ListView.builder(
//         physics: BouncingScrollPhysics(),
//         scrollDirection: Axis.horizontal,
//         itemCount: foods!.length,
//         itemBuilder: (context, index) => InkWell(
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => RestaurantDetailScreen(
//                   id: "5",
//                 ),
//               ),
//             );
//           },
//           child: Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: Stack(
//               children: <Widget>[
//                 Container(
//                   clipBehavior: Clip.antiAlias,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10.0),
//                     color: Colors.white,
//                     boxShadow: <BoxShadow>[
//                       BoxShadow(
//                         color: Colors.grey,
//                         blurRadius: 2.0,
//                       )
//                     ],
//                   ),
//                   child: Image.network(
//                     "https://foodieworlds.in/foodie/uploads/restaurant/${foods![index].image}",
//                     height: 200.0,
//                     width: 150.0,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 Container(
//                   margin: const EdgeInsets.all(10.0),
//                   padding: const EdgeInsets.symmetric(
//                       vertical: 6.0, horizontal: 10.0),
//                   color: Colors.white,
//                   child: Text('TRY NOW'),
//                 ),
//                 Positioned(
//                   bottom: 0.0,
//                   child: Container(
//                     alignment: Alignment.centerLeft,
//                     padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                     height: 70.0,
//                     color: Colors.black38,
//                     width: MediaQuery.of(context).size.width / 2,
//                     child: Text(
//                       foods![index].restaurantName!,
//                       style: Theme.of(context).textTheme.headline6!.copyWith(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                           ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _LargeRestaurantBannerView extends StatelessWidget {
//   const _LargeRestaurantBannerView({
//     Key? key,
//     required this.title,
//     required this.desc,
//     required this.restaurants,
//   }) : super(key: key);

//   final String title;
//   final String desc;
//   final List<LargeRestaurantBanner> restaurants;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
//       color: Colors.blueGrey[50],
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: <Widget>[
//           UIHelper.verticalSpaceMedium(),
//           Text(
//             title,
//             style:
//                 Theme.of(context).textTheme.subtitle2!.copyWith(fontSize: 18.0),
//           ),
//           UIHelper.verticalSpaceSmall(),
//           Text(
//             desc,
//             textAlign: TextAlign.center,
//             style: Theme.of(context).textTheme.bodyText1!.copyWith(
//                   color: Colors.grey,
//                   fontSize: 12.0,
//                 ),
//           ),
//           UIHelper.verticalSpaceSmall(),
//           LimitedBox(
//             maxHeight: 310.0,
//             child: ListView.builder(
//               shrinkWrap: true,
//               scrollDirection: Axis.horizontal,
//               itemCount: restaurants.length,
//               itemBuilder: (context, index) => InkWell(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => RestaurantDetailScreen(
//                         id: "5",
//                       ),
//                     ),
//                   );
//                 },
//                 child: Container(
//                   padding: const EdgeInsets.all(10.0),
//                   width: 160.0,
//                   child: Column(
//                     children: <Widget>[
//                       UIHelper.verticalSpaceMedium(),
//                       Image.asset(
//                         restaurants[index].image,
//                         height: 160.0,
//                         fit: BoxFit.cover,
//                       ),
//                       UIHelper.verticalSpaceMedium(),
//                       Text(
//                         restaurants[index].title,
//                         maxLines: 2,
//                         textAlign: TextAlign.center,
//                         style: Theme.of(context).textTheme.subtitle2!.copyWith(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 13.0,
//                             ),
//                       ),
//                       UIHelper.verticalSpaceMedium(),
//                       Container(
//                         height: 2.0,
//                         width: 50.0,
//                         color: Colors.grey[400],
//                       ),
//                       UIHelper.verticalSpaceSmall(),
//                       Text(
//                         restaurants[index].subtitle,
//                         maxLines: 2,
//                         textAlign: TextAlign.center,
//                         style: Theme.of(context).textTheme.bodyText1,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

class PopularResturantNearByLocation extends StatefulWidget {
  const PopularResturantNearByLocation({Key? key, required this.storeType})
      : super(key: key);
  final String storeType;

  @override
  _PopularResturantNearByLocationState createState() =>
      _PopularResturantNearByLocationState();
}

class _PopularResturantNearByLocationState
    extends State<PopularResturantNearByLocation> {
  @override
  void initState() {
    // initialize();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    dynamic popularRestaurantAPIProvider = widget.storeType == "1"
        ? Provider.of<PopularRestaurantAPIProvider>(context)
        : widget.storeType == "2"
            ? Provider.of<PopularMeatAPIProvider>(context)
            : Provider.of<PopularBakeryAPIProvider>(context);
    if (popularRestaurantAPIProvider.ifLoading) {
      return SizedBox(height: 120, child: Center(child: Utils.showLoading()));
    } else if (popularRestaurantAPIProvider.error) {
      return Utils.showErrorMessage(popularRestaurantAPIProvider.errorMessage);
    } else if (popularRestaurantAPIProvider
            .popularRestaurantResponseModel!.status ==
        "0") {
      return Utils.showErrorMessage(popularRestaurantAPIProvider
          .popularRestaurantResponseModel!.message!);
    } else {
      final List<NewArrival> foods = popularRestaurantAPIProvider
          .popularRestaurantResponseModel!.newArrival!;

      print("Foods length  - - -- - - -  " + foods.length.toString());
      return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: foods.length,
        itemBuilder: (context, index) => Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Card(
            elevation: 10,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            shadowColor: Colors.blue,
            child: Container(
              //  margin: const EdgeInsets.all(10.0),
              height: 120,
              width: deviceWidth(context) * 0.95,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      height: 120.0,
                      width: 110.0,
                      child: Stack(
                        children: [
                          Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.zero,
                              color: Colors.white,
                              /*boxShadow: <BoxShadow>[
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 2.0,
                                )
                              ],*/
                            ),
                            child: foods[index].image != ""
                                ? SizedBox(
                                    /* height: 120.0,
                                    width: 110.0,*/
                                    child: InkWell(
                                      onTap: () async {
                                        await showDialog(
                                            context: context,
                                            barrierDismissible: true,
                                            builder: (context) =>
                                                ShowResturantStatusDialog(
                                                    outletID:
                                                        popularRestaurantAPIProvider
                                                            .popularRestaurantResponseModel!
                                                            .newArrival![index]
                                                            .id!));
                                      },
                                      child: Image.network(
                                        popularRestaurantAPIProvider
                                                .popularRestaurantResponseModel!
                                                .restaurantBaseurl! +
                                            foods[index].image!,
                                        height: 150.0,
                                        width: 170.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  )
                                : SizedBox(
                                    height: 110.0,
                                    width: 130.0,
                                    child: InkWell(
                                      onTap: () async {
                                        // await showDialog(
                                        //     context: context,
                                        //     builder: (context) =>
                                        //         ShowResturantStatusDialog(
                                        //             outletID:
                                        //                 popularRestaurantAPIProvider
                                        //                     .popularRestaurantResponseModel!
                                        //                     .newArrival![index]
                                        //                     .id!));
                                      },
                                      child: Image.network(
                                        "https://salautomotive.in/wp-content/uploads/2017/01/no-image-available.jpg",
                                        height: 130.0,
                                        width: 130.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                          ),
                          foods[index].offer != ""
                              ? Positioned(
                                  bottom: 15,
                                  left: 0,
                                  // top: 100,
                                  child: Container(
                                    alignment: Alignment.center,
                                    transform:
                                        Matrix4.translationValues(0, 15, 0),
                                    width: 70.0,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.indigo,
                                          Colors.blue,
                                          Colors.blue,
                                        ],
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                      ),

                                      //  color: Colors.lightBlueAccent.shade100,
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(20)),
                                    ),
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(7.0),
                                        child: Column(
                                          children: [
                                            Text(
                                              foods[index].offer! + " OFF %",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2!
                                                  .copyWith(
                                                      fontSize: 11.0,
                                                      color: Colors.white),
                                            ),
                                            Text(
                                              "UPTO Rs. " + foods[index].upTo!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2!
                                                  .copyWith(
                                                      fontSize: 8.0,
                                                      color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Container()
                        ],
                      ),
                    ),
                  ),
                  UIHelper.horizontalSpaceMedium(),
                  Expanded(
                    flex: 4,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RestaurantDetailScreen(
                              id: foods[index].id!,
                            ),
                          ),
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            foods[index].restaurantName!,
                            style: CommonStyles.black13(),
                          ),
                          // Text(food.desc,
                          //     style: Theme.of(context)
                          //         .textTheme
                          //         .bodyText1
                          //         .copyWith(color: Colors.grey[600], fontSize: 13.5)),
                          UIHelper.verticalSpaceSmall(),
                          FittedBox(
                            child: Row(
                              children: [
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.star,
                                      size: 14.0,
                                      color: Colors.greenAccent,
                                    ),
                                    UIHelper.horizontalSpaceSmall(),
                                    Text(foods[index].rating!,
                                        style: TextStyle(
                                          fontSize: 12.0,
                                          color: Colors.greenAccent,
                                        ))
                                  ],
                                ),
                                UIHelper.horizontalSpaceSmall(),
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.timer,
                                      size: 12.0,
                                      color: Colors.indigoAccent,
                                    ),
                                    UIHelper.horizontalSpaceSmall(),
                                    Text(foods[index].durationLt!,
                                        style: TextStyle(fontSize: 12.0))
                                  ],
                                ),
                                UIHelper.horizontalSpaceSmall(),
                              ],
                            ),
                          ),
                          UIHelper.verticalSpaceSmall(),
                          Container(
                            //  color: Colors.blueAccent,
                            child: Text(foods[index].category!.trim(),
                                style: CommonStyles.black57S12W500()),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
}

class ShowResturantStatusDialog extends StatefulWidget {
  final String outletID;
  ShowResturantStatusDialog({Key? key, required this.outletID})
      : super(key: key);
  @override
  State<ShowResturantStatusDialog> createState() =>
      _ShowResturantStatusDialogState();
}

class _ShowResturantStatusDialogState extends State<ShowResturantStatusDialog> {
  @override
  void initState() {
    context.read<RestaurantDetailsAPIProvider>().initialize();
    if (context.read<RestaurantDetailsAPIProvider>().restaurantViewModel ==
        null) {
      context.read<RestaurantDetailsAPIProvider>().getRestaurantDetails(
          widget.outletID,
          SharedPreference.longitude.toString(),
          SharedPreference.latitude.toString(),
          "3");
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final restaurantDetailsAPIProvider =
        Provider.of<RestaurantDetailsAPIProvider>(context);
    if (restaurantDetailsAPIProvider.ifLoading) {
      return Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0)), //this right here
        child: Container(
          height: 220,
          // color: Colors.white,
          width: deviceWidth(context) * 0.83,
          // height: 200,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 40,
                  width: 40,
                  child: CircularProgressIndicator(
                    strokeWidth: 1,
                  ),
                )
              ],
            ),
          ),
        ),
      );
      // return GestureDetector(
      //     onTap: () {
      //       Navigator.of(context).pop();
      //     },
      //     child: Material(
      //         elevation: 2,
      //         type: MaterialType.transparency,
      //         child: Container(
      //           height: 220,
      //           width: deviceWidth(context) * 0.83,
      //           child: Center(
      //               child: SizedBox(
      //                   width: 100,
      //                   height: 100,
      //                   child: CircularProgressIndicator())),
      //         )));
    } else if (restaurantDetailsAPIProvider.error ||
        restaurantDetailsAPIProvider.restaurantViewModel == null ||
        restaurantDetailsAPIProvider
            .restaurantViewModel!.productList!.isEmpty) {
      return Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0)), //this right here
        child: Container(
          height: 220,
          // color: Colors.white,
          width: deviceWidth(context) * 0.83,
          // height: 200,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "No Products Images Avalilable",
                  style: CommonStyles.black12(),
                ),
              ],
            ),
          ),
        ),
      );
      // return GestureDetector(
      //   onTap: () {
      //     Navigator.of(context).pop();
      //   },
      //   child: Material(
      //       elevation: 2,
      //       type: MaterialType.transparency,
      //       child: Center(
      //         child: SizedBox(
      //           height: 220,
      //           // color: Colors.white,
      //           width: deviceWidth(context) * 0.83,
      //           child: Center(
      //             child: Text(
      //               "No Products Images Avalilable",
      //               style: CommonStyles.whiteText12BoldW500(),
      //             ),
      //           ),
      //         ),
      //       )),
      // );
    }

    // return Dialog(
    //   elevation: 2,
    //   backgroundColor: Colors.transparent,
    //   shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(20.0)), //this right here
    //   child: CarouselSlider.builder(
    //       itemCount: restaurantDetailsAPIProvider
    //           .restaurantViewModel!.productList!.length,
    //       itemBuilder: (context, index, realindex) {
    //         return InkWell(
    //           onTap: () {
    //             Navigator.of(context).pushReplacement(MaterialPageRoute(
    //                 builder: (context) => RestaurantDetailScreen(
    //                       id: widget.outletID,
    //                     )));
    //           },
    //           child: Container(
    //               width: deviceWidth(context),
    //               height: 200,
    //               padding:
    //                   EdgeInsets.only(left: 10, right: 5, top: 5, bottom: 5),
    //               decoration: BoxDecoration(
    //                   borderRadius: BorderRadius.circular(10.0),
    //                   image: DecorationImage(
    //                       fit: BoxFit.cover,
    //                       image: NetworkImage(restaurantDetailsAPIProvider
    //                               .restaurantViewModel!.retailerProfileurl! +
    //                           restaurantDetailsAPIProvider.restaurantViewModel!
    //                               .productList![index].menuImage!.first)),
    //                   boxShadow: [
    //                     BoxShadow(
    //                       color: Colors.yellow[900]!,
    //                       blurRadius: 2.0,
    //                       offset: Offset(1, 1),
    //                     ),
    //                   ])),
    //         );
    //       },
    //       options: CarouselOptions(
    //         height: 220,
    //         viewportFraction: 0.8,
    //         initialPage: 0,
    //         enableInfiniteScroll: true,
    //         reverse: false,
    //         autoPlay: true,
    //         autoPlayInterval: Duration(seconds: 3),
    //         autoPlayAnimationDuration: Duration(milliseconds: 800),
    //         autoPlayCurve: Curves.fastOutSlowIn,
    //         enlargeCenterPage: true,
    //         scrollDirection: Axis.horizontal,
    //       )),
    // );

    return Material(
        elevation: 2,
        type: MaterialType.transparency,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CarouselSlider.builder(
                  itemCount: restaurantDetailsAPIProvider
                      .restaurantViewModel!.productList!.length,
                  itemBuilder: (context, index, realindex) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => RestaurantDetailScreen(
                                  id: widget.outletID,
                                )));
                      },
                      child: Container(
                        width: deviceWidth(context) * 0.83,
                        height: 200,
                        padding: EdgeInsets.only(
                            left: 10, right: 5, top: 5, bottom: 5),
                        // decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(10.0),
                        //     image: DecorationImage(
                        //         fit: BoxFit.cover,
                        //         image: NetworkImage(restaurantDetailsAPIProvider
                        //                 .restaurantViewModel!.retailerProfileurl! +
                        //             restaurantDetailsAPIProvider
                        //                 .restaurantViewModel!
                        //                 .productList![index]
                        //                 .menuImage!
                        //                 .first)),
                        //     boxShadow: [
                        //       BoxShadow(
                        //         color: Colors.yellow[900]!,
                        //         blurRadius: 2.0,
                        //         offset: Offset(1, 1),
                        //       ),
                        //     ]),
                        child: cachedNetworkImage(
                            200,
                            deviceWidth(context) * 0.83,
                            restaurantDetailsAPIProvider
                                    .restaurantViewModel!.productBaseurl! +
                                restaurantDetailsAPIProvider
                                    .restaurantViewModel!
                                    .productList![index]
                                    .menuImage!
                                    .first),
                      ),
                    );
                  },
                  options: CarouselOptions(
                    height: 220,
                    viewportFraction: 0.8,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
                  )),
            ],
          ),
        ));
  }
}

class ResturantMessageTiles extends StatelessWidget {
  String name;
  String imageUrl;
  String rating;
  String numberOfRating;
  String price;
  String slug;

  ResturantMessageTiles(
      {required this.name,
      required this.imageUrl,
      required this.rating,
      required this.numberOfRating,
      required this.price,
      required this.slug});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: <Widget>[
          Container(
            width: deviceWidth(context) * 0.83,
            height: 200,
            padding: EdgeInsets.only(left: 10, right: 5, top: 5, bottom: 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      'assets/images/bestfood/' + imageUrl + ".jpeg",
                    )),
                boxShadow: [
                  BoxShadow(
                    color: Colors.yellow,
                    blurRadius: 2.0,
                    offset: Offset(1, 1),
                  ),
                ]),
            // child: Card(
            //   semanticContainer: true,
            //   clipBehavior: Clip.antiAliasWithSaveLayer,
            //   child: Image.asset(),
            //   shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(10.0),
            //   ),
            //   elevation: 1,
            //   margin: EdgeInsets.all(5),
            // ),
          ),
        ],
      ),
    );
  }
}

class BestFoodTiles extends StatelessWidget {
  String? name;
  String? imageUrl;
  String? rating;
  String? numberOfRating;
  String? price;
  String? slug;

  BestFoodTiles(
      {required this.name,
      required this.imageUrl,
      required this.rating,
      required this.numberOfRating,
      required this.price,
      required this.slug});

  @override
  Widget build(BuildContext context) {
    print(" ============  ${name!}");
    return InkWell(
      onTap: () {
        // Navigator.of(context).push(MaterialPageRoute(
        //     builder: (context) => AllProductViewPage(
        //           resturantDetails: SpotlightBestTopFood(
        //             image: 'assets/images/food3.jpg',
        //             name: name!,
        //             desc: 'South Indian',
        //             coupon: '30 \$ off | Use A2BSUPER',
        //             ratingTimePrice: '4.2 32 mins - Rs 130 for two',
        //           ),
        //         )));
        Navigator.of(context).pop();
      },
      child: Container(
        width: deviceWidth(context) * 2.83,

        padding: EdgeInsets.only(left: 10, right: 5, top: 5, bottom: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  'assets/images/bestfood/' + imageUrl! + ".jpeg",
                )),
            boxShadow: [
              BoxShadow(
                color: Colors.yellow,
                blurRadius: 2.0,
                offset: Offset(1, 1),
              ),
            ]),
        // child: Card(
        //   semanticContainer: true,
        //   clipBehavior: Clip.antiAliasWithSaveLayer,
        //   child: Image.asset(),
        //   shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(10.0),
        //   ),
        //   elevation: 1,
        //   margin: EdgeInsets.all(5),
        // ),
      ),
    );
  }
}

List<BestFoodTiles> resturantMessage = [
  BestFoodTiles(
      name: "Mc. D's",
      imageUrl: "ic_best_food_8",
      rating: '4.9',
      numberOfRating: '200',
      price: '15.06',
      slug: "fried_egg"),
  BestFoodTiles(
      name: "Dominos",
      imageUrl: "ic_best_food_9",
      rating: "4.9",
      numberOfRating: "100",
      price: "17.03",
      slug: ""),
  BestFoodTiles(
      name: "Burgers King",
      imageUrl: "ic_best_food_10",
      rating: "4.0",
      numberOfRating: "50",
      price: "11.00",
      slug: ""),
  BestFoodTiles(
      name: "KFC",
      imageUrl: "ic_best_food_5",
      rating: "4.00",
      numberOfRating: "100",
      price: "11.10",
      slug: ""),
  BestFoodTiles(
      name: "Pizza Hut",
      imageUrl: "ic_best_food_1",
      rating: "4.6",
      numberOfRating: "150",
      price: "12.00",
      slug: ""),
  BestFoodTiles(
      name: "New mixed salad",
      imageUrl: "ic_best_food_2",
      rating: "4.00",
      numberOfRating: "100",
      price: "11.10",
      slug: ""),
  BestFoodTiles(
      name: "Potato with meat fry",
      imageUrl: "ic_best_food_3",
      rating: "4.2",
      numberOfRating: "70",
      price: "23.0",
      slug: ""),
  BestFoodTiles(
      name: "Mc. D's",
      imageUrl: "ic_best_food_4",
      rating: '4.9',
      numberOfRating: '200',
      price: '15.06',
      slug: "fried_egg"),
  BestFoodTiles(
      name: "Red meat with salad",
      imageUrl: "ic_best_food_5",
      rating: "4.6",
      numberOfRating: "150",
      price: "12.00",
      slug: ""),
  BestFoodTiles(
      name: "Red meat with salad",
      imageUrl: "ic_best_food_6",
      rating: "4.6",
      numberOfRating: "150",
      price: "12.00",
      slug: ""),
  BestFoodTiles(
      name: "Red meat with salad",
      imageUrl: "ic_best_food_7",
      rating: "4.6",
      numberOfRating: "150",
      price: "12.00",
      slug: ""),
];

class FoodCourtListingsScreen extends StatefulWidget {
  const FoodCourtListingsScreen({Key? key, required this.foodCourtID})
      : super(key: key);
  final String foodCourtID;

  @override
  _FoodCourtListingsScreenState createState() =>
      _FoodCourtListingsScreenState();
}

class _FoodCourtListingsScreenState extends State<FoodCourtListingsScreen> {
  @override
  void initState() {
    // initialize();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final popularRestaurantAPIProvider =
        Provider.of<FoodCourtAPIProvider>(context);
    if (popularRestaurantAPIProvider.ifLoading) {
      return SizedBox(height: 120, child: Center(child: Utils.showLoading()));
    } else if (popularRestaurantAPIProvider.error) {
      return Utils.showErrorMessage(popularRestaurantAPIProvider.errorMessage);
    } else if (popularRestaurantAPIProvider.foodCourtResponseModel!.status ==
        "0") {
      return Utils.showErrorMessage(
          popularRestaurantAPIProvider.foodCourtResponseModel!.message!);
    } else {
      final List<MallItem> foods =
          popularRestaurantAPIProvider.foodCourtResponseModel!.newArrival!;

      print("Foods length  - - -- - - -  " + foods.length.toString());
      return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: foods.length,
        itemBuilder: (context, index) => Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Card(
            elevation: 10,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            shadowColor: Colors.blue,
            child: Container(
              //  margin: const EdgeInsets.all(10.0),
              height: 120,
              width: deviceWidth(context) * 0.95,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      height: 120.0,
                      width: 110.0,
                      child: Stack(
                        children: [
                          Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.white,
                              /*boxShadow: <BoxShadow>[
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 2.0,
                                )
                              ],*/
                            ),
                            child: foods[index].image != ""
                                ? SizedBox(
                                    /* height: 120.0,
                                    width: 110.0,*/
                                    child: InkWell(
                                      onTap: () async {
                                        await showDialog(
                                            context: context,
                                            barrierDismissible: true,
                                            builder: (context) =>
                                                ShowResturantStatusDialog(
                                                    outletID:
                                                        popularRestaurantAPIProvider
                                                            .foodCourtResponseModel!
                                                            .newArrival![index]
                                                            .id!));
                                      },
                                      child: Image.network(
                                        popularRestaurantAPIProvider
                                                .foodCourtResponseModel!
                                                .restaurantBaseurl! +
                                            foods[index].image!,
                                        height: 150.0,
                                        width: 170.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  )
                                : SizedBox(
                                    height: 10.0,
                                    width: 30.0,
                                    child: InkWell(
                                      onTap: () async {
                                        // await showDialog(
                                        //     context: context,
                                        //     builder: (context) =>
                                        //         ShowResturantStatusDialog(
                                        //             outletID:
                                        //                 popularRestaurantAPIProvider
                                        //                     .popularRestaurantResponseModel!
                                        //                     .newArrival![index]
                                        //                     .id!));
                                      },
                                      child: Image.network(
                                        "https://salautomotive.in/wp-content/uploads/2017/01/no-image-available.jpg",
                                        height: 130.0,
                                        width: 130.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                          ),
                          foods[index].offer != ""
                              ? Positioned(
                                  bottom: 15,
                                  left: 0,
                                  // top: 100,
                                  child: Container(
                                    alignment: Alignment.center,
                                    transform:
                                        Matrix4.translationValues(0, 15, 0),
                                    width: 70.0,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.indigo,
                                          Colors.blue,
                                          Colors.blue,
                                        ],
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                      ),

                                      //  color: Colors.lightBlueAccent.shade100,
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(20)),
                                    ),
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(7.0),
                                        child: Column(
                                          children: [
                                            Text(
                                              foods[index].offer! + " OFF %",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2!
                                                  .copyWith(
                                                      fontSize: 11.0,
                                                      color: Colors.white),
                                            ),
                                            Text(
                                              "UPTO Rs. " + foods[index].upTo!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2!
                                                  .copyWith(
                                                      fontSize: 8.0,
                                                      color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Container()
                        ],
                      ),
                    ),
                  ),
                  UIHelper.horizontalSpaceMedium(),
                  Expanded(
                    flex: 4,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RestaurantDetailScreen(
                              id: foods[index].id!,
                            ),
                          ),
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            foods[index].restaurantName!,
                            style: CommonStyles.black13(),
                          ),
                          // Text(food.desc,
                          //     style: Theme.of(context)
                          //         .textTheme
                          //         .bodyText1
                          //         .copyWith(color: Colors.grey[600], fontSize: 13.5)),
                          UIHelper.verticalSpaceSmall(),
                          FittedBox(
                            child: Row(
                              children: [
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.star,
                                      size: 14.0,
                                      color: Colors.greenAccent,
                                    ),
                                    UIHelper.horizontalSpaceSmall(),
                                    Text(foods[index].rating!,
                                        style: TextStyle(
                                          fontSize: 12.0,
                                          color: Colors.greenAccent,
                                        ))
                                  ],
                                ),
                                UIHelper.horizontalSpaceSmall(),
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.timer,
                                      size: 12.0,
                                      color: Colors.indigoAccent,
                                    ),
                                    UIHelper.horizontalSpaceSmall(),
                                    Text(foods[index].durationLt!,
                                        style: TextStyle(fontSize: 12.0))
                                  ],
                                ),
                                UIHelper.horizontalSpaceSmall(),
                              ],
                            ),
                          ),
                          UIHelper.verticalSpaceSmall(),
                          Container(
                            //  color: Colors.blueAccent,
                            child: Text(foods[index].category!.trim(),
                                style: CommonStyles.black57S12W500()),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
}

// class ShowResturantStatusDialog extends StatefulWidget {
//   final String outletID;
//   ShowResturantStatusDialog({Key? key, required this.outletID})
//       : super(key: key);
//   @override
//   State<ShowResturantStatusDialog> createState() =>
//       _ShowResturantStatusDialogState();
// }

// class _ShowResturantStatusDialogState extends State<ShowResturantStatusDialog> {
//   @override
//   void initState() {
//     context.read<RestaurantDetailsAPIProvider>().initialize();
//     if (context.read<RestaurantDetailsAPIProvider>().restaurantViewModel ==
//         null) {
//       context.read<RestaurantDetailsAPIProvider>().getRestaurantDetails(
//           widget.outletID,
//           SharedPreference.longitude.toString(),
//           SharedPreference.latitude.toString(),
//           "3");
//     }
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final restaurantDetailsAPIProvider =
//         Provider.of<RestaurantDetailsAPIProvider>(context);
//     if (restaurantDetailsAPIProvider.ifLoading) {
//       return Dialog(
//         shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(20.0)), //this right here
//         child: Container(
//           height: 220,
//           // color: Colors.white,
//           width: deviceWidth(context) * 0.83,
//           // height: 200,
//           child: Padding(
//             padding: const EdgeInsets.all(12.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 SizedBox(
//                   height: 40,
//                   width: 40,
//                   child: CircularProgressIndicator(
//                     strokeWidth: 1,
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       );
//       // return GestureDetector(
//       //     onTap: () {
//       //       Navigator.of(context).pop();
//       //     },
//       //     child: Material(
//       //         elevation: 2,
//       //         type: MaterialType.transparency,
//       //         child: Container(
//       //           height: 220,
//       //           width: deviceWidth(context) * 0.83,
//       //           child: Center(
//       //               child: SizedBox(
//       //                   width: 100,
//       //                   height: 100,
//       //                   child: CircularProgressIndicator())),
//       //         )));
//     } else if (restaurantDetailsAPIProvider.error ||
//         restaurantDetailsAPIProvider.restaurantViewModel == null ||
//         restaurantDetailsAPIProvider
//             .restaurantViewModel!.productList!.isEmpty) {
//       return Dialog(
//         shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(20.0)), //this right here
//         child: Container(
//           height: 220,
//           // color: Colors.white,
//           width: deviceWidth(context) * 0.83,
//           // height: 200,
//           child: Padding(
//             padding: const EdgeInsets.all(12.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Text(
//                   "No Products Images Avalilable",
//                   style: CommonStyles.black12(),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
//       // return GestureDetector(
//       //   onTap: () {
//       //     Navigator.of(context).pop();
//       //   },
//       //   child: Material(
//       //       elevation: 2,
//       //       type: MaterialType.transparency,
//       //       child: Center(
//       //         child: SizedBox(
//       //           height: 220,
//       //           // color: Colors.white,
//       //           width: deviceWidth(context) * 0.83,
//       //           child: Center(
//       //             child: Text(
//       //               "No Products Images Avalilable",
//       //               style: CommonStyles.whiteText12BoldW500(),
//       //             ),
//       //           ),
//       //         ),
//       //       )),
//       // );
//     }

//     // return Dialog(
//     //   elevation: 2,
//     //   backgroundColor: Colors.transparent,
//     //   shape: RoundedRectangleBorder(
//     //       borderRadius: BorderRadius.circular(20.0)), //this right here
//     //   child: CarouselSlider.builder(
//     //       itemCount: restaurantDetailsAPIProvider
//     //           .restaurantViewModel!.productList!.length,
//     //       itemBuilder: (context, index, realindex) {
//     //         return InkWell(
//     //           onTap: () {
//     //             Navigator.of(context).pushReplacement(MaterialPageRoute(
//     //                 builder: (context) => RestaurantDetailScreen(
//     //                       id: widget.outletID,
//     //                     )));
//     //           },
//     //           child: Container(
//     //               width: deviceWidth(context),
//     //               height: 200,
//     //               padding:
//     //                   EdgeInsets.only(left: 10, right: 5, top: 5, bottom: 5),
//     //               decoration: BoxDecoration(
//     //                   borderRadius: BorderRadius.circular(10.0),
//     //                   image: DecorationImage(
//     //                       fit: BoxFit.cover,
//     //                       image: NetworkImage(restaurantDetailsAPIProvider
//     //                               .restaurantViewModel!.retailerProfileurl! +
//     //                           restaurantDetailsAPIProvider.restaurantViewModel!
//     //                               .productList![index].menuImage!.first)),
//     //                   boxShadow: [
//     //                     BoxShadow(
//     //                       color: Colors.yellow[900]!,
//     //                       blurRadius: 2.0,
//     //                       offset: Offset(1, 1),
//     //                     ),
//     //                   ])),
//     //         );
//     //       },
//     //       options: CarouselOptions(
//     //         height: 220,
//     //         viewportFraction: 0.8,
//     //         initialPage: 0,
//     //         enableInfiniteScroll: true,
//     //         reverse: false,
//     //         autoPlay: true,
//     //         autoPlayInterval: Duration(seconds: 3),
//     //         autoPlayAnimationDuration: Duration(milliseconds: 800),
//     //         autoPlayCurve: Curves.fastOutSlowIn,
//     //         enlargeCenterPage: true,
//     //         scrollDirection: Axis.horizontal,
//     //       )),
//     // );

//     return Material(
//         elevation: 2,
//         type: MaterialType.transparency,
//         child: Center(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               CarouselSlider.builder(
//                   itemCount: restaurantDetailsAPIProvider
//                       .restaurantViewModel!.productList!.length,
//                   itemBuilder: (context, index, realindex) {
//                     return InkWell(
//                       onTap: () {
//                         Navigator.of(context).pushReplacement(MaterialPageRoute(
//                             builder: (context) => RestaurantDetailScreen(
//                                   id: widget.outletID,
//                                 )));
//                       },
//                       child: Container(
//                         width: deviceWidth(context) * 0.83,
//                         height: 200,
//                         padding: EdgeInsets.only(
//                             left: 10, right: 5, top: 5, bottom: 5),
//                         // decoration: BoxDecoration(
//                         //     borderRadius: BorderRadius.circular(10.0),
//                         //     image: DecorationImage(
//                         //         fit: BoxFit.cover,
//                         //         image: NetworkImage(restaurantDetailsAPIProvider
//                         //                 .restaurantViewModel!.retailerProfileurl! +
//                         //             restaurantDetailsAPIProvider
//                         //                 .restaurantViewModel!
//                         //                 .productList![index]
//                         //                 .menuImage!
//                         //                 .first)),
//                         //     boxShadow: [
//                         //       BoxShadow(
//                         //         color: Colors.yellow[900]!,
//                         //         blurRadius: 2.0,
//                         //         offset: Offset(1, 1),
//                         //       ),
//                         //     ]),
//                         child: cachedNetworkImage(
//                             200,
//                             deviceWidth(context) * 0.83,
//                             restaurantDetailsAPIProvider
//                                     .restaurantViewModel!.productBaseurl! +
//                                 restaurantDetailsAPIProvider
//                                     .restaurantViewModel!
//                                     .productList![index]
//                                     .menuImage!
//                                     .first),
//                       ),
//                     );
//                   },
//                   options: CarouselOptions(
//                     height: 220,
//                     viewportFraction: 0.8,
//                     initialPage: 0,
//                     enableInfiniteScroll: true,
//                     reverse: false,
//                     autoPlay: true,
//                     autoPlayInterval: Duration(seconds: 3),
//                     autoPlayAnimationDuration: Duration(milliseconds: 800),
//                     autoPlayCurve: Curves.fastOutSlowIn,
//                     enlargeCenterPage: true,
//                     scrollDirection: Axis.horizontal,
//                   )),
//             ],
//           ),
//         ));
//   }
// }
