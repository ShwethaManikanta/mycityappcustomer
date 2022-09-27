import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mycityapp/Cab/Services/api_services.dart';
import 'package:mycityapp/Food/Models/OrderHistory.dart';

import 'ApiServices.dart';

class OrderHistoryAPIProvider with ChangeNotifier {
  String _errorMessage = "";
  bool _error = false;
  OrderHistoryResponseModel? _orderHistoryResponseModel;

  bool get ifLoading => _error == false && _orderHistoryResponseModel == null;

  Future<void> getOrderHistory(
      dynamic lat, dynamic long, dynamic promocode) async {
    Uri url = Uri.parse(
        "https://chillkrt.in/Mycities/Mycities_food/index.php/api/Api_customer/order_history");

    final req = await http.post(url, body: {
      "user_id": ApiServices.userId!,
      "lat": "$lat",
      "long": "$long",
      "promocode": "$promocode"
    });
    if (req.statusCode == 200) {
      try {
        final jsonResponse = jsonDecode(req.body);
        _orderHistoryResponseModel =
            OrderHistoryResponseModel.fromJson(jsonResponse);
      } catch (e) {
        _error = true;
        _errorMessage = e.toString();
        _orderHistoryResponseModel = null;
      }
    } else {
      _error = true;
      _errorMessage = "Error from internet ${req.statusCode}";
      _orderHistoryResponseModel = null;
    }
    notifyListeners();
  }

  String get errorMessage => _errorMessage;

  bool get error => _error;

  OrderHistoryResponseModel? get orderHistoryResponseModel =>
      _orderHistoryResponseModel;

  initialize() {
    _orderHistoryResponseModel = null;
    _error = false;
    _errorMessage = "";
  }
}
