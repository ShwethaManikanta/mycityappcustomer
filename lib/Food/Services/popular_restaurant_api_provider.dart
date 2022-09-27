import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mycityapp/Food/Models/PopularRestaurantModel.dart';

class PopularRestaurantAPIProvider with ChangeNotifier {
  bool _error = false;
  String _errorMessage = "";
  PopularRestaurantResponseModel? _popularRestaurantResponseModel;

  bool get ifLoading =>
      _error == false && _popularRestaurantResponseModel == null;

  Future<void> getPopularRestaurant(
      {required String lat,
      required String long,
      required String filter,
      required String type,
      required String foodType,
      String? mallId}) async {
    final uri = Uri.parse(
        "https://chillkrt.in/Mycities/Mycities_food/index.php/api/Api_customer/popular_restaurant");
    print("---------" +
        lat +
        "\n" +
        long +
        "\n" +
        filter +
        "\n" +
        type +
        "\n" +
        foodType);
    final response = await http.post(uri, body: {
      'lat': lat,
      'long': long,
      'filter': filter,
      "type": type,
      "food_type": foodType
    });

    if (response.statusCode == 200) {
      try {
        final jsonResponse = jsonDecode(response.body);
        _popularRestaurantResponseModel =
            new PopularRestaurantResponseModel.fromJson(jsonResponse);
        print("----------------");
        print("Success executing getPopular Restaurant" +
            response.statusCode.toString());
        print("-------------------------------");
      } catch (e) {
        _error = true;
        _errorMessage = e.toString();
        _popularRestaurantResponseModel = null;
        print("response status code" + response.statusCode.toString());

        print("-------------------------------");
        print(response.body);
      }
    } else {
      _error = true;
      _errorMessage =
          "Error response status code " + response.statusCode.toString();
      _popularRestaurantResponseModel = null;
      print("response status code" + response.statusCode.toString());
      print("-------------------------------");
      print(response.body);
    }
    notifyListeners();
  }

  bool get error => _error;

  String get errorMessage => _errorMessage;

  PopularRestaurantResponseModel? get popularRestaurantResponseModel =>
      _popularRestaurantResponseModel;

  initialize() {
    _error = false;
    _errorMessage = "";
    _popularRestaurantResponseModel = null;
  }
}

class PopularMeatAPIProvider with ChangeNotifier {
  bool _error = false;
  String _errorMessage = "";
  PopularMeatResponseModel? _popularRestaurantResponseModel;

  bool get ifLoading =>
      _error == false && _popularRestaurantResponseModel == null;

  Future<void> getPopularRestaurant(
      {required String lat,
      required String long,
      required String filter,
      required String type,
      required String foodType}) async {
    final uri = Uri.parse(
        "https://chillkrt.in/Mycities/Mycities_food/index.php/api/Api_customer/popular_restaurant");

    final response = await http.post(uri, body: {
      'lat': lat,
      'long': long,
      'filter': filter,
      "type": type,
      "food_type": foodType
    });

    if (response.statusCode == 200) {
      try {
        final jsonResponse = jsonDecode(response.body);
        _popularRestaurantResponseModel =
            new PopularMeatResponseModel.fromJson(jsonResponse);
        print("----------------");
        print("Success executing getPopular Restaurant" +
            response.statusCode.toString());
        print("-------------------------------");
      } catch (e) {
        _error = true;
        _errorMessage =
            "Error response status code " + response.statusCode.toString();
        _popularRestaurantResponseModel = null;
        print("response status code" + response.statusCode.toString());

        print("-------------------------------");
        print(response.body);
      }
    } else {
      _error = true;
      _errorMessage =
          "Error response status code " + response.statusCode.toString();
      _popularRestaurantResponseModel = null;
      print("response status code" + response.statusCode.toString());
      print("-------------------------------");
      print(response.body);
    }
    notifyListeners();
  }

  bool get error => _error;

  String get errorMessage => _errorMessage;

  PopularMeatResponseModel? get popularRestaurantResponseModel =>
      _popularRestaurantResponseModel;

  initialize() {
    _error = false;
    _errorMessage = "";
    _popularRestaurantResponseModel = null;
  }
}

class PopularBakeryAPIProvider with ChangeNotifier {
  bool _error = false;
  String _errorMessage = "";
  PopularBakeryResponseModel? _popularRestaurantResponseModel;

  bool get ifLoading =>
      _error == false && _popularRestaurantResponseModel == null;

