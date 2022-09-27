/*
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:truedriverapp/Food/Services/ApiServices.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double margin = 100;
  double height = 150;
  double width = 150;

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(milliseconds: 500), (timer) {
      if (timer.tick <= 5) {
        if (mounted) {
          setState(() {
            margin = margin - 2;
            height = 700;
            width = 700;
          });
        }
      } else {
        timer.cancel();
        if (ApiServices.userId == null) {
          Navigator.pushReplacementNamed(context, "Onboarding");
        } else {
          Navigator.pushReplacementNamed(context, "GetLocation");
        }
      }
    });
    SharedPreferences.getInstance().then((value) {
      ApiServices.sharedPreferences = value;
      String? userJson = value.getString("userId");
      if (userJson != null) {
        // ApiServices.user = LoginResponse.fromJson(userJson);
        ApiServices.userId = value.getString('userId');
      }

      // apiServices.getBanners();
      // apiServices.getBottomBanners();

      // apiServices.getOnboardingBanners();
      // apiServices.offerBanners();
      // apiServices.meatBanners();

      // apiServices.getTopOffers(
      //     SharedPreference.latitudeValue, SharedPreference.longitudeValue);

      // apiServices.profileView();
      // apiServices.orderHistory();
      // apiServices.getTakeAway("", "", "");
      // // apiServices.getPopularRestaurants("", "");
      // apiServices.getPopularDishes(
      //     SharedPreference.latitudeValue, SharedPreference.longitudeValue);
      // apiServices.getDishesList(
      //     SharedPreference.latitudeValue, SharedPreference.longitudeValue);
    });
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.yellow,
        body: buildBody(),
      ),
    );
  }

  buildBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Spacer(),
        AspectRatio(
          aspectRatio: 1,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 500),
            margin: EdgeInsets.all(margin),
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.contain,
                image: AssetImage("assets/images/splashImg.png"),
              ),
            ),
          ),
        ),
        Spacer(),
      ],
    );
  }
}
*/
