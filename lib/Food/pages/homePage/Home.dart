import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:mycityapp/Cab/Services/api_services.dart';
import 'package:mycityapp/Food/Services/ApiServices.dart';
import 'package:mycityapp/Food/Services/location_services.dart/loaction_shared_preference.dart';
import 'package:mycityapp/Food/pages/accountScreen/AccountScreen.dart';
import 'package:mycityapp/Food/pages/cart/modelcartscreen.dart';
import '../../CommonWidgets/common_styles.dart';
import '../closeToBuyScreen/close_to_buy_screen.dart';
import '../SearchScreen.dart';
import 'package:titled_navigation_bar/titled_navigation_bar.dart';

class HomeBottomNavigationScreen extends StatefulWidget {
  final int pageIndex;

  const HomeBottomNavigationScreen({Key? key, this.pageIndex = 0})
      : super(key: key);

  @override
  _HomeBottomNavigationScreenState createState() =>
      _HomeBottomNavigationScreenState();
}

class _HomeBottomNavigationScreenState
    extends State<HomeBottomNavigationScreen> {
  final List<Widget> _children = [
    CloseToBuyScreen(),
    SearchScreen(),
    // ValidateSuccessTransactionDetails(),
    ModelCartScreen(''),
    // AccountScreen(),
  ];

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  int selectedIndex = 0;
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  buildBottomNavigationBar() {
    return TitledBottomNavigationBar(
        activeColor: Colors.blue[900],
        inactiveColor: Colors.black54,
        height: 45,
        enableShadow: true,
        reverse: false,
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: [
          // TitledNavigationBarItem(
          //   title: Text(
          //     'Home'.toUpperCase(),
          //     style: CommonStyles.black13Thin(),
          //   ),
          //   icon: Image.asset("assets/images/homeLogo.png", height: 15),
          // ),
          TitledNavigationBarItem(
            title: Text(
              'Home'.toUpperCase(),
              style: CommonStyles.black13Thin(),
            ),
            icon: const Icon(Icons.home),
          ),
          TitledNavigationBarItem(
            title: Text(
              'Search'.toUpperCase(),
              style: CommonStyles.black13Thin(),
            ),
            icon: const Icon(Icons.search),
          ),
          TitledNavigationBarItem(
            title: Text(
              'Cart'.toUpperCase(),
              style: CommonStyles.black13Thin(),
            ),
            icon: const Icon(Icons.shopping_cart_outlined),
          ),
          /* TitledNavigationBarItem(
            title: Text(
              'Account'.toUpperCase(),
              style: CommonStyles.black13Thin(),
            ),
            icon: const Icon(Icons.account_circle),
          ),*/
        ]);
  }

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.pageIndex;

    // apiServices.ongoingOrderApi().then((value) {
    //   value.ongoingOrderList.isNotEmpty ? WidgetsBinding.instance.addPostFrameCallback((_) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //     duration: Duration(hours: 2),
    //     content: ListView.builder(
    //       shrinkWrap: true,
    //       physics: ScrollPhysics(),
    //       scrollDirection: Axis.horizontal,
    //
    //       itemCount: 2,
    //         itemBuilder: (context,index){
    //       return Text("Helloe +${index}");
    //     }),
    //   ))) : Container();
    // });
    print("latitudeSharedPreference + ${SharedPreference.latitudeValue}");
    FirebaseMessaging.instance.getInitialMessage();
    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        print("Notification message title +${message.notification!.title}");
        print("Notification message body +${message.notification!.body}");
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      final routeName = message.data["route"];
      print(routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    final labelTextStyle =
        Theme.of(context).textTheme.subtitle2!.copyWith(fontSize: 8.0);
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      body: _children[selectedIndex],
      // bottomSheet: BottomCartSheetOnGoingOrder(),
      /*  floatingActionButton: Container(
        height: 50,
        child: FloatingActionButton(
          child: Image.asset(
            "assets/images/homeLogo.png",
            height: 30,
          ),
          onPressed: () {},
        ),
      ),*/
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: CustomAnimatedBottomBar(
          /*  child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: darkOrange,
            unselectedItemColor: Colors.grey,
            currentIndex: selectedIndex,
            selectedLabelStyle: labelTextStyle,
            unselectedLabelStyle: labelTextStyle,
            onTap: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'FOODIE',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.takeout_dining),
                label: 'Meat',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'SEARCH',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add_shopping_cart),
                label: 'CART',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                label: 'ACCOUNT',
              ),
            ],
        ),*/
          containerHeight: 45,
          selectedIndex: selectedIndex,
          showElevation: true,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          itemCornerRadius: 12,
          bottomMargin: 3,
          iconSize: 18,
          curve: Curves.easeIn,
          onItemSelected: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          items: <BottomNavyBarItem>[
            //BottomNavyBarItem custom model.
            // BottomNavyBarItem(
            //   icon: Image.asset("assets/images/homeLogo.png", height: 15),
            //   title: Center(child: Text("Home", style: CommonStyles.black12())),
            //   activeColor: Colors.brown[800],
            //   inactiveColor: Colors.brown[800],
            //   textAlign: TextAlign.center,
            // ),
            BottomNavyBarItem(
              icon: const Icon(Icons.home),
              title: Center(
                  child: Text(
                '  Home',
                style: CommonStyles.black12(),
              )),
              activeColor: Colors.brown[800],
              inactiveColor: Colors.brown[800],
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: const Icon(Icons.search),
              title: Center(
                  child: Text(
                '  Search',
                style: CommonStyles.black12(),
              )),
              activeColor: Colors.brown[800],
              inactiveColor: Colors.brown[800],
              textAlign: TextAlign.center,
            ),
            /*   BottomNavyBarItem(
              icon: const Icon(Icons.no_meals_sharp),
              title: const Text('Meat'),
              activeColor: Colors.brown[800],
              inactiveColor: Colors.brown[800],
              textAlign: TextAlign.center,
            ),*/

            BottomNavyBarItem(
              icon: const Icon(Icons.shopping_cart_outlined),
              title: Center(
                  child: Text(
                'Cart',
                style: CommonStyles.black12(),
              )),
              activeColor: Colors.brown[800],
              inactiveColor: Colors.brown[800],
              textAlign: TextAlign.center,
            ),
            /*BottomNavyBarItem(
              icon: const Icon(Icons.account_circle),
              title: Text(
                'Account',
                style: CommonStyles.black12(),
              ),
              activeColor: Colors.brown[800],
              inactiveColor: Colors.brown[800],
              textAlign: TextAlign.center,
            ),*/
          ],
        ),
      ),
    );
  }
}

