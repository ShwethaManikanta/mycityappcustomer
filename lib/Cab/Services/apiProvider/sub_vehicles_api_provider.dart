import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mycityapp/Cab/Models/sub_vehicle_list_response_model.dart';

class SubVehicleListAPIProvider with ChangeNotifier {
  bool _error = false;
  String _errorMessage = "";
  SubVehicleListResponseModel? _vehicleListResponseModel;

  Future<void> fetchData({required String vehicleCategoryId}) async {
    final uri = Uri.parse(
        "http://chillkrt.in/True_drivers_admin/index.php/Api_customer/get_sub_vehicle_list");
    final response =
        await post(uri, body: {"vehicle_type_id": vehicleCategoryId});

    if (response.statusCode == 200) {
      try {
        final jsonResponse = jsonDecode(response.body);
        _vehicleListResponseModel =
            SubVehicleListResponseModel.fromJson(jsonResponse);
      } catch (e) {
        _error = false;
        _errorMessage = e.toString();
        _vehicleListResponseModel = null;
      }
    } else {
      _error = false;
      _errorMessage =
          "Error with response code " + response.statusCode.toString();
      _vehicleListResponseModel = null;
    }
    notifyListeners();
  }

  bool get error => _error;

  String get errorMessage => _errorMessage;

  SubVehicleListResponseModel? get vehicleListResponseModel =>
      _vehicleListResponseModel;

  bool get ifLoading => _error == false && _vehicleListResponseModel == null;
}
