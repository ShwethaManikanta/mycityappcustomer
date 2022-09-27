import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:mycityapp/Food/CommonWidgets/common_styles.dart';
import 'package:mycityapp/Food/CommonWidgets/screen_width_and_height.dart';
import 'package:mycityapp/Food/CommonWidgets/utils.dart';
import 'package:mycityapp/Food/Services/banner_api_provider.dart';
import 'package:mycityapp/Food/pages/allRestaurantScreen/all_restaurants_screen.dart';
import '../../../Services/popular_restaurant_api_provider.dart';
import '../../restaurantDetailsPage/restaurant_detail_screen.dart';
import '../../utils/loaction_shared_preference.dart';
import 'package:provider/provider.dart';

// class InTheSpotlightView extends StatefulWidget {
//   @override
//   State<InTheSpotlightView> createState() => _InTheSpotlightViewState();
// }

// class _InTheSpotlightViewState extends State<InTheSpotlightView> {
//   List<String> bannerImg = [
//     "assets/images/banner_img1.webp",
//     "assets/images/banner_img2.jpg"
//   ];

//   List<String> bannerMeatImg = [
//     "assets/images/banner_meat1.jpg",
//     "assets/images/banner_meat2.webp"
//   ];

//   List<String> foodImgUrl = [
//     "assets/images/maxresdefault.jpg",
//     "assets/images/meat.jpg",
//     "assets/images/bakery.jpg",
//   ];
//   List<String> foodName = ["Restaurants", "Meat", "Bakery"];

//   @override
//   void initState() {
//     super.initState();
//     if (mounted) {
//       print("------------ WIdget is mounted ____----------------");
//     }

//     if (context.read<TakeAwayAPIProvider>().takeAwayResponseModel == null) {
//       context.read<TakeAwayAPIProvider>().getTakeAways();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Padding(
//             padding: EdgeInsets.only(bottom: 12, left: 3),
//             child: Text(
//               'Categories',
//               style: CommonStyles.black57S18(),
//               textAlign: TextAlign.left,
//             ),
//           ),
//           Center(
//             child: ListView.builder(
//                 physics: BouncingScrollPhysics(),
//                 itemCount: foodName.length,
//                 shrinkWrap: true,
//                 scrollDirection: Axis.vertical,
//                 itemBuilder: (BuildContext context, int index) {
//                   print("foods length  ==== ${foodName.length}");
//                   return Padding(
//                     padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
//                     child: InkWell(
//                       onTap: () {
//                         if (index == 0) {
//                           Navigator.of(context).push(MaterialPageRoute(
//                               builder: (context) => AllRestaurantsScreen()));
//                         }
//                         if (index == 1) {
//                           Navigator.of(context).push(MaterialPageRoute(
//                               builder: (context) => MeatScreen()));
//                         }
//                         if (index == 2) {
//                           Navigator.of(context).push(MaterialPageRoute(
//                               builder: (context) => AllRestaurantsScreen()));
//                         }
//                       },
//                       child: Container(
//                         decoration: BoxDecoration(
//                             color: Colors.white,
//                             boxShadow: [
//                               BoxShadow(
//                                   color: Colors.black45,
//                                   offset: Offset(0, 0),
//                                   blurRadius: 8)
//                             ],
//                             borderRadius: BorderRadius.circular(14),
//                             border: Border.all(
//                                 color: Colors.brown[400]!,
//                                 width: 1,
//                                 style: BorderStyle.solid)),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.only(
//                                   top: 8.0, bottom: 8, right: 8.0, left: 8.0),
//                               child: Text(
//                                 foodName[index],
//                                 style: CommonStyles.black57S18(),
//                                 textAlign: TextAlign.right,
//                               ),
//                             ),
//                             // Container(
//                             //   height: 200,
//                             //   width: deviceWidth(context) * 0.9,
//                             //   child: ,
//                             // )
//                             // cachedNetworkImage(
//                             //     200, deviceWidth(context) * 0.9, imageUrl)
//                             AspectRatio(
//                               aspectRatio: 4 / 2,
//                               child: Stack(
//                                 children: [
//                                   bannerImages(
//                                       images: index == 0
//                                           ? bannerImg
//                                           : bannerMeatImg),
//                                   // Container(
//                                   //   decoration: BoxDecoration(
//                                   //       borderRadius: BorderRadius.only(
//                                   //           topLeft: Radius.circular(14),
//                                   //           topRight: Radius.circular(14)),
//                                   //       image: DecorationImage(
//                                   //           fit: BoxFit.fill,
//                                   //           image: AssetImage(
//                                   //             foodImgUrl[index],
//                                   //           ))),
//                                   // ),
//                                   Positioned(
//                                     bottom: 20,
//                                     child: Container(
//                                       decoration: BoxDecoration(
//                                         color: Colors.purple[800],
//                                       ),
//                                       child: Center(
//                                           child: Padding(
//                                         padding: const EdgeInsets.all(10.0),
//                                         child: Text(
//                                           "15% Off",
//                                           style: CommonStyles
//                                               .whiteText12BoldW500(),
//                                         ),
//                                       )),
//                                     ),
//                                   ),
//                                   Positioned(
//                                     bottom: 20,
//                                     right: 20,
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: Container(
//                                         decoration: BoxDecoration(
//                                           color: Colors.red[800],
//                                         ),
//                                         child: Center(
//                                             child: Padding(
//                                           padding: const EdgeInsets.all(10.0),
//                                           child: Text(
//                                             "15% Off",
//                                             style: CommonStyles
//                                                 .whiteText12BoldW500(),
//                                           ),
//                                         )),
//                                       ),
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ),
//                             Divider(
//                               height: 1,
//                               thickness: 0.5,
//                               color: Colors.black54,
//                             ),
//                             Row(
//                               children: [],
//                             ),
//                             // CircleAvatar(
//                             //   backgroundImage:
//                             //       AssetImage(foodImgUrl[index]),
//                             //   radius: 40,
//                             //   backgroundColor: Colors.transparent,
//                             // )),

//                             Padding(
//                               padding: const EdgeInsets.only(
//                                   left: 8, top: 2.0, bottom: 4, right: 8.0),
//                               child: Text(
//                                 "Pizza, Dosa, Idli, Burger, Roll and more...",
//                                 style: CommonStyles.black57S14(),
//                               ),
//                             ),
//                             Divider(
//                               height: 1,
//                               thickness: 0.5,
//                               color: Colors.black54,
//                             ),
//                             bottomSwiper(bottomSwiper: _listBottom)
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                 }),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           // Padding(
//           //   padding: const EdgeInsets.all(5.0),
//           //   child: Row(
//           //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           //     children: [
//           //       _buildSpotlightHeaderView(context),
//           //       InkWell(
//           //         onTap: () {
//           //           // Navigator.push(
//           //           //   context,
//           //           //   MaterialPageRoute(
//           //           //     builder: (context) => OffersScreen(),
//           //           //   ),
//           //           // );
//           //         },
//           //         child: Row(
//           //           children: <Widget>[
//           //             Text(
//           //               'SEE ALL',
//           //               style: Theme.of(context)
//           //                   .textTheme
//           //                   .bodyText1!
//           //                   .copyWith(fontWeight: FontWeight.bold),
//           //             ),
//           //             UIHelper.horizontalSpaceExtraSmall(),
//           //             ClipOval(
//           //               child: Container(
//           //                 alignment: Alignment.center,
//           //                 color: Colors.orange,
//           //                 height: 25.0,
//           //                 width: 25.0,
//           //                 child: Icon(
//           //                   Icons.arrow_forward_ios,
//           //                   size: 12.0,
//           //                   color: Colors.white,
//           //                 ),
//           //               ),
//           //             )
//           //           ],
//           //         ),
//           //       )
//           //     ],
//           //   ),
//           // ),
//           // UIHelper.verticalSpaceMedium(),
//           // takeAwayRestaturantList()
//         ],
//       ),
//     );
//   }

