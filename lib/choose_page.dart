import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:mycityapp/Cab/pages/home/home.dart';
import 'package:mycityapp/Food/login.dart';
import 'package:mycityapp/HotelBooking/pages/home_page.dart';
import 'package:mycityapp/RealEstate/pages/home_page.dart';
import 'package:mycityapp/common/common_styles.dart';

class ChooseScreen extends StatefulWidget {
  const ChooseScreen({Key? key}) : super(key: key);

  @override
  State<ChooseScreen> createState() => _ChooseScreenState();
}

class _ChooseScreenState extends State<ChooseScreen> {
  List<String> screenChoices = [
    "assets/image/b3.jpg",
    "assets/image/b1.jpg",
    "assets/image/b2.jpg",
    "assets/image/b4.jpg",
  ];

  List<String> screenChoice = [
    "Food and Grocery",
    "Hotel Booking",
    "Cab Booking",
    "Real Estate"
  ];

  List<String> bannerList = [
    "assets/image/b1.jpg",
    "assets/image/b2.jpg",
    "assets/image/b3.jpg",
    "assets/image/b4.jpg",
  ];

  List<Color> coloriColors = [
    Colors.brown,
    Colors.yellowAccent,
    Colors.tealAccent,
    Colors.black,
  ];

  final controller = CarouselController();
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("MY CITY", style: TextStyle(fontSize: 14)),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Colors.purple,
              Colors.purple.shade500,
              Colors.purple.shade800,
            ])),
          ),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CarouselSlider.builder(
                  carouselController: controller,
                  itemCount: bannerList.length,
                  itemBuilder: (context, index, realIndex) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 1),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        gradient: LinearGradient(
                          colors: [
                            Colors.white,
                            Colors.blue.shade100,
                            Colors.white,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.centerRight,
                        ),
                        // shape: BoxShape.circle,
                      ),
                      /*  child: CachedNetworkImage(
                                  imageUrl:
                                      "${banner_list_api.banner_list!.bannerUrl}/${banner_list_api.banner_list!.bannerList![index].bannerImage}",
                                  fit: BoxFit.contain,
                                ),*/
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          bannerList[index],
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                  options: CarouselOptions(
                    height: 190,
                    autoPlay: true,
                    pageSnapping: true,
                    autoPlayCurve: Curves.easeInOut,
                    // enableInfiniteScroll: false,
                    //  enlargeStrategy: CenterPageEnlargeStrategy.height,
                    //   viewportFraction: 1,
                    enlargeCenterPage: true,
                    //    initialPage: 0,
                    // aspectRatio: 16/9,
                    autoPlayInterval: const Duration(seconds: 2),
                    onPageChanged: (index, reason) =>
                        setState(() => activeIndex = index),
                  )),

              /*BannerListProviderApi.ifLoading
                          ? Center(
                            child: CircularProgressIndicator(),
                          )
                          : */
              AnimatedSmoothIndicator(
                activeIndex: activeIndex,
                count: 5,
                effect: const ScrollingDotsEffect(
                  dotWidth: 5,
                  dotHeight: 5,
                  activeDotColor: Colors.pink,
                  dotColor: Colors.grey,
                ),
                onDotClicked: animateToSlide,
              ),
              SizedBox(
                height: 3,
              ),
              // Container(
              //   color: Colors.purple.shade50,
              //   height: 45,
              //   child: ListView(
              //     children: [
              //       Container(
              //         child: Row(
              //           children: [
              //             Padding(
              //               padding: const EdgeInsets.only(top: 6, left: 4),
              //               child: Container(
              //                 color: Colors.white,
              //                 height: 30,
              //                 width: 40,
              //                 child: Text(
              //                   " car\nservices",
              //                   style: TextStyle(fontSize: 9),
              //                 ),
              //               ),
              //             )
              //           ],
              //         ),
              //       )
              //     ],
              //   ),
              // ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(right: 120),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      // isRepeatingAnimation: true,
                      ColorizeAnimatedText("Our Services are:",
                          textStyle: CommonStyles.black57S18(),
                          textAlign: TextAlign.right,
                          colors: coloriColors),
                    ],
                  ),
                ),
              ),
              GridView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.all(15),
                primary: false,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 30,
                    crossAxisCount: 2,
                    mainAxisSpacing: 30,
                    mainAxisExtent: 150),
                itemCount: bannerList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        image: DecorationImage(
                            image: AssetImage("${screenChoices[index]}"),
                            fit: BoxFit.cover),
                        //  borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.lightBlueAccent,
                            spreadRadius: 1,
                            blurRadius: 0,
                            offset: Offset(1, 1),
                          ),
                          // BoxShadow(
                          //   color: Colors.lightBlueAccent,
                          //   spreadRadius: 0,
                          //   blurRadius: 0,
                          //   offset: Offset(0, 0),
                          // )
                        ]),
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: InkWell(
                          onTap: () {
                            if (index == 0) {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => LocationInitialize()));
                            }
                            if (index == 1) {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => HomePage()));
                            }
                            if (index == 2) {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => MainHomePage()));
                            }
                            if (index == 3) {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => RealEstateHomePage()));
                            }
                          },
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                    height: 20,
                                    child: Text(
                                      "${screenChoice[index]}",
                                      style: CommonStyles.black13(),
                                    )),
                                SizedBox(
                                  height: 10,
                                ),
                              ]),
                        )),
                  );
                },
              )
            ],
          ),
        ),
        drawer: Drawer(
          elevation: 0,
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.symmetric(vertical: 30),
            children: [
              DrawerHeader(
                decoration:
                    BoxDecoration(color: Colors.purple, shape: BoxShape.circle),
                child: Center(
                    child: Image.asset(
                  "assets/mycitylogo.png",
                  height: 80,
                  width: 80,
                )),
              ),
              SizedBox(
                height: 10,
              ),
              ListTile(
                title: const Text('Item 1'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                title: const Text('Item 2'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
            ],
          ),
        ));
  }

  animateToSlide(int index) {}
}
