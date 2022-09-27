import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mycityapp/Cab/Models/order_history_model.dart';
import 'package:mycityapp/Cab/Services/api_services.dart';

class OrderHistoryAPIProviderCab with ChangeNotifier {
  bool _error = false;
  String _errorMessage = "";
  OrderHistoryModel? _orderHistoryModel;

  bool get ifLoading => _error == false && _orderHistoryModel == null;

  Future<void> getOrders() async {
    final uri = Uri.parse(
        "http://chillkrt.in/True_drivers_admin/index.php/Api_customer/order_history");
    print("order history -----------" + ApiServices.userId!);
    final response = await post(uri, body: {'user_id': ApiServices.userId});

    if (response.statusCode == 200) {
      try {
        final jsonResponse = jsonDecode(response.body);
        print(jsonResponse.toString());
        _orderHistoryModel = OrderHistoryModel.fromJson(jsonResponse);
        print("------------------");
        print("Order History Fetching Success");
        print("-------------------------------------");
      } catch (e) {
        _error = true;
        _errorMessage = e.toString();
        _orderHistoryModel = null;
        print("------------------");
        print("Order History Fetching  Failed");
        print("-------------------------------------");
      }
    } else {
      _error = true;
      _errorMessage =
          "Status code of response " + response.statusCode.toString();
      _orderHistoryModel = null;
      print("------------------");
      print("Order History Fetching  Failed");
      print("-------------------------------------");
    }
    notifyListeners();
  }

  bool get error => _error;

  String get errorMessage => _errorMessage;

  OrderHistoryModel? get orderHistoryResponse => _orderHistoryModel;
}