//   Widget bannerImages({required List<String> images}) {
//     return Swiper(
//       itemHeight: 100,
//       duration: 500,
//       itemWidth: double.infinity,
//       // pagination: SwiperPagination(),
//       itemCount: images.length,
//       itemBuilder: (BuildContext context, int index) => Container(
//         decoration: BoxDecoration(
//             // borderRadius: BorderRadius.only(
//             //     topLeft: Radius.circular(14), topRight: Radius.circular(14)),
//             image: DecorationImage(
//                 fit: BoxFit.fill, image: AssetImage(images[index]))),
//       ),
//       autoplay: true,
//       viewportFraction: 1.0,
//       scale: 0.9,
//     );
//   }

//   List<BottomSwiper> _listBottom = [
//     BottomSwiper(
//         image1: Icons.umbrella_outlined,
//         image2: Icons.snowboarding_rounded,
//         message: "Best offers 15% off on any products."),
//     BottomSwiper(
//         image1: Icons.umbrella_outlined,
//         image2: Icons.snowboarding_rounded,
//         message: "Best offers 15% off on any products."),
//     BottomSwiper(
//         image1: Icons.umbrella_outlined,
//         image2: Icons.snowboarding_rounded,
//         message: "Best offers 15% off on any products.")
//   ];

//   Widget bottomSwiper({required List<BottomSwiper> bottomSwiper}) {
//     return SizedBox(
//       height: 42,
//       child: Center(
//         child: Swiper(
//           itemHeight: 20,
//           duration: 500,
//           itemWidth: double.infinity,
//           // pagination: SwiperPagination(),
//           itemCount: bottomSwiper.length,
//           itemBuilder: (BuildContext context, int index) => ClipRRect(
//               borderRadius: BorderRadius.circular(10),
//               child: Row(
//                 children: [
//                   Icon(
//                     bottomSwiper[index].image1,
//                     color: Colors.yellow[900],
//                     size: 30,
//                   ),
//                   Text(
//                     bottomSwiper[index].message,
//                     style: CommonStyles.black12(),
//                   ),
//                   Icon(
//                     bottomSwiper[index].image2,
//                     color: Colors.brown,
//                     size: 30,
//                   ),
//                 ],
//               )

//               // cachedNetworkImage(
//               //     100,
//               //     double.infinity,
//               //     bannerListAPIProvider.bannerListResponseModel!.imageBaseurl! +
//               //         images[index].bannerImage!),
//               ),
//           autoplay: true,
//           viewportFraction: 1.0,
//           scale: 0.9,
//         ),
//       ),
//     );
//   }

//   Widget takeAwayRestaturantList() {
//     final takeAwayAPIProvider = Provider.of<TakeAwayAPIProvider>(context);
//     return takeAwayAPIProvider.ifLoading
//         ? Center(
//             child: SizedBox(
//               height: 25,
//               width: 25,
//               child: CircularProgressIndicator(
//                 strokeWidth: 1,
//               ),
//             ),
//           )
//         : (takeAwayAPIProvider.takeAwayResponseModel != null &&
//                 takeAwayAPIProvider.takeAwayResponseModel!.newArrival != null)
//             ? LimitedBox(
//                 maxHeight: 300.0,
//                 child: GridView.builder(
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: MediaQuery.of(context).orientation ==
//                               Orientation.landscape
//                           ? 3
//                           : 2,
//                       crossAxisSpacing: 5,
//                       mainAxisSpacing: 8,
//                       childAspectRatio: 0.5),
//                   physics: ScrollPhysics(),
//                   scrollDirection: Axis.horizontal,
//                   itemCount: takeAwayAPIProvider
//                       .takeAwayResponseModel!.newArrival!.length,
//                   itemBuilder: (context, index) => SpotlightBestTopFoodItem(
//                     foods: takeAwayAPIProvider
//                         .takeAwayResponseModel!.newArrival![index],
//                     baseImagreUrl: takeAwayAPIProvider
//                         .takeAwayResponseModel!.restaurantBaseurl!,
//                   ),
//                 ),
//               )
//             : Center(
//                 child: Text("Service not available in your location"),
//               );
//   }

//   Container _buildSpotlightHeaderView(BuildContext context) => Container(
//         margin: const EdgeInsets.symmetric(horizontal: 10.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Row(
//               children: <Widget>[
//                 Icon(Icons.shopping_basket, size: 20.0),
//                 UIHelper.horizontalSpaceSmall(),
//                 Text(
//                   'In the Spotlight!',
//                   style: Theme.of(context)
//                       .textTheme
//                       .headline4!
//                       .copyWith(fontSize: 20.0),
//                 )
//               ],
//             ),
//             UIHelper.verticalSpaceExtraSmall(),
//             Text(
//               'Explore sponsored partner brands',
//               style: Theme.of(context)
//                   .textTheme
//                   .bodyText1!
//                   .copyWith(color: Colors.grey),
//             ),
//           ],
//         ),
//       );
// }

class RestaurantViewModel extends StatefulWidget {
  const RestaurantViewModel({Key? key}) : super(key: key);

  @override
  _RestaurantViewModelState createState() => _RestaurantViewModelState();
}

class _RestaurantViewModelState extends State<RestaurantViewModel> {
  @override
  void initState() {
    initialize();
    super.initState();
  }

  initialize() {
    context.read<PopularRestaurantAPIProvider>().initialize();
    if (context
            .read<PopularRestaurantAPIProvider>()
            .popularRestaurantResponseModel ==
        null) {
      context.read<PopularRestaurantAPIProvider>().getPopularRestaurant(
          lat: SharedPreference.latitude.toString(),
          long: SharedPreference.longitude.toString(),
          filter: "1",
          type: "1",
          foodType: "3");
    }
  }

  Widget getSuccessAPICall(Widget widget) {
    final restaurantOfferBannerAPIProvider =
        Provider.of<RestaurantOfferBannerAPIProvider>(context);
    return restaurantOfferBannerAPIProvider.ifLoading
        ? Utils.showLoading()
        : restaurantOfferBannerAPIProvider.error
            ? Utils.showErrorMessage(
                restaurantOfferBannerAPIProvider.errorMessage)
            : widget;
  }

  List<Color> colorizeColors = [
    Colors.cyan,
    Colors.blue,
    Colors.cyanAccent,
    Colors.yellowAccent,
  ];

  // List<Color> colorizeColors = [
  //   Colors.purple,
  //   Colors.blue,
  //   Colors.yellow,
  //   Colors.red,
  // ];

  @override
  Widget build(BuildContext context) {
    return bannerImages();
  }

