import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mycityapp/Food/Models/edit_profile_models.dart';
import '../Models/PopularCurations.dart';

class EditUserProfileAPIProvider with ChangeNotifier {
  String _errorMessage = "";
  bool _error = false;
  EditProfileResponseModel? _editProfileResponseModel;

  bool get ifLoading => _error == false && _editProfileResponseModel == null;

  Future<void> updateProfileRequest(
      {required EditProfileRequestModel editProfileRequestModel}) async {
    Uri url = Uri.parse(
        "https://chillkrt.in/Mycities/Mycities_food/index.php/api/Api_customer/profile_update");

    final req = await http.post(url, body: editProfileRequestModel.toMap());

    print("------edit profile -------");
    print("------edit profile -------   - - -- - - - " +
        req.statusCode.toString());

    if (req.statusCode == 200) {
      try {
        final jsonResponse = jsonDecode(req.body);
        _editProfileResponseModel =
            EditProfileResponseModel.fromJson(jsonResponse);
        print("------edit profile -------");
        print(
            "------edit profile -------   - - -- - - - " + req.body.toString());
      } catch (e) {
        _error = true;
        _errorMessage = e.toString();
        _editProfileResponseModel = null;
        print("------edit profile error -------");
      }
    } else {
      _error = true;
      _errorMessage = "Error from internet ${req.statusCode}";
      _editProfileResponseModel = null;
      print("------edit profile error -------");
    }
    notifyListeners();
  }

  String get errorMessage => _errorMessage;

  bool get error => _error;

  EditProfileResponseModel? get editProfileResponseModel =>
      _editProfileResponseModel;

  initialize() {
    _editProfileResponseModel = null;
    _error = false;
    _errorMessage = "";
  }
}
