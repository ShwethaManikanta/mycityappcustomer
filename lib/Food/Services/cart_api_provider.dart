import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mycityapp/Cab/Services/api_services.dart';
import 'package:mycityapp/Food/Models/CartList.dart';
import 'package:http/http.dart' as http;

class CartListAPIProvider with ChangeNotifier {
  String _errorMessage = "";
  bool _error = false;
  CartResponseModel? _cartResponseModel;

  bool get ifLoading => _error == false && cartResponseModel == null;

  Future<void> cartlist(dynamic lat, dynamic long, dynamic promocode,
      {String deliveryPartner = "0"}) async {
    Uri url = Uri.parse(
        "https://chillkrt.in/Mycities/Mycities_food/index.php/api/Api_customer/cartlist");

    final req = await http.post(url, body: {
      "user_id": ApiServices.userId!,
      "lat": "$lat",
      "long": "$long",
      "promocode": "$promocode",
      "delivery_partner": deliveryPartner
    });
    print("_-----__------_____________________cart list apic call happening" +
        "user i f - - - " +
        ApiServices.userId!);
    if (req.statusCode == 200) {
      print(
          "_-----__------_____________________cart list apic status code 200");

      try {
        final jsonResponse = jsonDecode(req.body);
        print("--------------- cart list api provider " +
            _cartResponseModel.toString());
        _cartResponseModel = CartResponseModel.fromJson(jsonResponse);

        print("--------------- cart list api provider " +
            _cartResponseModel.toString());
      } catch (e) {
        _error = true;
        _errorMessage = e.toString();
        _cartResponseModel = null;
      }
    } else {
      _error = true;
      _errorMessage = "Error from internet ${req.statusCode}";
      _cartResponseModel = null;
    }
    notifyListeners();
  }

  String get errorMessage => _errorMessage;

  bool get error => _error;

  CartResponseModel? get cartResponseModel => _cartResponseModel;

  initialize() {
    _cartResponseModel = null;
    _error = false;
    _errorMessage = "";
  }
}