  Widget bannerImages() {
    final popularRestaurantAPIProvider =
        Provider.of<PopularRestaurantAPIProvider>(context);
    if (popularRestaurantAPIProvider.ifLoading) {
      return Utils.showLoading();
    } else if (popularRestaurantAPIProvider.error) {
      return Container(
          height: 200,
          child: Utils.showErrorMessage(
              popularRestaurantAPIProvider.errorMessage));
    } else if (popularRestaurantAPIProvider
            .popularRestaurantResponseModel!.newArrival ==
        null) {
      return Utils.showLoading();
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: AnimatedTextKit(
                  animatedTexts: [
                    // isRepeatingAnimation: true,
                    ColorizeAnimatedText("Restaurants",
                        textStyle: CommonStyles.black57S18(),
                        textAlign: TextAlign.right,
                        colors: colorizeColors)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  right: 4.0,
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AllRestaurantsScreen(
                              storeType: "1",
                            )));
                  },
                  child: Row(
                    children: [
                      AnimatedTextKit(
                        animatedTexts: [
                          // isRepeatingAnimation: true,
                          ColorizeAnimatedText("See all",
                              textStyle: CommonStyles.black12(),
                              textAlign: TextAlign.right,
                              colors: colorizeColors)
                        ],
                      ),
                      Utils.getSizedBox(width: 5),
                      Container(
                          decoration: BoxDecoration(
                              // shape: BoxShape.circle,
                              color: Color.fromARGB(255, 0, 24, 44)),
                          child: Icon(
                            Icons.keyboard_arrow_right_outlined,
                            color: Colors.white,
                            size: 19,
                          )),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Utils.getSizedBox(height: 5),
          SizedBox(
            height: 230,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: popularRestaurantAPIProvider
                  .popularRestaurantResponseModel!.newArrival!.length,
              clipBehavior: Clip.none,
              itemBuilder: (context, int index) {
                return Card(
                  shadowColor: Colors.lightBlue,
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.0)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RestaurantDetailScreen(
                                    id: popularRestaurantAPIProvider
                                        .popularRestaurantResponseModel!
                                        .newArrival![index]
                                        .id!,
                                  ),
                                ),
                              );
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Container(
                                //   height: 200,
                                //   width: deviceWidth(context) * 0.9,
                                //   child: ,
                                // )
                                // cachedNetworkImage(
                                //     200, deviceWidth(context) * 0.9, imageUrl)
                                Stack(
                                  children: [
                                    Container(
                                      height: 130,
                                      width: deviceWidth(context) * 0.40,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(0),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  popularRestaurantAPIProvider
                                                          .popularRestaurantResponseModel!
                                                          .restaurantBaseurl! +
                                                      popularRestaurantAPIProvider
                                                          .popularRestaurantResponseModel!
                                                          .newArrival![index]
                                                          .image!))),
                                    ),
                                    // Container(
                                    //   decoration: BoxDecoration(
                                    //       borderRadius: BorderRadius.only(
                                    //           topLeft: Radius.circular(14),
                                    //           topRight: Radius.circular(14)),
                                    //       image: DecorationImage(
                                    //           fit: BoxFit.fill,
                                    //           image: AssetImage(
                                    //             foodImgUrl[index],
                                    //           ))),
                                    // ),

                                    Visibility(
                                      visible: popularRestaurantAPIProvider
                                                  .popularRestaurantResponseModel!
                                                  .newArrival![index]
                                                  .offer !=
                                              null &&
                                          popularRestaurantAPIProvider
                                                  .popularRestaurantResponseModel!
                                                  .newArrival![index]
                                                  .offer !=
                                              "",
                                      child: Positioned(
                                        bottom: 0,
                                        left: 0,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                bottomLeft:
                                                    Radius.circular(20)),
                                            color: Colors.red[800],
                                          ),
                                          child: Center(
                                              child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Text(
                                              "Upto " +
                                                  popularRestaurantAPIProvider
                                                      .popularRestaurantResponseModel!
                                                      .newArrival![index]
                                                      .offer! +
                                                  "% Off",
                                              style: CommonStyles
                                                  .whiteText12BoldW500(),
                                            ),
                                          )),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                /* Divider(
                                    height: 1,
                                    thickness: 0.5,
                                    color: Colors.black54,
                                    ),*/

                                // CircleAvatar(
                                //   backgroundImage:
                                //       AssetImage(foodImgUrl[index]),
                                //   radius: 40,
                                //   backgroundColor: Colors.transparent,
                                // )),
                                // Padding(
                                //   padding: const EdgeInsets.only(
                                //       top: 4.0, right: 8.0, left: 8.0),
                                //   child: Text(
                                //     restaurantOfferBannerAPIProvider
                                //         .offerBannerResponseModel!
                                //         .offerBanner![index]
                                //         .!,
                                //     style: CommonStyles.black57S18(),
                                //     textAlign: TextAlign.right,
                                //   ),
                                // ),

                                // Divider(
                                //   height: 1,
                                //   thickness: 0.5,
                                //   color: Colors.black54,
                                // ),

                                Container(
                                  width: deviceWidth(context) * 0.40,
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 0,
                                            top: 10.0,
                                            bottom: 0,
                                            right: 0),
                                        child: Container(
                                          //  color: Colors.blue,
                                          child: Text(
                                            popularRestaurantAPIProvider
                                                .popularRestaurantResponseModel!
                                                .newArrival![index]
                                                .restaurantName!
                                                .trim(),
                                            style: CommonStyles.black57S14(),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        //  color: Colors.lightBlueAccent,
                                        width: 130,
                                        height: 30,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 0,
                                              top: 2.0,
                                              bottom: 4,
                                              right: 8.0),
                                          child: popularRestaurantAPIProvider
                                                      .popularRestaurantResponseModel!
                                                      .newArrival![index]
                                                      .description ==
                                                  ""
                                              ? Text(
                                                  "Description",
                                                  style:
                                                      CommonStyles.black57S14(),
                                                )
                                              : Text(
                                                  popularRestaurantAPIProvider
                                                      .popularRestaurantResponseModel!
                                                      .newArrival![index]
                                                      .description!,
                                                  maxLines: 1,
                                                  overflow: TextOverflow.fade,
                                                  style: CommonStyles.black11(),
                                                ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.add_road,
                                                size: 10,
                                              ),
                                              Text(
                                                  popularRestaurantAPIProvider
                                                      .popularRestaurantResponseModel!
                                                      .newArrival![index]
                                                      .distance!,
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500))
                                            ],
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Flexible(
                                            flex: 1,
                                            child: FittedBox(
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.timer,
                                                    size: 10,
                                                  ),
                                                  Text(
                                                      popularRestaurantAPIProvider
                                                          .popularRestaurantResponseModel!
                                                          .newArrival![index]
                                                          .durationLt!,
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w500))
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.star,
                                                color: Colors.green,
                                                size: 10,
                                              ),
                                              Text(
                                                  popularRestaurantAPIProvider
                                                      .popularRestaurantResponseModel!
                                                      .newArrival![index]
                                                      .rating!,
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      color: Colors.green,
                                                      fontWeight:
                                                          FontWeight.w500))
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      );
    }
  }
}

class MeatBannerOfferView extends StatefulWidget {
  const MeatBannerOfferView({Key? key}) : super(key: key);

  @override
  _MeatBannerViewState createState() => _MeatBannerViewState();
}

class _MeatBannerViewState extends State<MeatBannerOfferView> {
  @override
  void initState() {
    initialize();
    super.initState();
  }

