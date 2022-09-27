import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mycityapp/Food/Models/DishesList.dart';

class BeverageListAPIProvider with ChangeNotifier {
  bool _error = false;
  String _errorMessage = "";
  BeverageResponseModel? _beverageResponseModel;

  Future<void> getBeverageList(
    dynamic lat,
    dynamic long,
  ) async {
    final uri = Uri.parse(
        "https://chillkrt.in/Mycities/Mycities_food/index.php/api/Api_customer/beverages_list");
    final response =
        await post(uri, body: {"lat": lat.toString(), "long": long.toString()});
    if (response.statusCode == 200) {
      try {
        final jsonResponse = jsonDecode(response.body);
        _beverageResponseModel = BeverageResponseModel.fromJson(jsonResponse);
      } catch (e) {
        _error = true;
        _errorMessage = e.toString();
        _beverageResponseModel = null;
      }
    } else {
      _error = true;
      _errorMessage =
          "The http response code is " + response.statusCode.toString();
      _beverageResponseModel = null;
    }
    notifyListeners();
  }

  bool get isLoading => _error == false && beverageResponseModel == null;

  bool get error => _error;

  String get errorMessage => _errorMessage;

  BeverageResponseModel? get beverageResponseModel => _beverageResponseModel;

  initialize() {
    _beverageResponseModel = null;
    _error = false;
    _errorMessage = "";
  }
}
