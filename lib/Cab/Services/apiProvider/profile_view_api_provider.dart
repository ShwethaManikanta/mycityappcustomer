// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:truedriverapp/Models/profile_view_model.dart';
// import 'package:truedriverapp/Services/api_services.dart';
// import 'package:http/http.dart';

// class ProfileViewAPIProvider with ChangeNotifier {
//   bool _error = false;
//   String _errorMessage = "";
//   ProfileViewRespones? _profileViewRespones;

//   Future<void> fetchData() async {
//     final uri = Uri.parse(
//         "https://chillkrt.in/garudaayan/index.php/Api_customer/profile");
//     final response = await post(uri, body: {"user_id": ApiServices.userId});

//     if (response.statusCode == 200) {
//       try {
//         final jsonResponse = jsonDecode(response.body);
//         _profileViewRespones = ProfileViewRespones.fromJson(jsonResponse);
//       } catch (e) {
//         _error = false;
//         _errorMessage = e.toString();
//         _profileViewRespones = null;
//       }
//     } else {
//       _error = false;
//       _errorMessage =
//           "Error with response code " + response.statusCode.toString();
//       _profileViewRespones = null;
//     }
//     notifyListeners();
//   }

//   bool get error => _error;

//   String get errorMessage => _errorMessage;

//   ProfileViewRespones? get profileViewResponse => _profileViewRespones;

//   bool get ifLoading => _error == false && _profileViewRespones == null;
// }
