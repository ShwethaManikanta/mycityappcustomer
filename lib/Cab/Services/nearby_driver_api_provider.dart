import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mycityapp/Cab/Models/near_driver_list_model.dart';

class NearbyDriverListAPIProvider with ChangeNotifier {
  bool _error = false;
  String _errorMessage = "";
  NearByDriverListModel? _nearByDriverListModel;

  NearByDriverListModel? get nearByDriverListModel => _nearByDriverListModel;

  bool get error => _error;

  String get errorMessage => _errorMessage;

  bool get ifLoading => _error == false && _nearByDriverListModel == null;

  Future<void> nearByDriverList(
      String fromLat, String fromLng, String vehicleId, String type) async {
    final uri = Uri.parse(
        "https://chillkrt.in/True_drivers_admin/index.php/Api_customer/near_driver_list");
    final response = await post(uri, body: {
      'from_lat': fromLat,
      'from_lng': fromLng,
      'vehicle_id': vehicleId,
      'type': type
    });

    print("Near Driver List ---------" + response.statusCode.toString());

    if (response.statusCode == 200) {
      try {
        final jsonResponse = jsonDecode(response.body);
        _nearByDriverListModel = NearByDriverListModel.fromJson(jsonResponse);
        print("Near Driver List ---------------- TRY" + response.body);
      } catch (e) {
        _error = false;
        _errorMessage = e.toString();
        _nearByDriverListModel = null;
      }
    } else {
      _error = false;
      _errorMessage =
          "Error with response code " + response.statusCode.toString();
      _nearByDriverListModel = null;
    }
    notifyListeners();
  }
}
