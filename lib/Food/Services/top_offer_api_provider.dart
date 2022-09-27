import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mycityapp/Food/Models/TopOffersModel.dart';

//Top Offer API Provider

class TopOfferApiProvider with ChangeNotifier {
  bool _error = false;
  String _errorMessage = "";
  TopOfferResponseModel? _topOfferResponseModel;

  Future getBannerList(String lat, String long) async {
    final uri = Uri.parse(
        "https://chillkrt.in/Mycities/Mycities_food/index.php/api/Api_customer/meat_banner_list");

    final response = await post(uri, body: {'lat': lat, 'long': long});

    if (response.statusCode == 200) {
      try {
        final jsonResponse = jsonDecode(response.body);
        _topOfferResponseModel = TopOfferResponseModel.fromJson(jsonResponse);
      } catch (e) {
        _error = true;
        _errorMessage =
            "Error response status code " + response.statusCode.toString();
        _topOfferResponseModel = null;
      }
    } else {
      _error = true;
      _errorMessage =
          "Error response status code " + response.statusCode.toString();
      _topOfferResponseModel = null;
    }
    notifyListeners();
  }

  bool get error => _error;

  String get errorMessage => _errorMessage;

  TopOfferResponseModel? get topOfferResponseModel => _topOfferResponseModel;
}
