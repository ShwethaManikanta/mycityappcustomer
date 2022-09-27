import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mycityapp/Cab/Services/api_services.dart';
import 'package:mycityapp/Food/CommonWidgets/common_styles.dart';
import 'package:mycityapp/Food/CommonWidgets/utils.dart';
import 'package:mycityapp/Food/Models/AddOnViewModel.dart';
import 'package:mycityapp/Food/Models/CartList.dart';
import 'package:mycityapp/Food/Models/DishesList.dart';
import 'package:mycityapp/Food/Models/OnboardingBannerModel.dart';
import 'package:mycityapp/Food/Models/OngoingOrderModel.dart';
import 'package:mycityapp/Food/Models/OrderDetails.dart';
import 'package:mycityapp/Food/Models/OrderHistory.dart';
import 'package:mycityapp/Food/Models/PaymentOffersModel.dart';
import 'package:mycityapp/Food/Models/PopularCuraionViewModel.dart';
import 'package:mycityapp/Food/Models/PopularCurations.dart';
import 'package:mycityapp/Food/Models/PopularDishModel.dart';
import 'package:mycityapp/Food/Models/PopularRestaurantModel.dart';
import 'package:mycityapp/Food/Models/RestaurantViewModel.dart';
import 'package:mycityapp/Food/Models/TakeAwayModel.dart';
import 'package:mycityapp/Food/Models/TopOffersModel.dart';
import 'package:mycityapp/Food/Models/UserModel.dart';
import 'package:mycityapp/Food/Models/newcartmodel.dart';
import 'package:mycityapp/Food/Models/place_order_model.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../pages/utils/loaction_shared_preference.dart';
import 'cart_api_provider.dart';

ApiService apiService = ApiService();

class ApiService {
  final String baseUrl =
      "https://chillkrt.in/Mycities/Mycities_food/index.php/api/Api_customer";

  static late SharedPreferences sharedPreferences;
  // static List<String?>? banners;
  // static List<String?>? bottombanners;
//  static String userId = ApiServices.userId;

  // static late List<OnboardingBannerModel> onboardingBanners;
  // static List<OnboardingBannerModel>? offerbanners;
  // static List<OnboardingBannerModel>? meatbanners;

  static String? userdata;
  static List<UserModel>? usermodel;
  static List<TakeAwayModel>? takeAways;
  static List<TopOfferModel>? topOffers;
  static List<OrderHistory>? orderHistories;
  static List<PopularRestaurantModel>? popularRestaurants;
  static List<PopularCurationViewModel>? popularCurationsView;
  static List<PopularCurationViewModel>? offerBasedList;
  static List<TakeAwayModel>? searchDatas;
  static List<ProductList>? searchRestaurantDatas;

  static PopularCurationsResponseModel? popularCurations;

  static List<PopularDishModel>? popularDishs;
  static List<ProductPopularDishModel>? productpopularDishs;

  static List<DishesList>? dishesList;
  static List<DishesList>? beveragesList;

  static List<ProductPopularDishModel>? proPopulardishes;
  static RestaurantViewModel? restaurantViewModel;
  static List<ProductList>? productList;
  static List<BrowseMenu>? browsemenu;

  static List<AddOnData>? addonproductList;

  static List<CategoryMenuModel>? categoryMenu;

  static List<Retailerlist>? retailerList;
  static List<ProductCartList>? productcartList;
  static List<RetailerCartlist>? retailercartList;
  static UserModel? getAllAddress;

  // static UserModel? user;
  // static LoginResponse? user;
  static dynamic deliveryfee;
  static dynamic subtotal;
  static dynamic taxes;
  static dynamic discountAmount;
  static dynamic promocodeused;

  static dynamic totalAmount;

  static dynamic totalCartAmount;

  static dynamic discountAmountRange;
  Map<String, dynamic>? addtoCart;

  // Future<void> getBanners() async {
  //   Uri url = Uri.parse("$baseUrl/bannerList");
  //   Response response = await post(url);
  //   var jsonResponse = jsonDecode(response.body);
  //   List<String?> _banners = [];
  //   for (var item in jsonResponse["topBanner"]) {
  //     _banners.add(item["banner_image"]);
  //   }
  //   banners = _banners;
  // }

  Future<void> rating(
    BuildContext context,
    dynamic outlet_id,
    dynamic rank,
    dynamic description,
  ) async {
    Uri url = Uri.parse("$baseUrl/addrating");
    var request = MultipartRequest('POST', url);
    request.fields.addAll({
      "outlet_id": "$outlet_id",
      "user_id": ApiServices.userId!,
      "rank": "$rank",
      "description": "$description",
    });
    var response = await request.send();
    final respStr = await response.stream.bytesToString();
    var jsonResponse = jsonDecode(respStr);
    if (jsonResponse["status"] == "1") {
      Fluttertoast.showToast(
          msg: jsonResponse["message"], toastLength: Toast.LENGTH_SHORT);
    }
    return jsonResponse;
  }

