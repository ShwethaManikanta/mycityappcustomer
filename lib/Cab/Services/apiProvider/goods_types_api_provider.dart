import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mycityapp/Cab/Models/goods_type.dart';

class ListGoodTypeAPIProvider with ChangeNotifier {
  bool _error = false;
  String _errorMessage = "";
  GoodTypeResponseModel? _goodTypeResponseModel;

  Future<void> fetchData() async {
    final uri = Uri.parse(
        "http://chillkrt.in/True_drivers_admin/index.php/Api_customer/category_list");
    final response = await get(uri);

    if (response.statusCode == 200) {
      try {
        final jsonResponse = jsonDecode(response.body);
        _goodTypeResponseModel = GoodTypeResponseModel.fromJson(jsonResponse);
      } catch (e) {
        _error = false;
        _errorMessage = e.toString();
        _goodTypeResponseModel = null;
      }
    } else {
      _error = false;
      _errorMessage =
          "Error with response code " + response.statusCode.toString();
      _goodTypeResponseModel = null;
    }
    notifyListeners();
  }

  bool get error => _error;

  String get errorMessage => _errorMessage;

  GoodTypeResponseModel? get goodsTypeResponseModel => _goodTypeResponseModel;

  bool get ifLoading => _error == false && _goodTypeResponseModel == null;
}
