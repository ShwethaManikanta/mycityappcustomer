import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mycityapp/Cab/Services/api_services.dart';
import 'package:mycityapp/Food/Models/UserModel.dart';
import 'package:mycityapp/Food/Services/ApiServices.dart';
import 'package:http/http.dart';

//Profile View Api Provider
class ProfileViewApiProvider with ChangeNotifier {
  bool _error = false;
  String _errorMessage = "";
  ProfileViewResponseModel? _profileViewResponseModel;

  bool get ifLoading => _error == false && _profileViewResponseModel == null;

  Future getProfileView() async {
    final uri = Uri.parse(
        "https://chillkrt.in/Mycities/Mycities_food/index.php/api/Api_customer/profile");

    final response = await post(uri, body: {'user_id': ApiServices.userId});

    if (response.statusCode == 200) {
      try {
        final jsonResponse = jsonDecode(response.body);
        _profileViewResponseModel =
            ProfileViewResponseModel.fromJson(jsonResponse);
      } catch (e) {
        _error = true;
        _errorMessage =
            "Error response status code " + response.statusCode.toString();
        _profileViewResponseModel = null;
      }
    } else {
      _error = true;
      _errorMessage =
          "Error response status code " + response.statusCode.toString();
      _profileViewResponseModel = null;
    }
    notifyListeners();
  }

  bool get error => _error;

  String get errorMessage => _errorMessage;

  ProfileViewResponseModel? get profileViewResponseModel =>
      _profileViewResponseModel;

  initialize() {
    _profileViewResponseModel = null;
    _error = false;
    _errorMessage = "";
  }
}