  // Future<void> offerBanners() async {
  //   Uri url = Uri.parse("$baseUrl/offer_banner_list");
  //   Response response = await post(url);
  //   var jsonResponse = jsonDecode(response.body);
  //   List<OnboardingBannerModel> _offerbanners = [];
  //   for (var item in jsonResponse["offerBanner"]) {
  //     _offerbanners.add(OnboardingBannerModel.fromMap(item));
  //   }
  //   offerbanners = _offerbanners;
  // }

  // Future<void> meatBanners() async {
  //   Uri url = Uri.parse("$baseUrl/meat_banner_list");
  //   Response response = await post(url);
  //   var jsonResponse = jsonDecode(response.body);
  //   List<OnboardingBannerModel> _meatbanners = [];
  //   for (var item in jsonResponse["meatBanner"]) {
  //     _meatbanners.add(OnboardingBannerModel.fromMap(item));
  //   }
  //   meatbanners = _meatbanners;
  // }

  // Future<void> getBottomBanners() async {
  //   Uri url = Uri.parse("$baseUrl/bottom_bannerList");
  //   Response response = await post(url);
  //   var jsonResponse = jsonDecode(response.body);
  //   List<String?> _bottombanners = [];
  //   for (var item in jsonResponse["bottomBanner"]) {
  //     _bottombanners.add(item["banner_image"]);
  //   }
  //   bottombanners = _bottombanners;
  // }

  // Future<void> getOnboardingBanners() async {
  //   Uri url = Uri.parse("$baseUrl/front_banner_list");
  //   Response response = await post(url);
  //   var jsonResponse = jsonDecode(response.body);
  //   List<OnboardingBannerModel> _onboardingBanners = [];
  //   for (var item in jsonResponse["topBanner"]) {
  //     _onboardingBanners.add(OnboardingBannerModel.fromMap(item));
  //   }
  //   onboardingBanners = _onboardingBanners;
  // }

  Future<Map<String, dynamic>> register(mobile, email, userName, password,
      deviceToken, address, dynamic lat, dynamic long) async {
    Uri url = Uri.parse("$baseUrl/reg");
    var request = MultipartRequest('POST', url);
    request.fields.addAll({
      "mobile": mobile,
      "email": email,
      "user_name": userName,
      "password": password,
      "device_token": deviceToken,
      "address": address,
      "lat": "$lat",
      "long": "$long",
      "device_type": 'customer_app',
    });
    var response = await request.send();
    final respStr = await response.stream.bytesToString();
    var jsonResponse = jsonDecode(respStr);
    if (jsonResponse["status"] == "1") {
      return {
        "status": true,
        "msg": "",
      };
    } else {
      return {
        "status": false,
        "msg": jsonResponse["message"],
      };
    }
  }

