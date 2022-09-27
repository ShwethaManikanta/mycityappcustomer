import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mycityapp/Cab/Models/track_driver_model.dart';





class TrackDriverAPIProvider with ChangeNotifier {
  bool _error = false;
  String _errorMessage = "";
  TrackDriverModel? _trackDriverModel;


  TrackDriverModel? get trackDriverModel => _trackDriverModel;

  bool get error => _error;

  String get errorMessage => _errorMessage;

  bool get ifLoading => _error == false && _trackDriverModel == null;



  Future<void> trackDriver(
      String orderId
      ) async {
    final uri = Uri.parse(
        "https://chillkrt.in/True_drivers_admin/index.php/Api_customer/track_details");
    final response = await post(uri, body: {'order_id': orderId});

    print("Near Driver List ---------" + response.statusCode.toString());

    if (response.statusCode == 200) {
      try {
        print("Near Driver List ---------------- TRY" + response.body);
        final jsonResponse = jsonDecode(response.body);
        _trackDriverModel = TrackDriverModel.fromJson(jsonResponse);
      } catch (e) {
        _error = false;
        _errorMessage = e.toString();
        _trackDriverModel = null;
      }
    } else {
      _error = false;
      _errorMessage =
          "Error with response code " + response.statusCode.toString();
      _trackDriverModel = null;
    }
    notifyListeners();
  }
}
