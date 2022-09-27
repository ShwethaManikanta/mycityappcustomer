import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class VerifyUserLoginAPIProvider with ChangeNotifier {
  bool _error = false;
  String _errorMessage = "";
  String? _status;

  bool get isLoading => _error == false && _status == null;

  Future<void> getUser(
      {required String deviceToken,
      required String userFirebaseID,
      required String phoneNumber}) async {
    final uri = Uri.parse(
        "https://chillkrt.in/Mycities/Mycities_food/index.php/api/Api_customer/login");

    final response = await post(uri, body: {
      'user_fid': userFirebaseID,
      'device_token': deviceToken,
      // 'phone_number': phoneNumber
    });

    if (response.statusCode == 200) {
      try {
        final jsonResponse = jsonDecode(response.body);
        print(jsonResponse.toString());
        _status = jsonResponse['status'];

        print(jsonResponse['status']);
        print("------------------");
        print("Edit address Success");
        print("-------------------------------------");
      } catch (e) {
        _error = true;
        _errorMessage =
            "Status code of response " + response.statusCode.toString();
        _status = null;
        print("------------------");
        print("Login Failed");
        print("-------------------------------------");
      }
    } else {
      _error = true;
      _errorMessage =
          "Status code of response " + response.statusCode.toString();
      _status = null;
      print("------------------");
      print("Login Failed");
      print("-------------------------------------");
    }
    notifyListeners();
  }

  bool get error => _error;

  String get errorMessage => _errorMessage;

  String? get loginResponse => _status;

  initialize() {
    _status = null;
    _error = false;
    _errorMessage = "";
  }
}
