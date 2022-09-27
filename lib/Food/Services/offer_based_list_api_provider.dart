import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../Models/offer_banner_list_model.dart';

class OfferRestaurantBannerAPIProvider with ChangeNotifier {
  bool _error = false;
  String _errorMessage = "";
  OfferRestaurantBannerResponseModel? _offerRestaurantBannerResponseModel;

  bool get ifLoading =>
      _error == false && _offerRestaurantBannerResponseModel == null;

  Future getOfferBannerBased(
      {required String lat,
      required String long,
      required String offerLimit,
      required String filter,
      required String id}) async {
    final uri = Uri.parse(
        "https://chillkrt.in/Mycities/Mycities_food/index.php/api/Api_customer/offer_restaurant_list");

    final response = await post(uri, body: {
      'lat': lat,
      'long': long,
      'offer_limit': offerLimit,
      'filter': filter,
      'id': id
    });
    if (response.statusCode == 200) {
      try {
        final jsonResponse = jsonDecode(response.body);
        _offerRestaurantBannerResponseModel =
            OfferRestaurantBannerResponseModel.fromJson(jsonResponse);
      } catch (e) {
        _error = true;
        _errorMessage = e.toString();
        _offerRestaurantBannerResponseModel = null;
      }
    } else {
      _error = true;
      _errorMessage = "Error Response Code " + response.statusCode.toString();
      _offerRestaurantBannerResponseModel = null;
    }
    notifyListeners();
  }

  bool get error => _error;

  String get errorMessage => _errorMessage;

  OfferRestaurantBannerResponseModel? get offerRestaurantBannerResponseModel =>
      _offerRestaurantBannerResponseModel;

  initialize() {
    _error = false;
    _errorMessage = '';
    _offerRestaurantBannerResponseModel = null;
  }
}
