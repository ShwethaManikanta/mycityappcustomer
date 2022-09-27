import 'package:flutter/material.dart';
import 'package:mycityapp/Food/CommonWidgets/common_styles.dart';
import 'package:mycityapp/Food/CommonWidgets/screen_width_and_height.dart';
import 'package:mycityapp/Food/CommonWidgets/utils.dart';
import 'package:mycityapp/Food/pages/utils/loaction_shared_preference.dart';
import 'package:mycityapp/choose_page.dart';

import 'homePage/Home.dart';

class GetLocation extends StatefulWidget {
  const GetLocation({Key? key}) : super(key: key);

  @override
  _GetLocationState createState() => _GetLocationState();
}

class _GetLocationState extends State<GetLocation> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage('assets/images/ctblocat.png'),
                fit: BoxFit.contain,
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            right: 5,
            left: 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.bottomCenter,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.green),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          InkWell(
                              onTap: () async {
                                Utils.showLoaderDialog(context);
                                await SharedPreference.setValues();
                                Navigator.of(context).pop();
                                Navigator.pushReplacementNamed(context, "Home");
                              },
                              child: Text("CONFIRM YOUR LOCATION",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15))),
                        ],
                      ),
                    ),
                  ),
                ),
                // UIHelper.verticalSpaceMedium(),
                // Padding(
                //   padding: const EdgeInsets.all(15.0),
                //   child: Container(
                //     width: MediaQuery.of(context).size.width,
                //     alignment: Alignment.bottomCenter,
                //     decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0), color: Colors.redAccent),
                //     child: Padding(
                //       padding: const EdgeInsets.all(8.0),
                //       child: Column(
                //         children: [
                //           InkWell(
                //               onTap: () {
                //                 Navigator.push(
                //                   context,
                //                   MaterialPageRoute(builder: (context) => MapSample()),
                //                 );
                //               },
                //               child: Text("CHANGE MY LOCATION",
                //                   style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15))),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashPage>
    with TickerProviderStateMixin {
  bool isLeftCollapsed = true;
  bool isRightCollapsed = true;
  bool isTopCollapsed = true;
  bool isBottomCollapsed = true;
  late double screenWidth, screenHeight;
  final Duration duration = const Duration(seconds: 2);
  late AnimationController _controller;
  late AnimationController _controller1;

  late AnimationController _controller2;

  late Animation<double> offset;
  late Animation<double> offset1;
  late Animation<double> offset2;

  bool _changeColor = false;
  bool _showLoading = false;
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: duration);
    offset = Tween<double>(begin: 0.0, end: 0.19)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
    _controller1 = AnimationController(vsync: this, duration: duration);
    offset1 = Tween<double>(begin: 0.0, end: 0.31)
        .animate(CurvedAnimation(parent: _controller1, curve: Curves.ease));

    _controller2 = AnimationController(vsync: this, duration: duration);
    offset2 = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _controller2, curve: Curves.decelerate));
    _controller.addListener(() {
      print("hello");
    });

    offset1 = Tween<double>(begin: 0.0, end: 0.31).animate(
        CurvedAnimation(parent: _controller1, curve: Curves.decelerate));
    _controller.addListener(() {
      print("hello");
    });
    _controller1.addListener(() {
      setState(() {
        _changeColor = true;
      });
    });
    _controller.forward();
    _controller1.forward();
    showLoading();
  }

  bool _showAddressText = false;
  showLoading() async {
    _controller2.forward();
    await Future.delayed(Duration(milliseconds: 300));
    setState(() {
      _showLoading = true;
    });
    await SharedPreference.setValues().whenComplete(() {
      setState(() {
        _showLoading = false;
        _showAddressText = true;
      });
    });
    await Future.delayed(Duration(milliseconds: 200));
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => ChooseScreen()));
    // });
    // .whenComplete(() async {
    //   // Utils.showLoaderDialog(context);
    //   // setState(() {
    //   //   _showLoading = true;
    //   // });
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller1.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = deviceHeight(context);
    screenWidth = deviceWidth(context);
    return Scaffold(
      body: AnimatedContainer(
        duration: Duration(seconds: 2),
        decoration: BoxDecoration(
          gradient: _changeColor
              ? RadialGradient(colors: [
                  Colors.lightBlue.withOpacity(offset.value + 0.3),
                  // Colors.red.withOpacity(offset.value + 0.3)
                  Color(0xffffc41f5).withOpacity(offset.value + 0.3),
                ])
              : RadialGradient(colors: [
                  Colors.lightBlue.withOpacity(0.5),
                  // Colors.red.withOpacity(0.5)
                  Color(0xffffc41f5).withOpacity(0.3),
                ]),
        ),
        child: Stack(
          children: [
            Positioned(
              top: deviceHeight(context) * offset.value,
              right: deviceWidth(context) * 0.3,
              left: deviceWidth(context) * 0.3,
              // bottom: 0,
              child: Container(
                  height: 200,
                  width: 200,
                  decoration: new BoxDecoration(
                    image: new DecorationImage(
                      scale: 0.1,
                      image: new AssetImage(
                        'assets/icons/c1logo.png',
                      ),
                      fit: BoxFit.contain,
                    ),
                  )),
            ),
            Positioned(
              bottom: deviceHeight(context) * offset1.value,
              right: deviceWidth(context) * 0.3,
              left: deviceWidth(context) * 0.3,
              // bottom: 40,
              child: Container(
                  height: 200,
                  width: 200,
                  decoration: new BoxDecoration(
                    image: new DecorationImage(
                      scale: 0.5,
                      image: new AssetImage(
                        'assets/icons/c2logo.png',
                      ),
                      fit: BoxFit.contain,
                    ),
                  )),
            ),
            if (_showLoading)
              Positioned(
                bottom: deviceHeight(context) * 0.17,
                right: 0,
                left: 0,
                child: Center(
                  child: Opacity(
                      opacity: offset2.value,
                      child: Utils.showLoadingWithColor(Colors.black54)
                      //  Text(
                      //   "Close To Buy",
                      //   style: CommonStyles.black57S18(),
                      // ),
                      ),
                ),
              ),
            if (_showAddressText)
              Positioned(
                bottom: deviceHeight(context) * 0.17,
                right: 0,
                left: 0,
                child: Center(
                  child: SizedBox(
                    height: 100,
                    width: deviceWidth(context) * 0.7,
                    child: Text(
                      SharedPreference.currentAddress,
                      style: CommonStyles.black12thin(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),

            // Positioned(
            //   top: 200,
            //   width: 10,
            //   child: AnimatedPositioned(
            //     left: isLeftCollapsed ? 0 : 0.5 * screenWidth,
            //     right: isRightCollapsed ? 0 : -0.2 * screenWidth,
            //     top: isTopCollapsed ? 0 : 0.1 * screenHeight,
            //     bottom: isBottomCollapsed ? 0 : 0.1 * screenHeight,
            //     duration: duration,
            //     child: Container(
            //       height: 100,
            //       width: 100,
            //       decoration: new BoxDecoration(
            //         image: new DecorationImage(
            //           scale: 0.5,
            //           image: new AssetImage(
            //             'assets/icons/c1 logo.png',
            //           ),
            //           fit: BoxFit.contain,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),

            // AnimatedContainer(
            //   duration: duration,
            //   height: 100,
            //   width: 100,
            //   decoration: new BoxDecoration(
            //     image: new DecorationImage(
            //       scale: 0.5,
            //       image: new AssetImage(
            //         'assets/icons/c1 logo.png',
            //       ),
            //       fit: BoxFit.contain,
            //     ),
            //   ),
            // ),
            // Container(
            //   decoration: new BoxDecoration(
            //     image: new DecorationImage(
            //       image: new AssetImage('assets/images/ctblocat.png'),
            //       fit: BoxFit.contain,
            //     ),
            //   ),
            // ),
            // Positioned(
            //   bottom: 10,
            //   right: 5,
            //   left: 5,
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     children: [
            //       Padding(
            //         padding: const EdgeInsets.all(15.0),
            //         child: Container(
            //           width: MediaQuery.of(context).size.width,
            //           alignment: Alignment.bottomCenter,
            //           decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(5.0),
            //               color: Colors.green),
            //           child: Padding(
            //             padding: const EdgeInsets.all(8.0),
            //             child: Column(
            //               children: [
            //                 InkWell(
            //                     onTap: () async {
            //                       Utils.showLoaderDialog(context);
            //                       await SharedPreference.setValues();
            //                       Navigator.of(context).pop();
            //                       Navigator.pushReplacementNamed(context, "Home");
            //                     },
            //                     child: Text("CONFIRM YOUR LOCATION",
            //                         style: TextStyle(
            //                             color: Colors.white,
            //                             fontWeight: FontWeight.bold,
            //                             fontSize: 15))),
            //               ],
            //             ),
            //           ),
            //         ),
            //       ),
            //       // UIHelper.verticalSpaceMedium(),
            //       // Padding(
            //       //   padding: const EdgeInsets.all(15.0),
            //       //   child: Container(
            //       //     width: MediaQuery.of(context).size.width,
            //       //     alignment: Alignment.bottomCenter,
            //       //     decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0), color: Colors.redAccent),
            //       //     child: Padding(
            //       //       padding: const EdgeInsets.all(8.0),
            //       //       child: Column(
            //       //         children: [
            //       //           InkWell(
            //       //               onTap: () {
            //       //                 Navigator.push(
            //       //                   context,
            //       //                   MaterialPageRoute(builder: (context) => MapSample()),
            //       //                 );
            //       //               },
            //       //               child: Text("CHANGE MY LOCATION",
            //       //                   style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15))),
            //       //         ],
            //       //       ),
            //       //     ),
            //       //   ),
            //       // ),
            //     ],
            //   ),
            // )
          ],
        ),
      ),
    );
  }

  // getAddress() {
  //   final verifyLoggedInUserProvider =
  //       Provider.of<VerifyUserLoginAPIProvider>(context);
  //   // String selectedAddress =
  //   verifyLoggedInUserProvider.loginResponse!.driverDetails!.selectedAddress !=
  //       null;
  //   if (verifyLoggedInUserProvider
  //               .loginResponse!.driverDetails!.selectedAddress !=
  //           null &&
  //       verifyLoggedInUserProvider
  //               .loginResponse!.driverDetails!.selectedAddress !=
  //           "" &&
  //       verifyLoggedInUserProvider
  //               .loginResponse!.driverDetails!.selectedAddress !=
  //           "0") {
  //             verifyLoggedInUserProvider.loginResponse!.

  //           }
  // }
}
