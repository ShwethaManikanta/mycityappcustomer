import 'dart:convert';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:mycityapp/Cab/Services/api_services.dart';
import 'package:mycityapp/Food/Models/RestaurantViewModel.dart';
import 'package:mycityapp/Food/Services/ApiServices.dart';

class RestaurantDetailsAPIProvider with ChangeNotifier {
  bool _error = false;
  String _errorMessage = "";
  RestaurantViewModel? _restaurantViewModel;

  bool get ifLoading => _error == false && _restaurantViewModel == null;

  Future<void> getRestaurantDetails(
      String outletId, String long, String lati, String resType) async {
    Uri url = Uri.parse(
        "https://chillkrt.in/Mycities/Mycities_food/index.php/api/Api_customer/restaurant_details");

    final response = await post(url, body: {
      'outlet_id': outletId,
      'lat': lati,
      'long': long,
      'res_type': resType,
      'user_id': ApiServices.userId,
    });
    print("response status code" + response.statusCode.toString());

    print("-------------------------------");
    print(response.body);

    if (response.statusCode == 200) {
      try {
        final jsonResponse = jsonDecode(response.body);
        _restaurantViewModel = RestaurantViewModel.fromJson(jsonResponse);
        print("--------------------");
        print("Restaurant Details API execution success");
        print("----------------------------------------");
      } catch (e) {
        _error = true;
        _errorMessage = e.toString();
        _restaurantViewModel = null;
        print("--------------------");
        print("Restaurant Details API execution failed");
        print(e.toString());

        print("----------------------------------------");
      }
    } else {
      _error = true;
      _errorMessage = "Response Code " + response.statusCode.toString();
      _restaurantViewModel = null;
      print("--------------------");
      print("Restaurant Details API execution failed");
      print("----------------------------------------");
    }
    notifyListeners();
  }

  bool get error => _error;

  String get errorMessage => _errorMessage;

  RestaurantViewModel? get restaurantViewModel => _restaurantViewModel;

  initialize() {
    _error = false;
    _restaurantViewModel = null;
    _errorMessage = "";
  }
}
