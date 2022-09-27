import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mycityapp/Cab/Models/vehicle_categories_response_model.dart';

class CouponListAPIProvider with ChangeNotifier {
  bool _error = false;
  String _errorMessage = "";
  VehicleCategoriesResponseModel? _vehicleCategoriesResponseModel;

  Future<void> fetchData() async {
    final uri = Uri.parse("https://truedriverapp.com/api/coupon_list");
    final response = await get(uri);

    if (response.statusCode == 200) {
      try {
        final jsonResponse = jsonDecode(response.body);
        _vehicleCategoriesResponseModel =
            VehicleCategoriesResponseModel.fromJson(jsonResponse);
      } catch (e) {
        _error = false;
        _errorMessage = e.toString();
        _vehicleCategoriesResponseModel = null;
      }
    } else {
      _error = false;
      _errorMessage =
          "Error with response code " + response.statusCode.toString();
      _vehicleCategoriesResponseModel = null;
    }
    notifyListeners();
  }

  bool get error => _error;

  String get errorMessage => _errorMessage;

  VehicleCategoriesResponseModel? get vehicleCategoriesResponseModel =>
      _vehicleCategoriesResponseModel;

  bool get ifLoading =>
      _error == false && vehicleCategoriesResponseModel == null;
}
