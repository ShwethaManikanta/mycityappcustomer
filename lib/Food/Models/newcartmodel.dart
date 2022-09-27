import 'package:flutter/material.dart';

class CartNewModel {
  String? status;
  String? message;
  String? productBaseurl;
  String? retailerProfileurl;
  List<CustomerDetails>? customerDetails;
  GetAllAddressCustomer? getAllAddressCustomer;
  List<ProductDetails>? productDetails;
  List<RetailerDetails>? retailerDetails;
  String? discountAmt;
  String? usedPromocode;
  int? comissionAmt;
  String? deliveryFee;
  String? subTotal;
  String? taxes;
  int? total;

  CartNewModel(
      {this.status,
      this.message,
      this.productBaseurl,
      this.retailerProfileurl,
      this.customerDetails,
      this.getAllAddressCustomer,
      this.productDetails,
      this.retailerDetails,
      this.discountAmt,
      this.usedPromocode,
      this.comissionAmt,
      this.deliveryFee,
      this.subTotal,
      this.taxes,
      this.total});

  CartNewModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    productBaseurl = json['product_baseurl'];
    retailerProfileurl = json['retailer_profileurl'];
    if (json['customerDetails'] != null) {
      customerDetails = <CustomerDetails>[];
      json['customerDetails'].forEach((v) {
        customerDetails!.add(new CustomerDetails.fromJson(v));
      });
    }
    getAllAddressCustomer = json['get_all_address_customer'] != null
        ? new GetAllAddressCustomer.fromJson(json['get_all_address_customer'])
        : null;
    if (json['productDetails'] != null) {
      productDetails = <ProductDetails>[];
      json['productDetails'].forEach((v) {
        productDetails!.add(new ProductDetails.fromJson(v));
      });
    }
    if (json['RetailerDetails'] != null) {
      retailerDetails = <RetailerDetails>[];
      json['RetailerDetails'].forEach((v) {
        retailerDetails!.add(new RetailerDetails.fromJson(v));
      });
    }
    discountAmt = json['discount_amt'];
    usedPromocode = json['used_promocode'];
    comissionAmt = json['comission_amt'];
    deliveryFee = json['delivery_fee'];
    subTotal = json['sub_total'];
    taxes = json['taxes'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['product_baseurl'] = this.productBaseurl;
    data['retailer_profileurl'] = this.retailerProfileurl;
    if (this.customerDetails != null) {
      data['customerDetails'] =
          this.customerDetails!.map((v) => v.toJson()).toList();
    }
    if (this.getAllAddressCustomer != null) {
      data['get_all_address_customer'] = this.getAllAddressCustomer!.toJson();
    }
    if (this.productDetails != null) {
      data['productDetails'] =
          this.productDetails!.map((v) => v.toJson()).toList();
    }
    if (this.retailerDetails != null) {
      data['RetailerDetails'] =
          this.retailerDetails!.map((v) => v.toJson()).toList();
    }
    data['discount_amt'] = this.discountAmt;
    data['used_promocode'] = this.usedPromocode;
    data['comission_amt'] = this.comissionAmt;
    data['delivery_fee'] = this.deliveryFee;
    data['sub_total'] = this.subTotal;
    data['taxes'] = this.taxes;
    data['total'] = this.total;
    return data;
  }
}

class CustomerDetails {
  String? id;
  String? addressTypeId;
  String? userId;
  String? address;
  String? landMark;
  String? floor;
  String? reach;
  String? lat;
  String? long;
  String? status;
  String? createdAt;
  String? customerName;
  String? mobile;
  String? password;
  String? pwdOtp;
  String? addtionalNumber;
  String? email;
  String? selectedAddress;
  String? deviceType;
  String? deviceToken;

  CustomerDetails(
      {this.id,
      this.addressTypeId,
      this.userId,
      this.address,
      this.landMark,
      this.floor,
      this.reach,
      this.lat,
      this.long,
      this.status,
      this.createdAt,
      this.customerName,
      this.mobile,
      this.password,
      this.pwdOtp,
      this.addtionalNumber,
      this.email,
      this.selectedAddress,
      this.deviceType,
      this.deviceToken});

  CustomerDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    addressTypeId = json['address_type_id'];
    userId = json['user_id'];
    address = json['address'];
    landMark = json['land_mark'];
    floor = json['floor'];
    reach = json['reach'];
    lat = json['lat'];
    long = json['long'];
    status = json['status'];
    createdAt = json['created_at'];
    customerName = json['customer_name'];
    mobile = json['mobile'];
    password = json['password'];
    pwdOtp = json['pwd_otp'];
    addtionalNumber = json['addtional_number'];
    email = json['email'];
    selectedAddress = json['selected_address'];
    deviceType = json['device_type'];
    deviceToken = json['device_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['address_type_id'] = this.addressTypeId;
    data['user_id'] = this.userId;
    data['address'] = this.address;
    data['land_mark'] = this.landMark;
    data['floor'] = this.floor;
    data['reach'] = this.reach;
    data['lat'] = this.lat;
    data['long'] = this.long;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['customer_name'] = this.customerName;
    data['mobile'] = this.mobile;
    data['password'] = this.password;
    data['pwd_otp'] = this.pwdOtp;
    data['addtional_number'] = this.addtionalNumber;
    data['email'] = this.email;
    data['selected_address'] = this.selectedAddress;
    data['device_type'] = this.deviceType;
    data['device_token'] = this.deviceToken;
    return data;
  }
}

class GetAllAddressCustomer {
  String? id;
  String? addressTypeId;
  String? userId;
  String? address;
  String? landMark;
  String? floor;
  String? reach;
  String? lat;
  String? long;
  String? status;
  String? createdAt;

  GetAllAddressCustomer(
      {this.id,
      this.addressTypeId,
      this.userId,
      this.address,
      this.landMark,
      this.floor,
      this.reach,
      this.lat,
      this.long,
      this.status,
      this.createdAt});

  GetAllAddressCustomer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    addressTypeId = json['address_type_id'];
    userId = json['user_id'];
    address = json['address'];
    landMark = json['land_mark'];
    floor = json['floor'];
    reach = json['reach'];
    lat = json['lat'];
    long = json['long'];
    status = json['status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['address_type_id'] = this.addressTypeId;
    data['user_id'] = this.userId;
    data['address'] = this.address;
    data['land_mark'] = this.landMark;
    data['floor'] = this.floor;
    data['reach'] = this.reach;
    data['lat'] = this.lat;
    data['long'] = this.long;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class ProductDetails {
  String? id;
  String? menuId;
  String? menuName;
  String? outletId;
  List<String>? productImage;
  String? quantity;
  String? pieces;
  String? weight;
  String? currentPrice;
  String? totalPrice;
  String? description;
  String? cartStatus;
  String? rating;
  String? review;

  ProductDetails(
      {this.id,
      this.menuId,
      this.menuName,
      this.outletId,
      this.productImage,
      this.quantity,
      this.pieces,
      this.weight,
      this.currentPrice,
      this.totalPrice,
      this.description,
      this.cartStatus,
      this.rating,
      this.review});

  ProductDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    menuId = json['menu_id'];
    menuName = json['menu_name'];
    outletId = json['outlet_id'];
    productImage = json['product_image'].cast<String>();
    quantity = json['quantity'];
    pieces = json['pieces'];
    weight = json['weight'];
    currentPrice = json['current_price'];
    totalPrice = json['total_price'];
    description = json['description'];
    cartStatus = json['cart_status'];
    rating = json['rating'];
    review = json['review'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['menu_id'] = this.menuId;
    data['menu_name'] = this.menuName;
    data['outlet_id'] = this.outletId;
    data['product_image'] = this.productImage;
    data['quantity'] = this.quantity;
    data['pieces'] = this.pieces;
    data['weight'] = this.weight;
    data['current_price'] = this.currentPrice;
    data['total_price'] = this.totalPrice;
    data['description'] = this.description;
    data['cart_status'] = this.cartStatus;
    data['rating'] = this.rating;
    data['review'] = this.review;
    return data;
  }
}

class RetailerDetails {
  String? id;
  String? outletName;
  String? outletImage;
  String? outletAddress;
  String? rating;
  String? lat;
  String? long;
  String? duration;
  String? distance;

  RetailerDetails(
      {this.id,
      this.outletName,
      this.outletImage,
      this.outletAddress,
      this.rating,
      this.lat,
      this.long,
      this.duration,
      this.distance});

  RetailerDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    outletName = json['outlet_name'];
    outletImage = json['outlet_image'];
    outletAddress = json['outlet_address'];
    rating = json['rating'];
    lat = json['lat'];
    long = json['long'];
    duration = json['duration'];
    distance = json['distance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['outlet_name'] = this.outletName;
    data['outlet_image'] = this.outletImage;
    data['outlet_address'] = this.outletAddress;
    data['rating'] = this.rating;
    data['lat'] = this.lat;
    data['long'] = this.long;
    data['duration'] = this.duration;
    data['distance'] = this.distance;
    return data;
  }
}
