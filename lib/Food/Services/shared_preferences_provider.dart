import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum SharedPreferencesInitializationStatus { initialized, uninitialized }

class SharedPreferencesProvider with ChangeNotifier {
  late SharedPreferences sharedPreferences;

  SharedPreferencesInitializationStatus _status =
      SharedPreferencesInitializationStatus.uninitialized;

  late String _userId;
  late bool _isUserLoggedIn;
  late bool _viewedSplashPage;

  SharedPreferencesProvider() {
    initialize();
  }

  initialize() async {
    sharedPreferences = await SharedPreferences.getInstance();
    // _status = SharedPreferencesInitializationStatus.initialized;
    // _userId = sharedPreferences.getString("id") ?? "NA";
    // _isUserLoggedIn = sharedPreferences.getBool("isUserLoggedIn") ?? false;
    // _viewedSplashPage = sharedPreferences.getBool("viewedSplashPage") ?? false;
    notifyListeners();
  }

  Future<bool> setIsUserLoggedIn({required bool userLoginStatus}) async {
    return await sharedPreferences.setBool('isUserLoggedIn', userLoginStatus);
  }

  Future<bool> getIsUserLoggedIn() async {
    sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool('isUserLoggedIn') ?? false;
  }

  Future<bool> setUserId({required String userId}) async {
    return await sharedPreferences.setString('userId', userId);
  }

  // String get userId => _userId;

  Future<String> getUserId() async {
    sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString('userId') ?? "NA";
  }
  // bool get isUserLoggedIn => _isUserLoggedIn;

  bool get viewedSplashPage => _viewedSplashPage;

  // set isUserLoggedIn(bool value) {
  //   sharedPreferences.setBool("isUserLoggedIn", value);
  //   notifyListeners();
  // }

  set userId(String value) {
    sharedPreferences.setString("id", value);
    notifyListeners();
  }

  SharedPreferencesInitializationStatus get status => _status;
}