class BottomNavyBarItem {
  BottomNavyBarItem({
    this.icon,
    this.title,
    this.activeColor = Colors.yellow,
    this.textAlign,
    this.inactiveColor,
  });

  final Widget? icon;
  final Widget? title;
  final Color? activeColor;
  final Color? inactiveColor;
  final TextAlign? textAlign;
}

class CustomAnimatedBottomBar extends StatelessWidget {
  const CustomAnimatedBottomBar({
    Key? key,
    this.selectedIndex = 0,
    this.showElevation = true,
    this.iconSize = 24,
    this.itemCornerRadius = 50,
    this.bottomMargin = 0,
    this.containerHeight = 56,
    this.animationDuration = const Duration(milliseconds: 270),
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
    required this.items,
    this.onItemSelected,
    this.curve = Curves.linear,
  })  : assert(items.length >= 2 && items.length <= 5),
        super(key: key);

  final int selectedIndex;
  final double iconSize;
  final bool showElevation;
  final Duration animationDuration;
  final List<BottomNavyBarItem> items;
  final ValueChanged<int>? onItemSelected;
  final MainAxisAlignment mainAxisAlignment;
  final double itemCornerRadius;
  final double containerHeight;
  final Curve curve;
  final double bottomMargin;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(bottom: bottomMargin),
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      padding: const EdgeInsets.only(top: 3),
      child: SafeArea(
        child: Container(
          color: Colors.transparent,
          width: double.infinity,
          height: containerHeight,
          child: Row(
            mainAxisAlignment: mainAxisAlignment,
            children: items.map((item) {
              var index = items.indexOf(item);
              return GestureDetector(
                onTap: () => onItemSelected!(index),
                child: _ItemWidget(
                  item: item,
                  iconSize: iconSize,
                  isSelected: index == selectedIndex,
                  backgroundColor: Colors.transparent,
                  itemCornerRadius: itemCornerRadius,
                  animationDuration: animationDuration,
                  curve: curve,
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class _ItemWidget extends StatelessWidget {
  final double? iconSize;
  final bool? isSelected;
  final BottomNavyBarItem? item;
  final Color? backgroundColor;
  final double? itemCornerRadius;
  final Duration? animationDuration;
  final Curve curve;

  const _ItemWidget({
    Key? key,
    this.item,
    this.isSelected,
    this.backgroundColor,
    this.animationDuration,
    this.itemCornerRadius,
    this.iconSize,
    this.curve = Curves.linear,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      selected: isSelected,
      child: AnimatedContainer(
        width: isSelected! ? 80 : 70,
        height: double.maxFinite,
        duration: animationDuration!,
        curve: curve,
        decoration: BoxDecoration(
          color: isSelected! ? Colors.yellow : backgroundColor,
          borderRadius: BorderRadius.circular(itemCornerRadius!),
        ),
        child: Center(
          child: SizedBox(
            width: isSelected! ? 80 : 70,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                IconTheme(
                  data: IconThemeData(
                    size: iconSize,
                    color: isSelected!
                        ? item!.activeColor!.withOpacity(1)
                        : item!.inactiveColor,
                  ),
                  child: item!.icon!,
                ),
                Container(
                  padding: const EdgeInsets.only(top: 2),
                  child: DefaultTextStyle.merge(
                    style: TextStyle(
                      color: isSelected! ? Colors.brown[800] : Colors.black,
                    ),
                    maxLines: 1,
                    textAlign: item!.textAlign,
                    child: item!.title!,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
