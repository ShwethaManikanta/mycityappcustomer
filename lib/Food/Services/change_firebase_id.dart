import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class ChangeFirebaseId with ChangeNotifier {
  bool _error = false;
  String _errorMessage = "";
  String? _status;

  Future<void> fetchData(
      {required String firebaseID, required String userID}) async {
    final uri = Uri.parse(
        "https://chillkrt.in/Mycities/Mycities_food/index.php/api/Api_customer/firebaseid_update");

    final request =
        await post(uri, body: {'firebase_id': firebaseID, 'user_id': userID});

    if (request.statusCode == 200) {
      try {
        final jsonResponse = jsonDecode(request.body);
        _status = jsonResponse['status'];
      } catch (e) {
        _error = true;
        _errorMessage = "Error Status Code " + request.statusCode.toString();
        _status = null;
      }
    } else {
      _error = true;
      _errorMessage = "Error Status Code " + request.statusCode.toString();
      _status = null;
    }
    notifyListeners();
  }

  bool get error => _error;

  String get errorMessage => _errorMessage;

  String? get status => _status;

  bool get ifLoading => _error == false && _status == null;

  initialize() {
    _status = null;
    _error = false;
    _errorMessage = "";
  }
}
