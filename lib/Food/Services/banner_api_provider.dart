import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mycityapp/Food/Models/banner_list_response_models.dart';

//Front Page Banner API provider
class FrontPageBannerAPIProvider with ChangeNotifier {
  bool _error = false;
  String _errorMessage = "";
  FrontBannerListResponseModel? _frontBannerListResponseModel;
  bool get ifLoading =>
      _error == false && _frontBannerListResponseModel == null;

  Future getFrontBanners() async {
    final uri = Uri.parse(
        "https://chillkrt.in/Mycities/Mycities_food/index.php/api/Api_customer/front_banner_list");

    final response = await get(uri);

    if (response.statusCode == 200) {
      try {
        final jsonResponse = jsonDecode(response.body);
        _frontBannerListResponseModel =
            FrontBannerListResponseModel.fromJson(jsonResponse);
        print("------------");
        print("FrontPage Banner API Execution Success");
        print("----------------------------------");
      } catch (e) {
        _error = true;
        _errorMessage =
            "Error response status code " + response.statusCode.toString();
        _frontBannerListResponseModel = null;
        print("------------");
        print("FrontPage Banner API Execution Failed");
        print("----------------------------------");
      }
    } else {
      _error = true;
      _errorMessage =
          "Error response status code " + response.statusCode.toString();
      _frontBannerListResponseModel = null;
      print("------------");
      print("FrontPage Banner API Execution Failed");
      print("----------------------------------");
    }
    notifyListeners();
  }

  bool get error => _error;

  String get errorMessage => _errorMessage;

  FrontBannerListResponseModel? get frontBannerListResponseModel =>
      _frontBannerListResponseModel;
  initialize() {
    _frontBannerListResponseModel = null;
    _error = false;
    _errorMessage = "";
  }
}

//Banner List Page API provider.
class BannerListAPIProvider with ChangeNotifier {
  bool _error = false;
  String _errorMessage = "";
  BannerListResponseModel? _bannerListResponseModel;

  bool get ifLoading => _error == false && _bannerListResponseModel == null;

  Future getBannerList() async {
    final uri = Uri.parse(
        "https://chillkrt.in/Mycities/Mycities_food/index.php/api/Api_customer/bannerList");

    final response = await get(uri);

    if (response.statusCode == 200) {
      try {
        final jsonResponse = jsonDecode(response.body);
        _bannerListResponseModel =
            BannerListResponseModel.fromJson(jsonResponse);
        print("------------");
        print("BannerList API Executed Successfully");
        print("----------------------------------");
      } catch (e) {
        _error = true;
        _errorMessage =
            "Error response status code " + response.statusCode.toString();
        _bannerListResponseModel = null;
        print("------------");
        print("BannerList API Execution Failed");
        print("----------------------------------");
      }
    } else {
      _error = true;
      _errorMessage =
          "Error response status code " + response.statusCode.toString();
      _bannerListResponseModel = null;
      print("------------");
      print("BannerList API Execution Failed");
      print("----------------------------------");
    }
    notifyListeners();
  }

  bool get error => _error;

  String get errorMessage => _errorMessage;

  BannerListResponseModel? get bannerListResponseModel =>
      _bannerListResponseModel;

  initialize() {
    _bannerListResponseModel = null;
    _error = false;
    _errorMessage = "";
  }
}

//Bottom Banner API Providder
class BottomBannerAPIProvider with ChangeNotifier {
  bool _error = false;
  String _errorMessage = "";
  BottomBannerResponseModel? _bottomBannerResponseModel;

  bool get ifLoading => _error == false && _bottomBannerResponseModel == null;

  Future getBottomBannerApiProvider() async {
    final uri = Uri.parse(
        "https://chillkrt.in/Mycities/Mycities_food/index.php/api/Api_customer/bottom_bannerList");

    final response = await get(uri);

    if (response.statusCode == 200) {
      try {
        final jsonResponse = jsonDecode(response.body);
        _bottomBannerResponseModel =
            BottomBannerResponseModel.fromJson(jsonResponse);
        print("------------");
        print("Bottom Banner API Executed Successfully");
        print("----------------------------------");
      } catch (e) {
        _error = true;
        _errorMessage =
            "Error response status code " + response.statusCode.toString();
        _bottomBannerResponseModel = null;
        print("------------");
        print("Bottom Banner API Execution Failed");
        print("----------------------------------");
      }
    } else {
      _error = true;
      _errorMessage =
          "Error response status code " + response.statusCode.toString();
      _bottomBannerResponseModel = null;
      print("------------");
      print("Bottom Banner API Execution Failed");
      print("----------------------------------");
    }
    notifyListeners();
  }

  bool get error => _error;
  initialize() {
    _bottomBannerResponseModel = null;
    _error = false;
    _errorMessage = "";
  }