  initialize() {
    if (context.read<PopularMeatAPIProvider>().popularRestaurantResponseModel ==
        null) {
      context.read<PopularMeatAPIProvider>().getPopularRestaurant(
          lat: SharedPreference.latitude.toString(),
          long: SharedPreference.longitude.toString(),
          filter: "1",
          type: "2",
          foodType: "3");
    }
  }

  Widget getSuccessAPICall(Widget widget) {
    final popularMeatAPIProvider = Provider.of<PopularMeatAPIProvider>(context);
    return popularMeatAPIProvider.ifLoading
        ? Utils.showLoading()
        : popularMeatAPIProvider.error
            ? Utils.showErrorMessage(popularMeatAPIProvider.errorMessage)
            : widget;
  }

  @override
  Widget build(BuildContext context) {
    return bannerImages();

    // Padding(
    //   padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
    //   child: InkWell(
    //     onTap: () {
    //       Navigator.of(context).push(
    //           MaterialPageRoute(builder: (context) => AllRestaurantsScreen()));
    //     },
    //     child: Container(
    //       decoration: BoxDecoration(
    //           color: Colors.white,
    //           boxShadow: [
    //             BoxShadow(
    //                 color: Colors.black45, offset: Offset(0, 0), blurRadius: 8)
    //           ],
    //           borderRadius: BorderRadius.circular(14),
    //           border: Border.all(
    //               color: Colors.brown[400]!,
    //               width: 1,
    //               style: BorderStyle.solid)),
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           Padding(
    //             padding: const EdgeInsets.only(
    //                 top: 8.0, bottom: 8, right: 8.0, left: 8.0),
    //             child: Text(
    //               "Restaurants",
    //               style: CommonStyles.black57S18(),
    //               textAlign: TextAlign.right,
    //             ),
    //           ),
    //           // Container(
    //           //   height: 200,
    //           //   width: deviceWidth(context) * 0.9,
    //           //   child: ,
    //           // )
    //           // cachedNetworkImage(
    //           //     200, deviceWidth(context) * 0.9, imageUrl)
    //           AspectRatio(
    //             aspectRatio: 4 / 2,
    //             child: Stack(
    //               children: [
    //                 bannerImages(),
    //                 // Container(
    //                 //   decoration: BoxDecoration(
    //                 //       borderRadius: BorderRadius.only(
    //                 //           topLeft: Radius.circular(14),
    //                 //           topRight: Radius.circular(14)),
    //                 //       image: DecorationImage(
    //                 //           fit: BoxFit.fill,
    //                 //           image: AssetImage(
    //                 //             foodImgUrl[index],
    //                 //           ))),
    //                 // ),

    //                 Positioned(
    //                   bottom: 20,
    //                   right: 20,
    //                   child: Padding(
    //                     padding: const EdgeInsets.all(8.0),
    //                     child: Container(
    //                       decoration: BoxDecoration(
    //                         color: Colors.red[800],
    //                       ),
    //                       child: Center(
    //                           child: Padding(
    //                         padding: const EdgeInsets.all(10.0),
    //                         child: Text(
    //                           "15% Off",
    //                           style: CommonStyles.whiteText12BoldW500(),
    //                         ),
    //                       )),
    //                     ),
    //                   ),
    //                 )
    //               ],
    //             ),
    //           ),
    //           Divider(
    //             height: 1,
    //             thickness: 0.5,
    //             color: Colors.black54,
    //           ),
    //           Row(
    //             children: [],
    //           ),
    //           // CircleAvatar(
    //           //   backgroundImage:
    //           //       AssetImage(foodImgUrl[index]),
    //           //   radius: 40,
    //           //   backgroundColor: Colors.transparent,
    //           // )),

    //           Padding(
    //             padding: const EdgeInsets.only(
    //                 left: 8, top: 2.0, bottom: 4, right: 8.0),
    //             child: Text(
    //               "Pizza, Dosa, Idli, Burger, Roll and more...",
    //               style: CommonStyles.black57S14(),
    //             ),
    //           ),
    //           Divider(
    //             height: 1,
    //             thickness: 0.5,
    //             color: Colors.black54,
    //           ),
    //           bottomSwiper(bottomSwiper: _listBottom)
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }

  List<Color> colorizeColors = [
    Colors.cyan,
    Colors.blue,
    Colors.cyanAccent,
    Colors.yellowAccent,
  ];

  Widget bannerImages() {
    final popularMeatAPIProvider = Provider.of<PopularMeatAPIProvider>(context);
    if (popularMeatAPIProvider.ifLoading) {
      return Utils.showLoading();
    } else {
      if (popularMeatAPIProvider.error) {
        return Container(
            height: 200,
            child: Utils.showErrorMessage(popularMeatAPIProvider.errorMessage));
      } else {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      // isRepeatingAnimation: true,
                      ColorizeAnimatedText("Fresh Meat",
                          textStyle: CommonStyles.black57S18(),
                          textAlign: TextAlign.right,
                          colors: colorizeColors)
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    right: 4.0,
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AllRestaurantsScreen(
                                storeType: "2",
                              )));
                    },
                    child: Row(
                      children: [
                        AnimatedTextKit(
                          animatedTexts: [
                            // isRepeatingAnimation: true,
                            ColorizeAnimatedText("See all",
                                textStyle: CommonStyles.black12(),
                                textAlign: TextAlign.right,
                                colors: colorizeColors)
                          ],
                        ),
                        Utils.getSizedBox(width: 5),
                        Container(
                            decoration: BoxDecoration(
                                // shape: BoxShape.circle,
                                color: Color.fromARGB(255, 0, 24, 44)),
                            child: Icon(
                              Icons.keyboard_arrow_right_outlined,
                              color: Colors.white,
                              size: 19,
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Utils.getSizedBox(height: 5),
            SizedBox(
              height: 230,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: popularMeatAPIProvider
                    .popularRestaurantResponseModel!.newArrival!.length,
                clipBehavior: Clip.none,
                itemBuilder: (context, int index) {
                  return Card(
                    shadowColor: Colors.lightBlue,
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0.0)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        RestaurantDetailScreen(
                                      id: popularMeatAPIProvider
                                          .popularRestaurantResponseModel!
                                          .newArrival![index]
                                          .id!,
                                    ),
                                  ),
                                );
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // Container(
                                  //   height: 200,
                                  //   width: deviceWidth(context) * 0.9,
                                  //   child: ,
                                  // )
                                  // cachedNetworkImage(
                                  //     200, deviceWidth(context) * 0.9, imageUrl)
                                  Stack(
                                    children: [
                                      Container(
                                        height: 130,
                                        width: deviceWidth(context) * 0.40,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(0.0),
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                    popularMeatAPIProvider
                                                            .popularRestaurantResponseModel!
                                                            .restaurantBaseurl! +
                                                        popularMeatAPIProvider
                                                            .popularRestaurantResponseModel!
                                                            .newArrival![index]
                                                            .image!))),
                                      ),
                                      // Container(
                                      //   decoration: BoxDecoration(
                                      //       borderRadius: BorderRadius.only(
                                      //           topLeft: Radius.circular(14),
                                      //           topRight: Radius.circular(14)),
                                      //       image: DecorationImage(
                                      //           fit: BoxFit.fill,
                                      //           image: AssetImage(
                                      //             foodImgUrl[index],
                                      //           ))),
                                      // ),

                                      Visibility(
                                        visible: popularMeatAPIProvider
                                                    .popularRestaurantResponseModel!
                                                    .newArrival![index]
                                                    .offer !=
                                                null &&
                                            popularMeatAPIProvider
                                                    .popularRestaurantResponseModel!
                                                    .newArrival![index]
                                                    .offer !=
                                                "",
                                        child: Positioned(
                                          bottom: 0,
                                          left: 0,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(20)),
                                              color: Colors.red[800],
                                            ),
                                            child: Center(
                                                child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Text(
                                                "Upto " +
                                                    popularMeatAPIProvider
                                                        .popularRestaurantResponseModel!
                                                        .newArrival![index]
                                                        .offer
                                                        .toString() +
                                                    "% Off",
                                                style: CommonStyles
                                                    .whiteText12BoldW500(),
                                              ),
                                            )),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  /* Divider(
                                    height: 1,
                                    thickness: 0.5,
                                    color: Colors.black54,
                                    ),*/

                                  // CircleAvatar(
                                  //   backgroundImage:
                                  //       AssetImage(foodImgUrl[index]),
                                  //   radius: 40,
                                  //   backgroundColor: Colors.transparent,
                                  // )),
                                  // Padding(
                                  //   padding: const EdgeInsets.only(
                                  //       top: 4.0, right: 8.0, left: 8.0),
                                  //   child: Text(
                                  //     restaurantOfferBannerAPIProvider
                                  //         .offerBannerResponseModel!
                                  //         .offerBanner![index]
                                  //         .!,
                                  //     style: CommonStyles.black57S18(),
                                  //     textAlign: TextAlign.right,
                                  //   ),
                                  // ),

                                  // Divider(
                                  //   height: 1,
                                  //   thickness: 0.5,
                                  //   color: Colors.black54,
                                  // ),

                                  Container(
                                    width: deviceWidth(context) * 0.40,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 0,
                                              top: 10.0,
                                              bottom: 0,
                                              right: 0),
                                          child: Container(
                                            //  color: Colors.blue,
                                            child: Text(
                                              popularMeatAPIProvider
                                                  .popularRestaurantResponseModel!
                                                  .newArrival![index]
                                                  .restaurantName!
                                                  .trim(),
                                              style: CommonStyles.black57S14(),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          //  color: Colors.lightBlueAccent,
                                          width: 130,
                                          height: 30,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 0,
                                                top: 2.0,
                                                bottom: 4,
                                                right: 8.0),
                                            child: popularMeatAPIProvider
                                                        .popularRestaurantResponseModel!
                                                        .newArrival![index]
                                                        .description ==
                                                    ""
                                                ? Text(
                                                    "Description",
                                                    style: CommonStyles
                                                        .black57S14(),
                                                  )
                                                : Text(
                                                    popularMeatAPIProvider
                                                        .popularRestaurantResponseModel!
                                                        .newArrival![index]
                                                        .description!,
                                                    maxLines: 1,
                                                    overflow: TextOverflow.fade,
                                                    style:
                                                        CommonStyles.black11(),
                                                  ),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.add_road,
                                                  size: 10,
                                                ),
                                                Text(
                                                    popularMeatAPIProvider
                                                        .popularRestaurantResponseModel!
                                                        .newArrival![index]
                                                        .distance!,
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w500))
                                              ],
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Flexible(
                                              flex: 1,
                                              child: FittedBox(
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.timer,
                                                      size: 10,
                                                    ),
                                                    Text(
                                                        popularMeatAPIProvider
                                                            .popularRestaurantResponseModel!
                                                            .newArrival![index]
                                                            .durationLt!,
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500))
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.star,
                                                  color: Colors.green,
                                                  size: 10,
                                                ),
                                                Text(
                                                    popularMeatAPIProvider
                                                        .popularRestaurantResponseModel!
                                                        .newArrival![index]
                                                        .rating!,
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        color: Colors.green,
                                                        fontWeight:
                                                            FontWeight.w500))
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        );
      }
    }
  }
}

