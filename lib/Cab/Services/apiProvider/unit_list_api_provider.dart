import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mycityapp/Cab/Models/unit_list_model.dart';

class UnitListAPIProvider with ChangeNotifier {
  bool _error = false;
  String _errorMessage = "";
  UnitListResponseModel? _unitListResponseModel;

  Future<void> fetchUnit() async {
    final uri = Uri.parse(
        "http://chillkrt.in/True_drivers_admin/index.php/Api_customer/units_list");
    final response = await get(uri);

    if (response.statusCode == 200) {
      try {
        final jsonResponse = jsonDecode(response.body);
        _unitListResponseModel = UnitListResponseModel.fromJson(jsonResponse);
      } catch (e) {
        _error = false;
        _errorMessage = e.toString();
        _unitListResponseModel = null;
      }
    } else {
      _error = false;
      _errorMessage =
          "Error with response code " + response.statusCode.toString();
      _unitListResponseModel = null;
    }
    notifyListeners();
  }

  bool get error => _error;

  String get errorMessage => _errorMessage;

  UnitListResponseModel? get unitListResponseModel => _unitListResponseModel;

  bool get ifLoading => _error == false && _unitListResponseModel == null;
}