  String get errorMessage => _errorMessage;

  BottomBannerResponseModel? get bottomBannerResponseModel =>
      _bottomBannerResponseModel;
}

//Offer Banner Response Model

class RestaurantOfferBannerAPIProvider with ChangeNotifier {
  bool _error = false;
  String _errorMessage = "";
  OfferBannerResponseModel? _offerBannerResponseModel;

  bool get ifLoading => _error == false && _offerBannerResponseModel == null;

  Future getOfferBannerList() async {
    final uri = Uri.parse(
        "https://chillkrt.in/Mycities/Mycities_food/index.php/api/Api_customer/offer_banner_list");

    final response = await get(uri);

    if (response.statusCode == 200) {
      try {
        final jsonResponse = jsonDecode(response.body);
        _offerBannerResponseModel =
            OfferBannerResponseModel.fromJson(jsonResponse);
      } catch (e) {
        _error = true;
        _errorMessage =
            "Error response status code " + response.statusCode.toString();
        _offerBannerResponseModel = null;
      }
    } else {
      _error = true;
      _errorMessage =
          "Error response status code " + response.statusCode.toString();
      _offerBannerResponseModel = null;
    }
    notifyListeners();
  }

  bool get error => _error;

  String get errorMessage => _errorMessage;

  OfferBannerResponseModel? get offerBannerResponseModel =>
      _offerBannerResponseModel;

  initialize() {
    _offerBannerResponseModel = null;
    _error = false;
    _errorMessage = "";
  }
}

//Meat Banner List Response Model

class MeatBannerListAPIProvider with ChangeNotifier {
  bool _error = false;
  String _errorMessage = "";
  MeatBannerResponseModel? _meatBannerResponseModel;

  bool get ifLoading => _error == false && _meatBannerResponseModel == null;

  Future getMeatBannerList() async {
    final uri = Uri.parse(
        "https://chillkrt.in/Mycities/Mycities_food/index.php/api/Api_customer/meat_banner_list");

    final response = await get(uri);

    if (response.statusCode == 200) {
      try {
        final jsonResponse = jsonDecode(response.body);
        _meatBannerResponseModel =
            MeatBannerResponseModel.fromJson(jsonResponse);
        print("------------");
        print("Meat Banner List API Executed Successfully");
        print("----------------------------------");
      } catch (e) {
        _error = true;
        _errorMessage =
            "Error response status code " + response.statusCode.toString();
        _meatBannerResponseModel = null;
        print("------------");
        print("Meat Banner List API Execution Failed");
        print("----------------------------------");
      }
    } else {
      _error = true;
      _errorMessage =
          "Error response status code " + response.statusCode.toString();
      _meatBannerResponseModel = null;
      print("------------");
      print("Meat Banner List API Execution Failed");
      print("----------------------------------");
    }
    notifyListeners();
  }

  bool get error => _error;

  String get errorMessage => _errorMessage;

  initialize() {
    _meatBannerResponseModel = null;
    _error = false;
    _errorMessage = "";
  }

  MeatBannerResponseModel? get meatBannerResponseModel =>
      _meatBannerResponseModel;
}

//Bakery List Response Model

class BakeryBannerListAPIProvider with ChangeNotifier {
  bool _error = false;
  String _errorMessage = "";
  BakeryBannerResponseModel? _bakeryBannerResponseModel;

  bool get ifLoading => _error == false && _bakeryBannerResponseModel == null;

  Future getMeatBannerList() async {
    final uri = Uri.parse(
        "https://chillkrt.in/Mycities/Mycities_food/index.php/api/Api_customer/bottom_bannerList");

    final response = await get(uri);

    if (response.statusCode == 200) {
      try {
        final jsonResponse = jsonDecode(response.body);
        _bakeryBannerResponseModel =
            BakeryBannerResponseModel.fromJson(jsonResponse);
        print("------------");
        print("Bakery Banner List API Executed Successfully");
        print("----------------------------------");
      } catch (e) {
        _error = true;
        _errorMessage =
            "Error response status code " + response.statusCode.toString();
        _bakeryBannerResponseModel = null;
        print("------------");
        print("Meat Banner List API Execution Failed");
        print("----------------------------------");
      }
    } else {
      _error = true;
      _errorMessage =
          "Error response status code " + response.statusCode.toString();
      _bakeryBannerResponseModel = null;
      print("------------");
      print("Meat Banner List API Execution Failed");
      print("----------------------------------");
    }
    notifyListeners();
  }

  bool get error => _error;

  String get errorMessage => _errorMessage;

  initialize() {
    _bakeryBannerResponseModel = null;
    _error = false;
    _errorMessage = "";
  }

  BakeryBannerResponseModel? get bakeryBannerResponseModel =>
      _bakeryBannerResponseModel;
}
