import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mycityapp/Cab/Models/vehicle_categories_response_model.dart';
import 'package:mycityapp/Cab/Services/api_services.dart';

class VehicleCategoriesAPIProvider with ChangeNotifier {
  bool _error = false;
  String _errorMessage = "";
  VehicleCategoriesResponseModel? _vehicleCategoriesResponseModel;

  Future<void> fetchData(
      {required String type,
      required double fromLat,
      required double fromLong,
      required double toLat,
      required double toLong,
      required int labourQuantity}) async {
    final uri = Uri.parse(
        "http://chillkrt.in/True_drivers_admin/index.php/Api_customer/get_vehicle_list");
    final response = await post(uri, body: {
      "type": type,
      'from_lat': fromLat.toString(),
      'from_long': fromLong.toString(),
      'to_lat': toLat.toString(),
      'to_long': toLong.toString(),
      'labour_qty': labourQuantity.toString(),
      'user_id': ApiServices.userId
    });

    print("----------- vehicle category response " +
        response.statusCode.toString());

    print("----------- vehicle category response " + response.body.toString());
    print("----------- vehicle category response type" + type);
    print(
        "----------- vehicle category response from_lat" + fromLat.toString());
    print(
        "----------- vehicle category response FromLong" + fromLong.toString());
    print("----------- vehicle category response to lat" + toLat.toString());
    print("----------- vehicle category response toLong" + toLong.toString());
    print("----------- vehicle category response labour" +
        labourQuantity.toString());
    if (response.statusCode == 200) {
      try {
        final jsonResponse = jsonDecode(response.body);
        _vehicleCategoriesResponseModel =
            VehicleCategoriesResponseModel.fromJson(jsonResponse);
        print("----------- vehicle category response " +
            _vehicleCategoriesResponseModel!.message!.toString());
      } catch (e) {
        _error = true;
        _errorMessage = e.toString();
        _vehicleCategoriesResponseModel = null;
      }
    } else {
      _error = true;
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

  initialize() {
    _vehicleCategoriesResponseModel = null;
    _error = false;
    _errorMessage = "";
  }
}
