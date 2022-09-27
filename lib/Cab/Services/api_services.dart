import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:mycityapp/Cab/Models/profile_model.dart';
import 'package:mycityapp/Cab/Models/track_driver_model.dart';

import '../Models/order_specific_model.dart';

ApiServices apiServices = ApiServices();

class ApiServices {
  static String? userId;

  Future<OrderAcceptRejectResponse?> cancelOrder(
      {required String orderId, required String status}) async {
    var url = Uri.parse(
        'https://chillkrt.in/True_drivers_admin/index.php/Api_customer/cancel_order');
    Response response = await post(url, body: {'order_id': orderId});
    var jsonResponse = jsonDecode(response.body);
    Fluttertoast.showToast(
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        textColor: Colors.green.shade900,
        backgroundColor: Colors.white,
        msg: jsonResponse['message']);
    OrderAcceptRejectResponse? orderAcceptRejectResponse;
    if (response.statusCode == 200) {
      return orderAcceptRejectResponse =
          OrderAcceptRejectResponse.fromMap(jsonResponse);
    }
    return orderAcceptRejectResponse;
  }

  Future<OrderSpecificModel?> orderSpecific({required String orderId}) async {
    String url =
        "https://chillkrt.in/True_drivers_admin/index.php/Api_customer/get_spacific_order";
    var postUri = Uri.parse(url);
    final response = await post(postUri, body: {"order_id": orderId});
    print("Track Order" + response.body);
    var jsonResponse = jsonDecode(response.body);

    final orderSpecificModel = OrderSpecificModel.fromJson(jsonResponse);

    return orderSpecificModel;
  }

  Future<TrackDriverModel?> trackOrder({required String orderId}) async {
    String url =
        "https://chillkrt.in/True_drivers_admin/index.php/Api_customer/track_details";
    var postUri = Uri.parse(url);
    final response = await post(postUri, body: {"order_id": orderId});
    print("Track Order" + response.body);
    var jsonResponse = jsonDecode(response.body);

    final orderTrackModel = TrackDriverModel.fromJson(jsonResponse);

    return orderTrackModel;
  }

  Future<bool> updateProfile(
      {String userName = "",
      String userPhoneNumber = "",
      String userEmail = ""}) async {
    final url = Uri.parse(
        "http://chillkrt.in/True_drivers_admin/index.php/Api_customer/profile_update");
    Response response = await post(url, body: {
      'user_id': userId,
      'mobile': userPhoneNumber,
      'user_name': userName,
      'email': userEmail
    });
    if (response.statusCode == 200) {
      try {
        var jsonResponse = jsonDecode(response.body);
        if (jsonResponse['status'] == "1") {
          return true;
        }
      } catch (e) {
        print(e.toString());
        return false;
      }
      return true;
    } else {
      return false;
    }
  }

/*  Future<void> otpRequest(OtpRequest otpRequest) async {
    var url =
        Uri.parse('https://goeasydocabs.com/logistics/admin_new/api/send_otp');
    Response response = await post(url, body: otpRequest.toJson());
    var jsonResponse = jsonDecode(response.body);
    Fluttertoast.showToast(
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        textColor: Colors.green.shade900,
        backgroundColor: Colors.white,
        msg: jsonResponse['message']);
    Fluttertoast.showToast(
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        textColor: Colors.green.shade900,
        backgroundColor: Colors.white,
        msg: jsonResponse['data']['otp']);

    print(jsonResponse);
  }
  // ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,

  Future<void> resentOtpRequest(ResentOtpRequest resentOtpRequest) async {
    var url = Uri.parse(
        'https://goeasydocabs.com/logistics/admin_new/api/resend_otp');
    Response response = await post(url, body: resentOtpRequest.toJson());
    var jsonResponse = jsonDecode(response.body);
    Fluttertoast.showToast(
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        textColor: Colors.green.shade900,
        backgroundColor: Colors.white,
        msg: jsonResponse['message']);
    Fluttertoast.showToast(
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        textColor: Colors.green.shade900,
        backgroundColor: Colors.white,
        msg: jsonResponse['data']['otp']);

    print(jsonResponse);
  }
  // ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,

  Future<LoginRespones?> loginRequest(LoginRequest loginRequest) async {
    var url =
        Uri.parse('https://goeasydocabs.com/logistics/admin_new/api/login');
    Response response = await post(url, body: loginRequest.toJson());
    var jsonResponse = jsonDecode(response.body);
    Fluttertoast.showToast(
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        textColor: Colors.green.shade900,
        backgroundColor: Colors.white,
        msg: jsonResponse['message']);
    LoginRespones? loginRespones;
    if (jsonResponse['errorCode'] == "200") {
      loginRespones = LoginRespones.fromMap(jsonResponse);
    }
    print(jsonResponse);
    return loginRespones;
  }
  // ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,*/

  Future<ProfileRespones?> profile(ProfileRequesst profileRequesst) async {
    String url =
        "https://chillkrt.in/True_drivers_admin/index.php/Api_customer/profile_update";
    var postUri = Uri.parse(url);
    var request = new MultipartRequest("POST", postUri);
    request.fields['name'] = profileRequesst.name;
    request.fields['email'] = profileRequesst.email;
    request.fields['user_id'] = profileRequesst.userid;
    request.files.add(
      await MultipartFile.fromPath(
        'file_name',
        profileRequesst.filename,
      ),
    );
    StreamedResponse response = await request.send();
    String value = await response.stream.bytesToString();
    print(value);
    var jsonResponse = jsonDecode(value);
    Fluttertoast.showToast(
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        textColor: Colors.green.shade900,
        backgroundColor: Colors.white,
        msg: jsonResponse['message']);
    ProfileRespones? profileRespones;
    if (jsonResponse['errorCode'] == "200") {
      profileRespones = ProfileRespones.fromMap(jsonResponse['message']);
    }
    return profileRespones;
  }

/*  // ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
  Future<ProfileViewRespones?> profileViewRequest(
      ProfileViewRequest profileViewRequest) async {
    var url = Uri.parse(
        'https://goeasydocabs.com/logistics/admin_new/api/view_profile');
    Response response = await post(url, body: profileViewRequest.toJson());
    var jsonResponse = jsonDecode(response.body);
    Fluttertoast.showToast(
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        textColor: Colors.green.shade900,
        backgroundColor: Colors.white,
        msg: jsonResponse['message']);
    ProfileViewRespones? profileViewRespones;
    if (jsonResponse['errorCode'] == "200") {
      profileViewRespones = ProfileViewRespones.fromMap(jsonResponse);
    }
    print(jsonResponse);
    return profileViewRespones;
  }
  // ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,*/

}

class OrderAcceptRejectResponse {
  late String status, message;

  OrderAcceptRejectResponse({required this.status, required this.message});

  OrderAcceptRejectResponse.fromMap(Map<String, dynamic> jsonResponse) {
    status = jsonResponse['status'];
    message = jsonResponse['message'];
  }
}