class BakeryBannerOfferView extends StatefulWidget {
  const BakeryBannerOfferView({Key? key}) : super(key: key);

  @override
  _BakeryBannerOfferViewState createState() => _BakeryBannerOfferViewState();
}

class _BakeryBannerOfferViewState extends State<BakeryBannerOfferView> {
  @override
  void initState() {
    initialize();
    super.initState();
  }

  List<Color> colorizeColors = [
    Colors.cyan,
    Colors.blue,
    Colors.cyanAccent,
    Colors.yellowAccent,
  ];

  initialize() {
    if (context
            .read<PopularBakeryAPIProvider>()
            .popularRestaurantResponseModel ==
        null) {
      context.read<PopularBakeryAPIProvider>().getPopularRestaurant(
          lat: SharedPreference.latitude.toString(),
          long: SharedPreference.longitude.toString(),
          filter: "1",
          type: "3",
          foodType: "3");
    }
  }

  Widget getSuccessAPICall(Widget widget) {
    final bakeryBannerListAPIProvider =
        Provider.of<BakeryBannerListAPIProvider>(context);
    return bakeryBannerListAPIProvider.ifLoading
        ? Utils.showLoading()
        : bakeryBannerListAPIProvider.error
            ? Utils.showErrorMessage(bakeryBannerListAPIProvider.errorMessage)
            : widget;
  }

