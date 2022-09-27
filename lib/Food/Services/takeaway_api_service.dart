import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mycityapp/Food/Models/TakeAwayModel.dart';
import 'package:mycityapp/Food/Services/location_services.dart/loaction_shared_preference.dart';
import '../Models/PopularCurations.dart';

class TakeAwayAPIProvider with ChangeNotifier {
  String _errorMessage = "";
  bool _error = false;
  TakeAwayResponseModel? _takeAwayResponseModel;

  bool get ifLoading => _error == false && _takeAwayResponseModel == null;

  Future<void> getTakeAways() async {
    Uri url = Uri.parse(
        "https://chillkrt.in/Mycities/Mycities_food/index.php/api/Api_customer/take_away");

    final req = await http.post(url, body: {
      'lat': SharedPreference.latitude.toString(),
      'long': SharedPreference.longitude.toString(),
    });
    if (req.statusCode == 200) {
      try {
        final jsonResponse = jsonDecode(req.body);
        _takeAwayResponseModel = TakeAwayResponseModel.fromJson(jsonResponse);
      } catch (e) {
        _error = true;
        _errorMessage = e.toString();
        _takeAwayResponseModel = null;
      }
    } else {
      _error = true;
      _errorMessage = "Error from internet ${req.statusCode}";
      _takeAwayResponseModel = null;
    }
    notifyListeners();
  }

  String get errorMessage => _errorMessage;

  bool get error => _error;

  TakeAwayResponseModel? get takeAwayResponseModel => _takeAwayResponseModel;

  initialize() {
    _takeAwayResponseModel = null;
    _error = false;
    _errorMessage = "";
  }
}
