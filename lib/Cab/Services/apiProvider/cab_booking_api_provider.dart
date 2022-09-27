import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mycityapp/Cab/Models/cab_booking_model.dart';
import 'package:mycityapp/Cab/Services/api_services.dart';

class CabBookingAPIProvider with ChangeNotifier {
  bool _error = false;
  String _errorMessage = "";
  CabBookingModel? _cabBookingModel;

  CabBookingModel? get cabBookingModel => _cabBookingModel;

  Future<void> fetchData(
      {required String bookType,
      required String customerName,
      required String customerMobile,
      required String vehicleTypeId,
      required String gst,
      required String duration,
      required String distance,
      required String total,
      required String fromLat,
      required String fromLong,
      required String fromAddress,
      required String toLat,
      required String toLong,
      required String toAddress,
      required String transactionId,
      required String vehicleCharge,
      required String timeState,
      required String rideTime,
      required String deviceType}) async {
    final uri = Uri.parse(
        "https://chillkrt.in/True_drivers_admin/index.php/Api_customer/book_vehicle_cabs");
    final response = await post(uri, body: {
      "user_id": ApiServices.userId,
      "book_type": bookType,
      "customer_name": customerName,
      "customer_mobile": customerMobile,
      "vehicle_type_id": vehicleTypeId,
      "gst": gst,
      "duration": duration,
      "distance": distance,
      "total": total,
      "from_lat": fromLat,
      "from_long": fromLong,
      "from_address": fromAddress,
      "to_lat": toLat,
      "to_long": toLong,
      "to_address": toAddress,
      "transaction_id": transactionId,
      "vehicle_charge": vehicleCharge,
      "time_state": timeState,
      "ride_time": rideTime,
      "device_type": deviceType
    });
    print("vechile ID --------------" + vehicleTypeId);
    print(
        "cab Booking ========== 00000000000 " + response.statusCode.toString());
    print("cab Booking UserId ========== 00000000000 " + ApiServices.userId!);
    print("Cab Booking res body------------" + response.body.toString());

    if (response.statusCode == 200) {
      try {
        final jsonResponse = jsonDecode(response.body);
        _cabBookingModel = CabBookingModel.fromJson(jsonResponse);
      } catch (e) {
        _error = false;
        _errorMessage = e.toString();

        _cabBookingModel = null;
      }
    } else {
      _error = false;
      _errorMessage =
          "Error with response code " + response.statusCode.toString();
      _cabBookingModel = null;
    }
    notifyListeners();
  }

  bool get error => _error;

  String get errorMessage => _errorMessage;

  bool get ifLoading => _error == false && _cabBookingModel == null;
}