  Future<UserApi> fetchAlbum() async {
    final response = await http.post(
        Uri.parse(
            'https://chillkrt.in/Mycities/Mycities_food/index.php/api/Api_customer/profile'),
        body: {"user_id": ApiServices.userId});

    if (response.statusCode == 200) {
      return UserApi.fromMap(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  // Future<OngoingOrderResponseModel> ongoingOrderApi() async {
  //   final response = await http.post(
  //       Uri.parse(
  //           'https://chillkrt.in/closetobuy/index.php/api/Api_customer/order_ongoing'),
  //       body: {"user_id": ApiServices.userId});

  //   if (response.statusCode == 200) {
  //     return OngoingOrderResponseModel.fromJson(jsonDecode(response.body));
  //   } else {
  //     throw Exception('Failed to load album');
  //   }
  // }

  Future checkAddress(dynamic lat, dynamic long) async {
    Uri url = Uri.parse("$baseUrl/check_address");
    var request = MultipartRequest('POST', url);
    request.fields.addAll({
      "user_id": ApiServices.userId!,
      "lat": "$lat",
      "long": "$long",
    });
    var response = await request.send();
    final respStr = await response.stream.bytesToString();
    var jsonResponse = jsonDecode(respStr);
    if (jsonResponse["status"] == "1") {
      return {
        "status": true,
        "msg": jsonResponse["message"],
      };
    } else {
      return {
        "status": false,
        "msg": jsonResponse["message"],
      };
    }
  }

  Future<String> updateFirebaseId(
      {required String firebaseId,
      required String name,
      required email}) async {
    Uri url = Uri.parse(
        'https://chillkrt.in/Mycities/Mycities_food/index.php/api/Api_customer/firebaseid_update');
    String? result;
    final request = await http.post(url, body: {
      'firebase_id': firebaseId,
      'user_id': ApiServices.userId,
      'name': name,
      'email': email
    });
    if (request.statusCode == 200) {
      try {
        final jsonResponse = jsonDecode(request.body);
        result = jsonResponse['status'];
      } catch (e) {
        throw e;
      }
    }
    return result!;
  }

  Future editSearchAddress(
      {required String type,
      required dynamic address,
      required dynamic land_mark,
      required dynamic floor,
      required dynamic reach,
      dynamic lat,
      dynamic long}) async {
    Uri url = Uri.parse("$baseUrl/edit_search_address");
    var request = MultipartRequest('POST', url);
    request.fields.addAll({
      "user_id": ApiServices.userId!,
      "type": type,
      "address": address,
      "land_mark": land_mark,
      "floor": floor,
      "reach": reach,
      "lat": "$lat",
      "long": "$long"
    });
    print("lat +${lat}");
    print("long +${long}");
    var response = await request.send();
    final respStr = await response.stream.bytesToString();
    var jsonResponse = jsonDecode(respStr);
    print("paramjsonResponse +${jsonResponse}");
    if (jsonResponse["status"] == "1") {
      return {
        "status": true,
        "msg": jsonResponse["message"],
      };
    } else {
      return {
        "status": false,
        "msg": jsonResponse["message"],
      };
    }
  }

  // Future editSearchAddress(param) async {
  //   print("param +${param}");
  //   final response = await http.post(Uri.parse("$baseUrl/edit_search_address"), body: {param});
  //   print("paramresponse +${response}");
  //   print("statusCode +${response.statusCode}");
  //
  //   if (response.statusCode == 200) {
  //     return response;
  //   } else {
  //     throw Exception('Failed to load album');
  //   }
  // }

  Future selectAddress(String? typeId) async {
    Uri url = Uri.parse("$baseUrl/address_type_update");
    var request = MultipartRequest('POST', url);
    request.fields.addAll({"user_id": ApiServices.userId!, "type": "$typeId"});
    var response = await request.send();
    final respStr = await response.stream.bytesToString();
    var jsonResponse = jsonDecode(respStr);
    if (jsonResponse["status"] == "1") {
      return {
        "status": true,
        "msg": "",
      };
    } else {
      return {
        "status": false,
        "msg": jsonResponse["message"],
      };
    }
  }

  Future<void> getTopOffers(
    dynamic lat,
    dynamic long,
  ) async {
    Uri url = Uri.parse("$baseUrl/top_offers");
    var request = MultipartRequest('POST', url);
    request.fields.addAll({
      "lat": "$lat",
      "long": "$long",
    });
    var response = await request.send();
    final respStr = await response.stream.bytesToString();
    var jsonResponse = jsonDecode(respStr);
    List<TopOfferModel> _topOffers = [];
    for (var item in jsonResponse["top_offers"]) {
      _topOffers.add(TopOfferModel.fromMap(item));
    }
    topOffers = _topOffers;
  }

  Future<void> getPopularRestaurants(
      dynamic lat, dynamic long, int filter) async {
    Uri url = Uri.parse("$baseUrl/popular_restaurant");
    var request = MultipartRequest('POST', url);
    request.fields
        .addAll({"lat": "27.2046", "long": "77.4977", "filter": "$filter"});

    var response = await request.send();
    final respStr = await response.stream.bytesToString();
    var jsonResponse = jsonDecode(respStr);
    if (jsonResponse['status'] == "1") {
      List<PopularRestaurantModel> _popularRestaurants = [];
      for (var item in jsonResponse["newArrival"]) {
        _popularRestaurants.add(PopularRestaurantModel.fromMap(item));
      }
      popularRestaurants = _popularRestaurants;
    } else {}
  }

  Future<void> popluarcurationlist() async {
    Uri url = Uri.parse("$baseUrl/popular_curations");
    var request = MultipartRequest('POST', url);
    request.fields.addAll({});

    var response = await request.send();
    final respStr = await response.stream.bytesToString();
    var jsonResponse = jsonDecode(respStr);
    if (jsonResponse['status'] == "1") {
      PopularCurationsResponseModel _popularCurations =
          PopularCurationsResponseModel.fromJson(jsonResponse);
      // for (var item in jsonResponse["category_list"]) {
      //   _popularCurations.add();
      // }
      popularCurations = _popularCurations;
    } else {}
  }

  Future<void> popluarcuration(
      dynamic lat, dynamic long, dynamic categoryId) async {
    Uri url = Uri.parse("$baseUrl/popular_curation_res");

    var request = MultipartRequest('POST', url);
    request.fields
        .addAll({"lat": "$lat", "long": "$long", "category_id": "$categoryId"});

    var response = await request.send();

    final respStr = await response.stream.bytesToString();
    var jsonResponse = jsonDecode(respStr);

    if (jsonResponse['status'] == "1") {
      List<PopularCurationViewModel> _popularCurationsView = [];
      for (var item in jsonResponse["newArrival"]) {
        _popularCurationsView.add(PopularCurationViewModel.fromMap(item));
      }
      popularCurationsView = _popularCurationsView;
    } else {}
  }

  Future searchData(
      dynamic lat, dynamic long, dynamic search_key, dynamic filter) async {
    print("filter vale +${filter}");
    Uri url = Uri.parse("$baseUrl/search_data");

    var request = MultipartRequest('POST', url);
    request.fields.addAll({
      "lat": "$lat",
      "long": "$long",
      "searck_key": "$search_key",
      "type": "1",
      "filter": '$filter'
    });

    var response = await request.send();

    final respStr = await response.stream.bytesToString();
    var jsonResponse = jsonDecode(respStr);
    print("day1");

    if (jsonResponse['status'] == "1") {
      print("day2");
      List<TakeAwayModel> _searchdata = [];
      for (var item in jsonResponse["take_away"]) {
        print("day3");
        _searchdata.add(TakeAwayModel.fromMap(item));
      }
      searchDatas = _searchdata;
      print("day4");
    }
  }

  Future searchRestaurantData(
      dynamic lat, dynamic long, dynamic search_key, dynamic outlet_id) async {
    Uri url = Uri.parse("$baseUrl/search_dish");

    var request = MultipartRequest('POST', url);
    request.fields.addAll({
      "lat": "$lat",
      "long": "$long",
      "searck_key": "$search_key",
      "outlet_id": "$outlet_id"
    });

    var response = await request.send();

    final respStr = await response.stream.bytesToString();
    var jsonResponse = jsonDecode(respStr);
    if (jsonResponse['status'] == "1") {
      List<ProductList> _searchdata = [];
      for (var item in jsonResponse["search_menu"]) {
        _searchdata.add(ProductList.fromJson(item));
      }
      searchRestaurantDatas = _searchdata;
      print("searchRestaurantDatas + $searchRestaurantDatas");
    }
  }

  Future<void> offerbasedlistUrl(dynamic lat, dynamic long, dynamic offerLimit,
      dynamic filter, dynamic id) async {
    Uri url = Uri.parse("$baseUrl/offer_restaurant_list");

    var request = MultipartRequest('POST', url);
    request.fields.addAll({
      "lat": "$lat",
      "long": "$long",
      "offer_limit": "$offerLimit",
      "filter": "$filter",
      "id": "$id"
    });

    var response = await request.send();

    final respStr = await response.stream.bytesToString();
    var jsonResponse = jsonDecode(respStr);

    if (jsonResponse['status'] == "1") {
      List<PopularCurationViewModel> _offerbasedlist = [];
      for (var item in jsonResponse["newArrival"]) {
        _offerbasedlist.add(PopularCurationViewModel.fromMap(item));
      }
      offerBasedList = _offerbasedlist;
    } else {}
  }

  Future<void> getPopularDishes(
    dynamic lat,
    dynamic long,
  ) async {
    Uri url = Uri.parse("$baseUrl/popular_dishes_near");
    var request = MultipartRequest('POST', url);
    request.fields.addAll({
      "lat": "$lat",
      "long": "$long",
    });

    var response = await request.send();
    final respStr = await response.stream.bytesToString();
    var jsonResponse = jsonDecode(respStr);
    List<PopularDishModel> _popularDishs = [];
    List<ProductPopularDishModel> _productpopularDishs = [];

    for (var item in jsonResponse["newArrival"]) {
      _popularDishs.add(PopularDishModel.fromMap(item));
    }
    popularDishs = _popularDishs;
    // for (var item in jsonResponse["productList"]) {
    //   print("item + ${item}");
    //   _productpopularDishs.add(ProductPopularDishModel.fromMap(item));
    // }
    // productpopularDishs = _productpopularDishs;
  }

  Future<void> getDishesList(
    dynamic lat,
    dynamic long,
  ) async {
    Uri url = Uri.parse("$baseUrl/dishes_list");
    var request = MultipartRequest('POST', url);
    request.fields.addAll({
      "lat": "$lat",
      "long": "$long",
    });
    var response = await request.send();
    final respStr = await response.stream.bytesToString();
    var jsonResponse = jsonDecode(respStr);
    List<DishesList> _dishesList = [];

    for (var item in jsonResponse["newArrival"]) {
      _dishesList.add(DishesList.fromMap(item));
    }
    dishesList = _dishesList;
  }

  Future<void> beverages(
    dynamic lat,
    dynamic long,
  ) async {
    Uri url = Uri.parse("$baseUrl/beverages_list");

    var request = MultipartRequest('POST', url);
    request.fields.addAll({
      "lat": "$lat",
      "long": "$long",
    });
    var response = await request.send();
    final respStr = await response.stream.bytesToString();
    var jsonResponse = jsonDecode(respStr);
    List<DishesList> _beveragesList = [];

    for (var item in jsonResponse["newArrival"]) {
      _beveragesList.add(DishesList.fromMap(item));
    }
    beveragesList = _beveragesList;
  }

  Future<Response> editProfile(param) async {
    final response =
        await http.post(Uri.parse("$baseUrl/profile_update"), body: param);

    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<PaymentOfferModel> paymentcoupon(String total_price) async {
    final response = await http.post(
        Uri.parse(
          "$baseUrl/payment_coupon",
        ),
        body: {"user_id": ApiServices.userId!, "total_price": "$total_price"});
    if (response.statusCode == 200) {
      return PaymentOfferModel.fromMap(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<Response> editAddress(param) async {
    final response = await http.post(
        Uri.parse(
            'https://chillkrt.in/Mycities/Mycities_food/index.php/api/Api_customer/address_update'),
        body: param);

    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<LoginResponse> logIn(
    String fierbaseUID,
    String deviceToken,
  ) async {
    Uri url = Uri.parse("$baseUrl/login");
    var request = MultipartRequest('POST', url);
    request.fields.addAll({
      "user_fid": fierbaseUID,
      "device_token": deviceToken,
    });
    var response = await request.send();
    final respStr = await response.stream.bytesToString();
    var jsonResponse = jsonDecode(respStr);
    return LoginResponse.fromJson(jsonResponse);
    // if (jsonResponse["status"] == "1") {
    //   userId = jsonResponse["driver_details"]['id'];
    //   return {
    //     "status": true,
    //     "msg": "",
    //   };
    // } else {
    //   return {
    //     "status": false,
    //     "msg": jsonResponse["message"],
    //   };
    // }
  }

  Future<Map<String, dynamic>> getOtp(
    String mobileNumber,
  ) async {
    Uri url = Uri.parse("$baseUrl/forgotPassword");
    var request = MultipartRequest('POST', url);
    request.fields.addAll({
      "mobile_no": mobileNumber,
    });
    var response = await request.send();
    final respStr = await response.stream.bytesToString();
    var jsonResponse = jsonDecode(respStr);
    if (jsonResponse["status"] == "1") {
      return {
        "status": true,
        "message": jsonResponse["message"],
        "otp": jsonResponse["otp"],
        "user_id": jsonResponse["user_id"],
      };
    } else {
      return {
        "status": false,
        "msg": jsonResponse["message"],
        "otp": "",
        "user_id": "",
      };
    }
  }

  Future<void> orderHistory() async {
    Uri url = Uri.parse("$baseUrl/order_history");
    var request = MultipartRequest('POST', url);
    request.fields.addAll({
      "user_id": ApiServices.userId!,
    });
    var response = await request.send();
    final respStr = await response.stream.bytesToString();
    var jsonResponse = jsonDecode(respStr);
    List<OrderHistory> _orderHistory = [];
    for (var item in jsonResponse["order_history"]) {
      print("sattt1");
      _orderHistory.add(OrderHistory.fromJson(item));
      print("sattt2");
    }
    orderHistories = _orderHistory;
  }

  Future<Map<String, dynamic>> resetPassword(
    String userId,
    String password,
  ) async {
    Uri url = Uri.parse("$baseUrl/changepassword");
    var request = MultipartRequest('POST', url);
    request.fields.addAll({
      "user_id": userId,
      "new_password": password,
    });
    var response = await request.send();
    final respStr = await response.stream.bytesToString();
    var jsonResponse = jsonDecode(respStr);
    if (jsonResponse["status"] == "1") {
      return {
        "status": true,
        "msg": jsonResponse["message"],
      };
    } else {
      return {
        "status": false,
        "msg": jsonResponse["message"],
      };
    }
  }

  Future<Map<String, dynamic>> placeOrder(
      PlaceOrderRequestModel placeOrderRequestModel) async {
    Uri url = Uri.parse("$baseUrl/buyproduct");
    var request = MultipartRequest('POST', url);
    request.fields.addAll(placeOrderRequestModel.toMap());
    var response = await request.send();
    final respStr = await response.stream.bytesToString();
    var jsonResponse = jsonDecode(respStr);
    if (jsonResponse["status"] == "1") {
      // Toast.show(
      //   jsonResponse['message'],
      //   context,
      //   duration: 1,
      // );
      return {
        "status": true,
        "msg": jsonResponse["message"],
      };
    } else {
      return {
        "status": false,
        "msg": jsonResponse["message"],
      };
    }
  }

  Future<Map<String, dynamic>> buyProduct(
    BuildContext context,
    String? item_total,
    String? delivery_fee,
    String? taxes,
    String topay,
    String? address,
    String? outlet_id,
    dynamic lat,
    dynamic long,
  ) async {
    Uri url = Uri.parse("$baseUrl/buyproduct");
    var request = MultipartRequest('POST', url);
    request.fields.addAll({
      "user_id": ApiServices.userId!,
      "item_total": "$item_total",
      "delivery_fee": "$delivery_fee",
      "taxes": "$taxes",
      "to pay": "$topay",
      "address": "$address",
      "lat": "$lat",
      "long": '$long',
      "outlet_id": "$outlet_id",
    });
    var response = await request.send();
    final respStr = await response.stream.bytesToString();
    var jsonResponse = jsonDecode(respStr);
    if (jsonResponse["status"] == "1") {
      // Toast.show(
      //   jsonResponse['message'],
      //   context,
      //   duration: 1,
      // );
      return {
        "status": true,
        "msg": jsonResponse["message"],
      };
    } else {
      return {
        "status": false,
        "msg": jsonResponse["message"],
      };
    }
  }

  // Future<void> getTakeAway(
  //   dynamic lat,
  //   dynamic long,
  //   String searchkey,
  // ) async {
  //   Uri url = Uri.parse("$baseUrl/take_away");
  //   var request = MultipartRequest('POST', url);
  //   request.fields.addAll({
  //     "lat": "$lat",
  //     "long": "$long",
  //     "searck_key": "$searchkey",
  //   });

  //   var response = await request.send();
  //   final respStr = await response.stream.bytesToString();
  //   var jsonResponse = jsonDecode(respStr);
  //   List<TakeAwayModel> _takeAways = [];
  //   for (var item in jsonResponse["newArrival"]) {
  //     _takeAways.add(TakeAwayModel.fromMap(item));
  //   }
  //   takeAways = _takeAways;
  // }

  Future getRestaurantDetail(
      String? outlet_id, dynamic lat, dynamic long, String restype) async {
    Uri url = Uri.parse(
        "https://chillkrt.in/Mycities/Mycities_food/index.php/api/Api_customer/restaurant_details");
    var request = MultipartRequest('POST', url);
    request.fields.addAll({
      "outlet_id": "$outlet_id",
      "lat": "$lat",
      "long": "$long",
      "res_type": "3",
      "user_id": ApiServices.userId!
    });
    var response = await request.send();
    final respStr = await response.stream.bytesToString();
    var jsonResponse = jsonDecode(respStr);
    print("THe body ---- --" + jsonResponse.toString());
    List<ProductList> _productList = [];
    List<BrowseMenu> _browseMenu = [];
    List<Retailerlist> _retailerlist = [];
    List<CategoryMenuModel> _categorymodel = [];
    for (var item in jsonResponse['product_list']) {
      _productList.add(ProductList.fromJson(item));
    }
    productList = _productList;
    for (var item in jsonResponse['category_menu']) {
      print("--------  " + item.toString());
      _categorymodel.add(CategoryMenuModel.fromJson(item));
      // print("----" + CategoryMenuModel.fromMap(item).toString());
    }
    categoryMenu = _categorymodel;
    for (var item in jsonResponse['browse_menu']) {
      _browseMenu.add(BrowseMenu.fromJson(item));
    }
    browsemenu = _browseMenu;
    for (var item in jsonResponse['retailerlist']) {
      _retailerlist.add(Retailerlist.fromJson(item));
    }
    retailerList = _retailerlist;
  }

  Future addonDetails(
    String? menu_id,
  ) async {
    Uri url = Uri.parse(
        "https://chillkrt.in/Mycities/Mycities_food/index.php/api/Api_customer/list_adon_details");
    var request = MultipartRequest('POST', url);
    request.fields.addAll({
      "menu_id": "${menu_id}",
    });

    var response = await request.send();
    final respStr = await response.stream.bytesToString();
    var jsonResponse = jsonDecode(respStr);
    List<AddOnData> _addonproductList = [];
    if (jsonResponse['status'] == "1") {
      for (var item in jsonResponse['adon_list']) {
        _addonproductList.add(AddOnData.fromJson(item));
      }
      addonproductList = _addonproductList;
      return addonproductList;
    }
  }

  Future<CartResponseModel> cartlist(BuildContext context, dynamic lat,
      dynamic long, dynamic promocode) async {
    print("User Id ____-------------" + (ApiServices.userId!).toString());
    print("-----_____-----_____-----_____-----_____");
    Uri url = Uri.parse(
        "https://chillkrt.in/Mycities/Mycities_food/index.php/api/Api_customer/cartlist");
    // var request = MultipartRequest('POST', url);

    // print("User Id ____-------------" + ApiServices.user!.id!);

    // print("User Id ____-------------" + ApiServices.user!.address!);

    // print("User Id ____-------------" + ApiServices.user!.customer_name!);

    final req = await http.post(url, body: {
      "user_id": ApiServices.userId!,
      "lat": "$lat",
      "long": "$long",
      "promocode": "$promocode"
    });
    print(
        "_-----_------_-----_-----_------_-------" + req.statusCode.toString());
    CartResponseModel? cartResponseModel;
    if (req.statusCode == 200) {
      print("User Id ____-------------" + (ApiServices.userId!).toString());
      print(req.body);
      // request.fields.addAll();
      // var response = await request.send();
      // final respStr = await response.stream.bytesToString();
      var jsonResponse = jsonDecode(req.body);

      // List<ProductCartList> _productcartList = [];
      // List<RetailerCartlist> _retailercartlist = [];

      cartResponseModel = CartResponseModel.fromJson(jsonResponse);
    }
    return cartResponseModel!;

    // if (jsonResponse['status'] == '1') {
    //   deliveryfee = jsonResponse['delivery_fee'];
    //   subtotal = jsonResponse['sub_total'];
    //   taxes = jsonResponse['taxes'];
    //   discountAmount = jsonResponse['discount_amt'];
    //   promocodeused = jsonResponse['used_promocode'];

    //   totalAmount = jsonResponse['total'];
    //   discountAmountRange = jsonResponse['discount_amt_range'];
    //   // qty = jsonResponse['productDetails']['taxes'];

    //   if (jsonResponse['status'] == "1") {
    //     for (var item in jsonResponse['productDetails']) {
    //       _productcartList.add(ProductCartList.fromMap(item));
    //     }
    //     productcartList = _productcartList;
    //     for (var item in jsonResponse['RetailerDetails']) {
    //       _retailercartlist.add(RetailerCartlist.fromMap(item));
    //     }
    //     retailercartList = _retailercartlist;
    //     print("${jsonResponse["get_all_address_customer"]}");
    //     if (jsonResponse["get_all_address_customer"] != null) {
    //       getAllAddress =
    //           UserModel.fromMap(jsonResponse["get_all_address_customer"]);
    //     }

    //     print("getAllAddress +${getAllAddress}");
    //   }
    //   return productcartList;
    // } else {
    //   return null;
    // }
  }

  Future<CartNewModel?> modelcartlist(BuildContext context, dynamic lat,
      dynamic long, dynamic promocode) async {
    print("promocode +${promocode}");
    Uri url = Uri.parse(
        "https://chillkrt.in/Mycities/Mycities_food/index.php/api/Api_customer/cartlist");
    var request = MultipartRequest('POST', url);

    request.fields.addAll(
        {"user_id": ApiServices.userId!, "lat": "${lat}", "long": "${long}"});
    var response = await request.send();
    final respStr = await response.stream.bytesToString();
    print("respStr +${respStr}");

    var jsonResponse = jsonDecode(respStr);
    print("jsonResopnse Cart ============= ${jsonResponse['status']}");

    if (jsonResponse['status'] == '1') {
      print("hsgdhdiufhb");
      var cartModel = CartNewModel.fromJson(jsonResponse);
      print("cartModel Add 30230320------------------------- +${cartModel}");
      return cartModel;
    } else {
      return null;
    }
  }

  Future<OrderDetails?> getOrderList(
      BuildContext context, dynamic orderId) async {
    Uri url = Uri.parse("$baseUrl/order_get_list");
    var request = MultipartRequest('POST', url);

    request.fields
        .addAll({"user_id": ApiServices.userId!, "order_id": "${orderId}"});
    var response = await request.send();
    final respStr = await response.stream.bytesToString();
    var jsonResponse = jsonDecode(respStr);

    if (jsonResponse['status'] == '1') {
      var orderDetails = OrderDetails.fromJson(jsonResponse);
      print("cartModel +${orderDetails}");
      return orderDetails;
    } else {
      return null;
    }
  }

  Future addProduct(
      BuildContext context, String? menu_id, String quantity, String status,
      {String? snackbarMessage, String productStatus = "1"}) async {
    Uri url = Uri.parse("$baseUrl/addToCart");
    var request = MultipartRequest('POST', url);
    request.fields.addAll({
      "menu_id": "$menu_id",
      "user_id": ApiServices.userId!,
      "quantity": "$quantity",
      "status": "$status",
      "product_status": productStatus,
    });

    var response = await request.send();

    final respStr = await response.stream.bytesToString();
    var jsonResponse = jsonDecode(respStr);
    print("the json response" + jsonResponse.toString());
    return jsonResponse;
  }

  Future addToCart(
    BuildContext context,
    String? menu_id,
    String quantity,
    String status, {
    String? snackbarMessage,
    String productStatus = "1",
  }) async {
    Uri url = Uri.parse("$baseUrl/addToCart");
    var request = MultipartRequest('POST', url);
    print(menu_id! +
        "\n" +
        ApiServices.userId! +
        "\n" +
        quantity +
        "\n" +
        status +
        "\n" +
        productStatus);
    request.fields.addAll({
      "menu_id": "$menu_id",
      "user_id": ApiServices.userId!,
      "quantity": quantity == "1" ? "0" : quantity,
      "status": "$status",
      "product_status": productStatus,
    });

    var response = await request.send();

    final respStr = await response.stream.bytesToString();
    var jsonResponse = jsonDecode(respStr);
    print("print response message" + jsonResponse['message']);
    if (jsonResponse['status'] == "1") {
      print("print response message" + jsonResponse['message']);

      Fluttertoast.showToast(
          msg: snackbarMessage == null
              ? jsonResponse['message']
              : snackbarMessage,
          toastLength: Toast.LENGTH_SHORT);
    } else {
      print("print response message" + jsonResponse['message']);

      return await showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: new Text(
              "Replace cart item?",
              style: CommonStyles.black12thin(),
            ),
            content: new Text(
              jsonResponse['message'],
              style: CommonStyles.black12(),
            ),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new TextButton(
                child: new Text(
                  "No",
                  style: CommonStyles.red12(),
                ),
                onPressed: () async {
                  String itemFromDifferentRestaurantMessage =
                      "Your cart contains items from";
                  if (!jsonResponse['message']
                      .toString()
                      .contains(itemFromDifferentRestaurantMessage)) {
                    print("IF Part pressed no");
                    await addProduct(context, menu_id, quantity, status,
                        productStatus: productStatus,
                        snackbarMessage: snackbarMessage);
                  }
                  Navigator.of(context).pop("no");
                },
              ),
              new TextButton(
                child: new Text(
                  "Yes",
                  style: CommonStyles.black12(),
                ),
                onPressed: () async {
                  String itemFromDifferentRestaurantMessage =
                      "Your cart contains items from";
                  if (jsonResponse['message']
                      .toString()
                      .contains(itemFromDifferentRestaurantMessage)) {
                    showLoadDialog(context);
                    await clearCart();
                    await addProduct(context, menu_id, quantity, status,
                        productStatus: productStatus,
                        snackbarMessage: snackbarMessage);
                    Navigator.of(context).pop();
                  }
                  // await addToCart(context, menu_id, quantity, status);
                  // await addProduct(context, menu_id, quantity, status,
                  //     snackbarMessage: snackbarMessage,
                  //     productStatus: productStatus);
                  Navigator.of(context).pop();
                  // await context
                  //     .read<CartListAPIProvider>()
                  //     .cartlist(SharedPreference.latitude,
                  //         SharedPreference.longitude, "")
                  //     .then((value) => Navigator.of(context).pop());
                },
              ),
            ],
          );
        },
      );
      // Toast.show(
      //   jsonResponse['message'],
      //   context,
      //   duration: 2,
      // );
    }

    Map<String, dynamic> addData = {
      'status': jsonResponse['status'],
      'message': jsonResponse['message']
    };
    return addData;
  }

  Future clearCart() async {
    Uri url = Uri.parse(
        "https://chillkrt.in/Mycities/Mycities_food/index.php/api/Api_customer/clear_cart");
    var request = MultipartRequest('POST', url);
    request.fields.addAll({
      "user_id": ApiServices.userId!,
    });

    var response = await request.send();

    final respStr = await response.stream.bytesToString();
    var jsonResponse = jsonDecode(respStr);
    // if (jsonResponse['status'] == "1") {
    //   Toast.show(
    //     jsonResponse['message'],
    //     context,
    //     duration: 1,
    //   );
    // } else {
    //
    // }

    Map<String, dynamic> addData = {
      'status': jsonResponse['status'],
      'message': jsonResponse['message']
    };
    return addData;
  }

  Future orderClearCart() async {
    Uri url = Uri.parse("$baseUrl/order_cart_clear");
    var request = MultipartRequest('POST', url);
    request.fields.addAll({
      "user_id": ApiServices.userId!,
    });

    var response = await request.send();

    final respStr = await response.stream.bytesToString();
    var jsonResponse = jsonDecode(respStr);
    // if (jsonResponse['status'] == "1") {
    //   Toast.show(
    //     jsonResponse['message'],
    //     context,
    //     duration: 1,
    //   );
    // } else {
    //
    // }

    Map<String, dynamic> addData = {
      'status': jsonResponse['status'],
      'message': jsonResponse['message']
    };
    return addData;
  }
}