  Future<void> getPopularRestaurant(
      {required String lat,
      required String long,
      required String filter,
      required String type,
      required String foodType}) async {
    final uri = Uri.parse(
        "https://chillkrt.in/Mycities/Mycities_food/index.php/api/Api_customer/popular_restaurant");

    final response = await http.post(uri, body: {
      'lat': lat,
      'long': long,
      'filter': filter,
      "type": type,
      "food_type": foodType
    });

    if (response.statusCode == 200) {
      try {
        final jsonResponse = jsonDecode(response.body);
        _popularRestaurantResponseModel =
            new PopularBakeryResponseModel.fromJson(jsonResponse);
        print("----------------");
        print("Success executing getPopular Restaurant" +
            response.statusCode.toString());
        print("-------------------------------");
      } catch (e) {
        _error = true;
        _errorMessage =
            "Error response status code " + response.statusCode.toString();
        _popularRestaurantResponseModel = null;
        print("response status code" + response.statusCode.toString());

        print("-------------------------------");
        print(response.body);
      }
    } else {
      _error = true;
      _errorMessage =
          "Error response status code " + response.statusCode.toString();
      _popularRestaurantResponseModel = null;
      print("response status code" + response.statusCode.toString());
      print("-------------------------------");
      print(response.body);
    }
    notifyListeners();
  }

  bool get error => _error;

  String get errorMessage => _errorMessage;

  PopularBakeryResponseModel? get popularRestaurantResponseModel =>
      _popularRestaurantResponseModel;

  initialize() {
    _error = false;
    _errorMessage = "";
    _popularRestaurantResponseModel = null;
  }
}

class FoodCourtAPIProvider with ChangeNotifier {
  bool _error = false;
  String _errorMessage = "";
  FoodCourtResponseModel? _popularRestaurantResponseModel;

  bool get ifLoading =>
      _error == false && _popularRestaurantResponseModel == null;

  Future<void> getPopularFoodCourt(
      {required String lat,
      required String long,
      required String filter,
      required String type,
      required String foodType}) async {
    final uri = Uri.parse(
        "https://chillkrt.in/Mycities/Mycities_food/index.php/api/Api_customer/popular_restaurant");

    final response = await http.post(uri, body: {
      'lat': lat,
      'long': long,
      'filter': filter,
      "type": type,
      "food_type": foodType
    });

    if (response.statusCode == 200) {
      try {
        final jsonResponse = jsonDecode(response.body);
        _popularRestaurantResponseModel =
            new FoodCourtResponseModel.fromJson(jsonResponse);
        print("----------------");
        print("Success executing getPopular Restaurant" +
            response.statusCode.toString());
        print("-------------------------------");
      } catch (e) {
        _error = true;
        _errorMessage =
            "Error response status code " + response.statusCode.toString();
        _popularRestaurantResponseModel = null;
        print("response status code" + response.statusCode.toString());

        print("-------------------------------");
        print(response.body);
      }
    } else {
      _error = true;
      _errorMessage =
          "Error response status code " + response.statusCode.toString();
      _popularRestaurantResponseModel = null;
      print("response status code" + response.statusCode.toString());
      print("-------------------------------");
      print(response.body);
    }
    notifyListeners();
  }

  bool get error => _error;

  String get errorMessage => _errorMessage;

  FoodCourtResponseModel? get foodCourtResponseModel =>
      _popularRestaurantResponseModel;

  initialize() {
    _error = false;
    _errorMessage = "";
    _popularRestaurantResponseModel = null;
  }
}

// class TakeAwayAPIProvider with ChangeNotifier {
//   String _errorMessage = "";
//   bool _error = false;
//   TakeAwayResponseModel? _takeAwayResponseModel;

//   bool get ifLoading => _error == false && _takeAwayResponseModel == null;

//   Future<void> getOrderHistory(
//       dynamic lat, dynamic long, dynamic promocode) async {
//     Uri url = Uri.parse(
//         "https://chillkrt.in/closetobuy/index.php/api/Api_customer/take_away");

//     final req = await http.post(url, body: {
//       "user_id": ApiServices.userId!,
//       "lat": "$lat",
//       "long": "$long",
//       "promocode": "$promocode"
//     });
//     if (req.statusCode == 200) {
//       try {
//         final jsonResponse = jsonDecode(req.body);
//         _takeAwayResponseModel = TakeAwayResponseModel.fromJson(jsonResponse);
//       } catch (e) {
//         _error = true;
//         _errorMessage = e.toString();
//         _takeAwayResponseModel = null;
//       }
//     } else {
//       _error = true;
//       _errorMessage = "Error from internet ${req.statusCode}";
//       _takeAwayResponseModel = null;
//     }
//     notifyListeners();
//   }

//   String get errorMessage => _errorMessage;

//   bool get error => _error;

//   TakeAwayResponseModel? get orderHistoryResponseModel =>
//       _takeAwayResponseModel;
// }
