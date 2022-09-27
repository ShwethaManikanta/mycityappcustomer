import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mycityapp/Cab/Services/api_services.dart';
import '../Models/OngoingOrderModel.dart';
import 'ApiServices.dart';

class OngoingOrderAPIProvider with ChangeNotifier {
  String _errorMessage = "";
  bool _error = false;
  OngoingOrderResponseModel? _ongoingOrderResponseModel;

  bool get ifLoading => _error == false && _ongoingOrderResponseModel == null;

  Future<void> getOrderHistory() async {
    Uri url = Uri.parse(
        "https://chillkrt.in/Mycities/Mycities_food/index.php/api/Api_customer/order_ongoing");

    final req = await http.post(url, body: {"user_id": ApiServices.userId});
    if (req.statusCode == 200) {
      try {
        final jsonResponse = jsonDecode(req.body);
        print(jsonResponse);
        _ongoingOrderResponseModel =
            OngoingOrderResponseModel.fromJson(jsonResponse);
        print("Ongoing order ----- success");
      } catch (e) {
        _error = true;
        _errorMessage = e.toString();
        _ongoingOrderResponseModel = null;
      }
    } else {
      _error = true;
      _errorMessage = "Error from internet ${req.statusCode}";
      _ongoingOrderResponseModel = null;
    }
    notifyListeners();
  }

  String get errorMessage => _errorMessage;

  bool get error => _error;

  OngoingOrderResponseModel? get orderHistoryResponseModel =>
      _ongoingOrderResponseModel;

  initialize() {
    _ongoingOrderResponseModel = null;
    _error = false;
    _errorMessage = "";
  }
}
