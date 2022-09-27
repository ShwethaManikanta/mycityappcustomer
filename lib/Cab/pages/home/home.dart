import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:titled_navigation_bar/titled_navigation_bar.dart';
import 'package:mycityapp/Cab/Services/apiProvider/registration_api_provider.dart';
import 'package:mycityapp/Cab/pages/payment_page.dart';
import 'package:mycityapp/Cab/pages/profile_setting.dart';
import 'package:mycityapp/common/common_styles.dart';
import '../../Services/location_services.dart/notification_service.dart';
import '../orderDetails/order_success_screen.dart';
import 'homepage.dart';
import '../orderPage/order_page.dart';

class MainHomePage extends StatefulWidget {
  const MainHomePage({Key? key}) : super(key: key);

  @override
  _MainHomePageState createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  bool status = false;

  @override
  void initState() {
    LocalNotificationServices.initialize(context);

    //Gives you the message on which user taps
    //and it opened the app is killed
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        LocalNotificationServices.display(message);

        if (message.data['status'] != null) {
          if (message.data['status'] == "1") {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ShowDetailedTransactionOrderId(
                      orderId: message.data['order_id'],
                    )));
          } else if (message.data['status'] == "2") {
            print("Notification Status -------------------" +
                message.data["status"]);
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => OrderPage()));
          }
          //   Navigator.of(context).pushNamed(message.data['route']);
        }
        // final routeFromMessage = message.data['route'];
        // Navigator.of(context).pushNamed(routeFromMessage);
      }
    });

    //When the app is in foreground
    FirebaseMessaging.onMessage.listen((message) {
      // Navigator.of(context)
      //     .push(MaterialPageRoute(builder: (context) => const HomePage()));
      LocalNotificationServices.display(message);
      /* print("Notification Status -------------------" +
          message.data["status"]);*/

      LocalNotificationServices.display(message);

      if (message.data['status'] != null) {
        print(
            "Notification Status -------------------" + message.data["status"]);

        if (message.data['status'] == "1") {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ShowDetailedTransactionOrderId(
                    orderId: message.data['order_id'],
                  )));
        } else if (message.data['status'] == "2") {
          print("Notification Status -------------------" +
              message.data["status"]);
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const OrderPage()));
        }
        // Navigator.of(context).pushNamed(message.data['route']);
      }
      // final routeFromMessage = message.data['route'];
      // Navigator.of(context).pushNamed(routeFromMessage);
    });

    //When the app is in background but opened and user taps
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      if (message.data['status'] != null) {
        print(
            "Notification Status -------------------" + message.data["status"]);

        if (message.data['status'] == "1") {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ShowDetailedTransactionOrderId(
                    orderId: message.data['order_id'],
                  )));
        } else if (message.data['status'] == "2") {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const OrderPage()));
        }
        //  Navigator.of(context).pushNamed(message.data['route']);
      }
      // final routeFromMessage = message.data['route'];
      // print(routeFromMessage);
      // if (routeFromMessage != null || routeFromMessage != "") {
      //   Navigator.of(context).pushNamed(routeFromMessage);
      // }
      LocalNotificationServices.display(message);
    });

    if (context.read<ProfileViewAPIProvider>().profileViewResponse == null) {
      context.read<ProfileViewAPIProvider>().fetchData();
    }
    super.initState();
  }

  List<Widget> body = [
    const HomePage(),
    const OrderPage(),
    const ProfileSetting(),
    const PaymentPage(),
  ];

  int bodyIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(
        index: bodyIndex,
        children: body,
      ),
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  buildBody() {
    return body.elementAt(bodyIndex);
  }

  buildBottomNavigationBar() {
    return TitledBottomNavigationBar(
        activeColor: Colors.indigo[800],
        inactiveColor: Colors.black54,
        height: 45,
        currentIndex: bodyIndex,
        onTap: (index) {
          setState(() {
            bodyIndex = index;
          });
        },
        items: [
          TitledNavigationBarItem(
            title: Text(
              'Home'.toUpperCase(),
              style: CommonStyles.black13thinW54(),
            ),
            icon: const Icon(Icons.home),
          ),
          TitledNavigationBarItem(
              title: Text(
                'Bookings'.toUpperCase(),
                style: CommonStyles.black13thinW54(),
              ),
              icon: const Icon(Icons.access_time_outlined)),
          TitledNavigationBarItem(
              title: Text(
                'Profile'.toUpperCase(),
                style: CommonStyles.black13thinW54(),
              ),
              icon: const Icon(Icons.person)),
        ]);
  }
}
