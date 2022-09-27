import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart';
import 'package:mycityapp/Cab/Models/login_model.dart';

class LoginAPIProvider with ChangeNotifier {
  bool _error = false;
  String _errorMessage = "";
  LoginResponseModel? _loginResponse;

  Future<void> emailLogin(
      {required String email,
      required String password,
      required String deviceToken,
      required String userFirebaseID}) async {
    final uri = Uri.parse(
        "http://chillkrt.in/True_drivers_admin/index.php/Api_customer/signIn");

    final response = await post(uri, body: {
      'email': email,
      'password': password,
      'user_fid': userFirebaseID,
      'device_token': deviceToken
    });

    if (response.statusCode == 200) {
      try {
        final jsonResponse = jsonDecode(response.body);
        print(jsonResponse.toString());
        _loginResponse = LoginResponseModel.fromJson(jsonResponse);
        print(_loginResponse!.message!);
        print("------------------");
        print("Login Success - -------" + _loginResponse!.userDetails!.id!);
        print("-------------------------------------");
      } catch (e) {
        _error = true;
        _errorMessage =
            "Status code of response " + response.statusCode.toString();
        _loginResponse = null;
        print("------------------");
        print("Login Failed");
        print("-------------------------------------");
      }
    } else {
      _error = true;
      _errorMessage =
          "Status code of response " + response.statusCode.toString();
      _loginResponse = null;
      print("------------------");
      print("Login Failed");
      print("-------------------------------------");
    }
    notifyListeners();
  }

  bool get error => _error;

  String get errorMessage => _errorMessage;

  LoginResponseModel? get loginResponse => _loginResponse;
}

class VerifyUserLoginAPIProvider with ChangeNotifier {
  bool _error = false;
  String _errorMessage = "";
  LoginResponseModel? _loginResponse;

  bool get isLoading => _error == false && _loginResponse == null;

  Future<void> getUser(
      {required String deviceToken,
      required String userFirebaseID,
      required String phoneNumber}) async {
    final uri = Uri.parse(
        "http://chillkrt.in/True_drivers_admin/index.php/Api_customer/signIn");

    final response = await post(uri, body: {
      'mobile_no': phoneNumber,
      'device_token': deviceToken,
      'user_fid': userFirebaseID
    });

    if (response.statusCode == 200) {
      try {
        final jsonResponse = jsonDecode(response.body);
        print(jsonResponse.toString());
        _loginResponse = LoginResponseModel.fromJson(jsonResponse);
        print(_loginResponse!.message!);
        print("------------------");
        print("Login Success");
        print("-------------------------------------");
      } catch (e) {
        _error = true;
        _errorMessage =
            "Status code of response " + response.statusCode.toString();
        _loginResponse = null;
        print("------------------");
        print("Login Failed");
        print("-------------------------------------");
      }
    } else {
      _error = true;
      _errorMessage =
          "Status code of response " + response.statusCode.toString();
      _loginResponse = null;
      print("------------------");
      print("Login Failed");
      print("-------------------------------------");
    }
    notifyListeners();
  }

  bool get error => _error;

  String get errorMessage => _errorMessage;

  LoginResponseModel? get loginResponse => _loginResponse;
}
