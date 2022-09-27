import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Models/PopularCurations.dart';

class PopularCurationAPIProvider with ChangeNotifier {
  String _errorMessage = "";
  bool _error = false;
  PopularCurationsResponseModel? _popularCurationsResponseModel;

  bool get ifLoading =>
      _error == false && _popularCurationsResponseModel == null;

  Future<void> getPopularCuration() async {
    Uri url = Uri.parse(
        "https://chillkrt.in/Mycities/Mycities_food/index.php/api/Api_customer/popular_curations");

    final req = await http.get(url);
    if (req.statusCode == 200) {
      try {
        final jsonResponse = jsonDecode(req.body);
        _popularCurationsResponseModel =
            PopularCurationsResponseModel.fromJson(jsonResponse);
      } catch (e) {
        _error = true;
        _errorMessage = e.toString();
        _popularCurationsResponseModel = null;
      }
    } else {
      _error = true;
      _errorMessage = "Error from internet ${req.statusCode}";
      _popularCurationsResponseModel = null;
    }
    notifyListeners();
  }

  String get errorMessage => _errorMessage;

  bool get error => _error;

  PopularCurationsResponseModel? get popularCurationResponse =>
      _popularCurationsResponseModel;

  initialize() {
    _popularCurationsResponseModel = null;
    _error = false;
    _errorMessage = "";
  }
}