  @override
  Widget build(BuildContext context) {
    return bannerImages();

    // Padding(
    //   padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
    //   child: InkWell(
    //     onTap: () {
    //       Navigator.of(context).push(
    //           MaterialPageRoute(builder: (context) => AllRestaurantsScreen()));
    //     },
    //     child: Container(
    //       decoration: BoxDecoration(
    //           color: Colors.white,
    //           boxShadow: [
    //             BoxShadow(
    //                 color: Colors.black45, offset: Offset(0, 0), blurRadius: 8)
    //           ],
    //           borderRadius: BorderRadius.circular(14),
    //           border: Border.all(
    //               color: Colors.brown[400]!,
    //               width: 1,
    //               style: BorderStyle.solid)),
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           Padding(
    //             padding: const EdgeInsets.only(
    //                 top: 8.0, bottom: 8, right: 8.0, left: 8.0),
    //             child: Text(
    //               "Restaurants",
    //               style: CommonStyles.black57S18(),
    //               textAlign: TextAlign.right,
    //             ),
    //           ),
    //           // Container(
    //           //   height: 200,
    //           //   width: deviceWidth(context) * 0.9,
    //           //   child: ,
    //           // )
    //           // cachedNetworkImage(
    //           //     200, deviceWidth(context) * 0.9, imageUrl)
    //           AspectRatio(
    //             aspectRatio: 4 / 2,
    //             child: Stack(
    //               children: [
    //                 bannerImages(),
    //                 // Container(
    //                 //   decoration: BoxDecoration(
    //                 //       borderRadius: BorderRadius.only(
    //                 //           topLeft: Radius.circular(14),
    //                 //           topRight: Radius.circular(14)),
    //                 //       image: DecorationImage(
    //                 //           fit: BoxFit.fill,
    //                 //           image: AssetImage(
    //                 //             foodImgUrl[index],
    //                 //           ))),
    //                 // ),

    //                 Positioned(
    //                   bottom: 20,
    //                   right: 20,
    //                   child: Padding(
    //                     padding: const EdgeInsets.all(8.0),
    //                     child: Container(
    //                       decoration: BoxDecoration(
    //                         color: Colors.red[800],
    //                       ),
    //                       child: Center(
    //                           child: Padding(
    //                         padding: const EdgeInsets.all(10.0),
    //                         child: Text(
    //                           "15% Off",
    //                           style: CommonStyles.whiteText12BoldW500(),
    //                         ),
    //                       )),
    //                     ),
    //                   ),
    //                 )
    //               ],
    //             ),
    //           ),
    //           Divider(
    //             height: 1,
    //             thickness: 0.5,
    //             color: Colors.black54,
    //           ),
    //           Row(
    //             children: [],
    //           ),
    //           // CircleAvatar(
    //           //   backgroundImage:
    //           //       AssetImage(foodImgUrl[index]),
    //           //   radius: 40,
    //           //   backgroundColor: Colors.transparent,
    //           // )),

    //           Padding(
    //             padding: const EdgeInsets.only(
    //                 left: 8, top: 2.0, bottom: 4, right: 8.0),
    //             child: Text(
    //               "Pizza, Dosa, Idli, Burger, Roll and more...",
    //               style: CommonStyles.black57S14(),
    //             ),
    //           ),
    //           Divider(
    //             height: 1,
    //             thickness: 0.5,
    //             color: Colors.black54,
    //           ),
    //           bottomSwiper(bottomSwiper: _listBottom)
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }

  Widget bannerImages() {
    final popularBakeryAPIProvider =
        Provider.of<PopularBakeryAPIProvider>(context);
    return popularBakeryAPIProvider.ifLoading
        ? Utils.showLoading()
        : popularBakeryAPIProvider.error
            ? Container(
                height: 200,
                child: Utils.showErrorMessage(
                    popularBakeryAPIProvider.errorMessage))
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: AnimatedTextKit(
                          animatedTexts: [
                            // isRepeatingAnimation: true,
                            ColorizeAnimatedText("Bakery",
                                textStyle: CommonStyles.black57S18(),
                                textAlign: TextAlign.right,
                                colors: colorizeColors)
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 4.0,
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => AllRestaurantsScreen(
                                      storeType: "3",
                                    )));
                          },

                          // child: Row(
                          //   children: [
                          //     Container(
                          //       child: Row(
                          //         children: [
                          //           AnimatedTextKit(
                          //             animatedTexts: [
                          //               ColorizeAnimatedText(
                          //                 "See all",
                          //                 textStyle: CommonStyles.black12(),
                          //                 textAlign: TextAlign.right,
                          //                 colors: colorizeColors,
                          //               ),
                          //             ],
                          //           ),
                          //           Icon(
                          //             Icons.keyboard_arrow_right_outlined,
                          //             color: Colors.white,
                          //             size: 19,
                          //           ),
                          //         ],
                          //       ),
                          //     ),
                          //   ],
                          // ),

                          child: Row(
                            children: [
                              // AnimatedTextKit(
                              //   animatedTexts: [
                              //     // isRepeatingAnimation: true,
                              //     ColorizeAnimatedText("See all",
                              //         textStyle: CommonStyles.black12(),
                              //         textAlign: TextAlign.right,
                              //         colors: colorizeColors)
                              //   ],
                              // ),
                              // Utils.getSizedBox(width: 5),
                              Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      color: Color.fromARGB(255, 0, 24, 44)),
                                  child: Icon(
                                    Icons.keyboard_arrow_right_outlined,
                                    color: Colors.white,
                                    size: 19,
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Utils.getSizedBox(height: 5),
                  SizedBox(
                    height: 230,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemCount: popularBakeryAPIProvider
                          .popularRestaurantResponseModel!.newArrival!.length,
                      clipBehavior: Clip.none,
                      itemBuilder: (context, int index) {
                        return Card(
                          shadowColor: Colors.lightBlue,
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      // Navigator.of(context).push(
                                      //     MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             AllRestaurantsScreen(
                                      //               storeType: "3",
                                      //             )));
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              RestaurantDetailScreen(
                                            id: popularBakeryAPIProvider
                                                .popularRestaurantResponseModel!
                                                .newArrival![index]
                                                .id!,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        // Container(
                                        //   height: 200,
                                        //   width: deviceWidth(context) * 0.9,
                                        //   child: ,
                                        // )
                                        // cachedNetworkImage(
                                        //     200, deviceWidth(context) * 0.9, imageUrl)
                                        Stack(
                                          children: [
                                            Container(
                                              height: 130,
                                              width:
                                                  deviceWidth(context) * 0.40,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(0),
                                                  image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: NetworkImage(popularBakeryAPIProvider
                                                              .popularRestaurantResponseModel!
                                                              .restaurantBaseurl! +
                                                          popularBakeryAPIProvider
                                                              .popularRestaurantResponseModel!
                                                              .newArrival![
                                                                  index]
                                                              .image!))),
                                            ),
                                            // Container(
                                            //   decoration: BoxDecoration(
                                            //       borderRadius: BorderRadius.only(
                                            //           topLeft: Radius.circular(14),
                                            //           topRight: Radius.circular(14)),
                                            //       image: DecorationImage(
                                            //           fit: BoxFit.fill,
                                            //           image: AssetImage(
                                            //             foodImgUrl[index],
                                            //           ))),
                                            // ),

                                            Visibility(
                                              visible: popularBakeryAPIProvider
                                                          .popularRestaurantResponseModel!
                                                          .newArrival![index]
                                                          .offer !=
                                                      null &&
                                                  popularBakeryAPIProvider
                                                          .popularRestaurantResponseModel!
                                                          .newArrival![index]
                                                          .offer !=
                                                      "",
                                              child: Positioned(
                                                bottom: 0,
                                                left: 0,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    20)),
                                                    color: Colors.red[800],
                                                  ),
                                                  child: Center(
                                                      child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    child: Text(
                                                      "Upto " +
                                                          popularBakeryAPIProvider
                                                              .popularRestaurantResponseModel!
                                                              .newArrival![
                                                                  index]
                                                              .offer
                                                              .toString() +
                                                          "% Off",
                                                      style: CommonStyles
                                                          .whiteText12BoldW500(),
                                                    ),
                                                  )),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        /* Divider(
                                    height: 1,
                                    thickness: 0.5,
                                    color: Colors.black54,
                                    ),*/

                                        // CircleAvatar(
                                        //   backgroundImage:
                                        //       AssetImage(foodImgUrl[index]),
                                        //   radius: 40,
                                        //   backgroundColor: Colors.transparent,
                                        // )),
                                        // Padding(
                                        //   padding: const EdgeInsets.only(
                                        //       top: 4.0, right: 8.0, left: 8.0),
                                        //   child: Text(
                                        //     restaurantOfferBannerAPIProvider
                                        //         .offerBannerResponseModel!
                                        //         .offerBanner![index]
                                        //         .!,
                                        //     style: CommonStyles.black57S18(),
                                        //     textAlign: TextAlign.right,
                                        //   ),
                                        // ),

                                        // Divider(
                                        //   height: 1,
                                        //   thickness: 0.5,
                                        //   color: Colors.black54,
                                        // ),

                                        Container(
                                          width: deviceWidth(context) * 0.40,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 0,
                                                    top: 10.0,
                                                    bottom: 0,
                                                    right: 0),
                                                child: Container(
                                                  //  color: Colors.blue,
                                                  child: Text(
                                                    popularBakeryAPIProvider
                                                        .popularRestaurantResponseModel!
                                                        .newArrival![index]
                                                        .restaurantName!
                                                        .trim(),
                                                    style: CommonStyles
                                                        .black57S14(),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                //  color: Colors.lightBlueAccent,
                                                width: 130,
                                                height: 30,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 0,
                                                          top: 2.0,
                                                          bottom: 4,
                                                          right: 8.0),
                                                  child: popularBakeryAPIProvider
                                                              .popularRestaurantResponseModel!
                                                              .newArrival![
                                                                  index]
                                                              .description ==
                                                          ""
                                                      ? Text(
                                                          "Description",
                                                          style: CommonStyles
                                                              .black57S14(),
                                                        )
                                                      : Text(
                                                          popularBakeryAPIProvider
                                                              .popularRestaurantResponseModel!
                                                              .newArrival![
                                                                  index]
                                                              .description!,
                                                          maxLines: 1,
                                                          overflow:
                                                              TextOverflow.fade,
                                                          style: CommonStyles
                                                              .black11(),
                                                        ),
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.add_road,
                                                        size: 10,
                                                      ),
                                                      Text(
                                                          popularBakeryAPIProvider
                                                              .popularRestaurantResponseModel!
                                                              .newArrival![
                                                                  index]
                                                              .distance!,
                                                          style: TextStyle(
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500))
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Flexible(
                                                    flex: 1,
                                                    child: FittedBox(
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                            Icons.timer,
                                                            size: 10,
                                                          ),
                                                          Text(
                                                              popularBakeryAPIProvider
                                                                  .popularRestaurantResponseModel!
                                                                  .newArrival![
                                                                      index]
                                                                  .durationLt!,
                                                              style: TextStyle(
                                                                  fontSize: 10,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500))
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.star,
                                                        color: Colors.green,
                                                        size: 10,
                                                      ),
                                                      Text(
                                                          popularBakeryAPIProvider
                                                              .popularRestaurantResponseModel!
                                                              .newArrival![
                                                                  index]
                                                              .rating!,
                                                          style: TextStyle(
                                                              fontSize: 10,
                                                              color:
                                                                  Colors.green,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500))
                                                    ],
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
  }
}

class FoodCourtOfferView extends StatefulWidget {
  const FoodCourtOfferView({Key? key}) : super(key: key);

  @override
  _FoodCourtOfferViewState createState() => _FoodCourtOfferViewState();
}

class _FoodCourtOfferViewState extends State<FoodCourtOfferView> {
  @override
  void initState() {
    initialize();
    super.initState();
  }

  List<Color> colorizeColors = [
    Colors.purple,
    Colors.blue,
    Colors.yellow,
    Colors.red,
  ];

  initialize() {
    if (context.read<FoodCourtAPIProvider>().foodCourtResponseModel == null) {
      context.read<FoodCourtAPIProvider>().getPopularFoodCourt(
          lat: SharedPreference.latitude.toString(),
          long: SharedPreference.longitude.toString(),
          filter: "1",
          type: "4",
          foodType: "3");
    }
  }

  Widget getSuccessAPICall(Widget widget) {
    final bakeryBannerListAPIProvider =
        Provider.of<BakeryBannerListAPIProvider>(context);
    return bakeryBannerListAPIProvider.ifLoading
        ? Utils.showLoading()
        : bakeryBannerListAPIProvider.error
            ? Utils.showErrorMessage(bakeryBannerListAPIProvider.errorMessage)
            : widget;
  }

  @override
  Widget build(BuildContext context) {
    return bannerImages();

    // Padding(
    //   padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
    //   child: InkWell(
    //     onTap: () {
    //       Navigator.of(context).push(
    //           MaterialPageRoute(builder: (context) => AllRestaurantsScreen()));
    //     },
    //     child: Container(
    //       decoration: BoxDecoration(
    //           color: Colors.white,
    //           boxShadow: [
    //             BoxShadow(
    //                 color: Colors.black45, offset: Offset(0, 0), blurRadius: 8)
    //           ],
    //           borderRadius: BorderRadius.circular(14),
    //           border: Border.all(
    //               color: Colors.brown[400]!,
    //               width: 1,
    //               style: BorderStyle.solid)),
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           Padding(
    //             padding: const EdgeInsets.only(
    //                 top: 8.0, bottom: 8, right: 8.0, left: 8.0),
    //             child: Text(
    //               "Restaurants",
    //               style: CommonStyles.black57S18(),
    //               textAlign: TextAlign.right,
    //             ),
    //           ),
    //           // Container(
    //           //   height: 200,
    //           //   width: deviceWidth(context) * 0.9,
    //           //   child: ,
    //           // )
    //           // cachedNetworkImage(
    //           //     200, deviceWidth(context) * 0.9, imageUrl)
    //           AspectRatio(
    //             aspectRatio: 4 / 2,
    //             child: Stack(
    //               children: [
    //                 bannerImages(),
    //                 // Container(
    //                 //   decoration: BoxDecoration(
    //                 //       borderRadius: BorderRadius.only(
    //                 //           topLeft: Radius.circular(14),
    //                 //           topRight: Radius.circular(14)),
    //                 //       image: DecorationImage(
    //                 //           fit: BoxFit.fill,
    //                 //           image: AssetImage(
    //                 //             foodImgUrl[index],
    //                 //           ))),
    //                 // ),

    //                 Positioned(
    //                   bottom: 20,
    //                   right: 20,
    //                   child: Padding(
    //                     padding: const EdgeInsets.all(8.0),
    //                     child: Container(
    //                       decoration: BoxDecoration(
    //                         color: Colors.red[800],
    //                       ),
    //                       child: Center(
    //                           child: Padding(
    //                         padding: const EdgeInsets.all(10.0),
    //                         child: Text(
    //                           "15% Off",
    //                           style: CommonStyles.whiteText12BoldW500(),
    //                         ),
    //                       )),
    //                     ),
    //                   ),
    //                 )
    //               ],
    //             ),
    //           ),
    //           Divider(
    //             height: 1,
    //             thickness: 0.5,
    //             color: Colors.black54,
    //           ),
    //           Row(
    //             children: [],
    //           ),
    //           // CircleAvatar(
    //           //   backgroundImage:
    //           //       AssetImage(foodImgUrl[index]),
    //           //   radius: 40,
    //           //   backgroundColor: Colors.transparent,
    //           // )),

    //           Padding(
    //             padding: const EdgeInsets.only(
    //                 left: 8, top: 2.0, bottom: 4, right: 8.0),
    //             child: Text(
    //               "Pizza, Dosa, Idli, Burger, Roll and more...",
    //               style: CommonStyles.black57S14(),
    //             ),
    //           ),
    //           Divider(
    //             height: 1,
    //             thickness: 0.5,
    //             color: Colors.black54,
    //           ),
    //           bottomSwiper(bottomSwiper: _listBottom)
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }

  Widget bannerImages() {
    final popularBakeryAPIProvider = Provider.of<FoodCourtAPIProvider>(context);
    return popularBakeryAPIProvider.ifLoading
        ? Utils.showLoading()
        : popularBakeryAPIProvider.error
            ? Container(
                height: 200,
                child: Utils.showErrorMessage(
                    popularBakeryAPIProvider.errorMessage))
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: AnimatedTextKit(
                          animatedTexts: [
                            // isRepeatingAnimation: true,
                            ColorizeAnimatedText("Food Courts",
                                textStyle: CommonStyles.black57S18(),
                                textAlign: TextAlign.right,
                                colors: colorizeColors)
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 4.0,
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => AllRestaurantsScreen(
                                      storeType: "3",
                                    )));
                          },
                          child: Row(
                            children: [
                              AnimatedTextKit(
                                animatedTexts: [
                                  // isRepeatingAnimation: true,
                                  ColorizeAnimatedText("See all",
                                      textStyle: CommonStyles.black12(),
                                      textAlign: TextAlign.right,
                                      colors: colorizeColors)
                                ],
                              ),
                              Utils.getSizedBox(width: 5),
                              Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color.fromARGB(255, 0, 24, 44)),
                                  child: Icon(
                                    Icons.keyboard_arrow_right_outlined,
                                    color: Colors.white,
                                    size: 19,
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Utils.getSizedBox(height: 5),
                  SizedBox(
                    height: 230,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemCount: popularBakeryAPIProvider
                          .foodCourtResponseModel!.newArrival!.length,
                      clipBehavior: Clip.none,
                      itemBuilder: (context, int index) {
                        return Card(
                          shadowColor: Colors.lightBlue,
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      // Navigator.of(context).push(
                                      //     MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             AllRestaurantsScreen(
                                      //               storeType: "3",
                                      //             )));

                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AllFoodCourtsScreen(
                                                    mallId: popularBakeryAPIProvider
                                                        .foodCourtResponseModel!
                                                        .newArrival![index]
                                                        .mallDetails!
                                                        .id!,
                                                  )));
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //     builder: (context) =>
                                      //         RestaurantDetailScreen(
                                      //       id: popularBakeryAPIProvider
                                      //           .foodCourtResponseModel!
                                      //           .newArrival![index]
                                      //           .id!,
                                      //     ),
                                      //   ),
                                      // );
                                    },
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        // Container(
                                        //   height: 200,
                                        //   width: deviceWidth(context) * 0.9,
                                        //   child: ,
                                        // )
                                        // cachedNetworkImage(
                                        //     200, deviceWidth(context) * 0.9, imageUrl)
                                        Stack(
                                          children: [
                                            Container(
                                              height: 130,
                                              width:
                                                  deviceWidth(context) * 0.40,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: NetworkImage(popularBakeryAPIProvider
                                                              .foodCourtResponseModel!
                                                              .restaurantBaseurl! +
                                                          popularBakeryAPIProvider
                                                              .foodCourtResponseModel!
                                                              .newArrival![
                                                                  index]
                                                              .image!))),
                                            ),
                                            // Container(
                                            //   decoration: BoxDecoration(
                                            //       borderRadius: BorderRadius.only(
                                            //           topLeft: Radius.circular(14),
                                            //           topRight: Radius.circular(14)),
                                            //       image: DecorationImage(
                                            //           fit: BoxFit.fill,
                                            //           image: AssetImage(
                                            //             foodImgUrl[index],
                                            //           ))),
                                            // ),

                                            Visibility(
                                              visible: popularBakeryAPIProvider
                                                          .foodCourtResponseModel!
                                                          .newArrival![index]
                                                          .offer !=
                                                      null &&
                                                  popularBakeryAPIProvider
                                                          .foodCourtResponseModel!
                                                          .newArrival![index]
                                                          .offer !=
                                                      "",
                                              child: Positioned(
                                                bottom: 0,
                                                left: 0,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    20)),
                                                    color: Colors.red[800],
                                                  ),
                                                  child: Center(
                                                      child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    child: Text(
                                                      "Upto " +
                                                          popularBakeryAPIProvider
                                                              .foodCourtResponseModel!
                                                              .newArrival![
                                                                  index]
                                                              .offer
                                                              .toString() +
                                                          "% Off",
                                                      style: CommonStyles
                                                          .whiteText12BoldW500(),
                                                    ),
                                                  )),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        /* Divider(
                                    height: 1,
                                    thickness: 0.5,
                                    color: Colors.black54,
                                    ),*/

                                        // CircleAvatar(
                                        //   backgroundImage:
                                        //       AssetImage(foodImgUrl[index]),
                                        //   radius: 40,
                                        //   backgroundColor: Colors.transparent,
                                        // )),
                                        // Padding(
                                        //   padding: const EdgeInsets.only(
                                        //       top: 4.0, right: 8.0, left: 8.0),
                                        //   child: Text(
                                        //     restaurantOfferBannerAPIProvider
                                        //         .offerBannerResponseModel!
                                        //         .offerBanner![index]
                                        //         .!,
                                        //     style: CommonStyles.black57S18(),
                                        //     textAlign: TextAlign.right,
                                        //   ),
                                        // ),

                                        // Divider(
                                        //   height: 1,
                                        //   thickness: 0.5,
                                        //   color: Colors.black54,
                                        // ),

                                        Container(
                                          width: deviceWidth(context) * 0.40,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 0,
                                                    top: 10.0,
                                                    bottom: 0,
                                                    right: 0),
                                                child: Container(
                                                  //  color: Colors.blue,
                                                  child: Text(
                                                    popularBakeryAPIProvider
                                                        .foodCourtResponseModel!
                                                        .newArrival![index]
                                                        .restaurantName!
                                                        .trim(),
                                                    style: CommonStyles
                                                        .black57S14(),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                //  color: Colors.lightBlueAccent,
                                                width: 130,
                                                height: 30,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 0,
                                                          top: 2.0,
                                                          bottom: 4,
                                                          right: 8.0),
                                                  child: popularBakeryAPIProvider
                                                              .foodCourtResponseModel!
                                                              .newArrival![
                                                                  index]
                                                              .description ==
                                                          ""
                                                      ? Text(
                                                          "Description",
                                                          style: CommonStyles
                                                              .black57S14(),
                                                        )
                                                      : Text(
                                                          popularBakeryAPIProvider
                                                              .foodCourtResponseModel!
                                                              .newArrival![
                                                                  index]
                                                              .description!,
                                                          maxLines: 1,
                                                          overflow:
                                                              TextOverflow.fade,
                                                          style: CommonStyles
                                                              .black11(),
                                                        ),
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.add_road,
                                                        size: 10,
                                                      ),
                                                      Text(
                                                          popularBakeryAPIProvider
                                                              .foodCourtResponseModel!
                                                              .newArrival![
                                                                  index]
                                                              .distance!,
                                                          style: TextStyle(
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500))
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Flexible(
                                                    flex: 1,
                                                    child: FittedBox(
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                            Icons.timer,
                                                            size: 10,
                                                          ),
                                                          Text(
                                                              popularBakeryAPIProvider
                                                                  .foodCourtResponseModel!
                                                                  .newArrival![
                                                                      index]
                                                                  .durationLt!,
                                                              style: TextStyle(
                                                                  fontSize: 10,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500))
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.star,
                                                        color: Colors.green,
                                                        size: 10,
                                                      ),
                                                      Text(
                                                          popularBakeryAPIProvider
                                                              .foodCourtResponseModel!
                                                              .newArrival![
                                                                  index]
                                                              .rating!,
                                                          style: TextStyle(
                                                              fontSize: 10,
                                                              color:
                                                                  Colors.green,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500))
                                                    ],
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
  }
}
