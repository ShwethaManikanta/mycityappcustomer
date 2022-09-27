import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:mycityapp/Food/Models/UserModel.dart';

class CartListViewModel {
  String? status;
  String? message;
  String? product_baseurl;
  String? retailer_profileurl;
  List<ProductCartList>? productDetails;
  List<RetailerCartlist>? RetailerDetails;
  UserModel? get_all_address_customer;
  List<UserModel>? customerDetails;

  String? delivery_fee;
  String? sub_total;
  String? used_promocode;
  String? taxes;
  String? total;
  String? discount_amt;
  String? discount_amt_range;

  CartListViewModel(
      {this.status,
      this.message,
      this.get_all_address_customer,
      this.customerDetails,
      this.product_baseurl,
      this.retailer_profileurl,
      this.productDetails,
      this.RetailerDetails,
      this.total,
      this.used_promocode,
      this.delivery_fee,
      this.sub_total,
      this.discount_amt,
      this.discount_amt_range,
      this.taxes});

  CartListViewModel copyWith({
    String? status,
    String? message,
    String? used_promocode,
    String? product_baseurl,
    String? retailer_profileurl,
    UserModel? get_all_address_customer,
    List<UserModel>? customerDetails,
    List<ProductCartList>? productDetails,
    List<RetailerCartlist>? RetailerDetails,
    String? delivery_fee,
    String? sub_total,
    String? taxes,
    String? total,
    String? discount_amt,
    String? discount_amt_range,
  }) {
    return CartListViewModel(
      status: status ?? this.status,
      used_promocode: used_promocode ?? this.used_promocode,
      message: message ?? this.message,
      product_baseurl: product_baseurl ?? this.product_baseurl,
      retailer_profileurl: retailer_profileurl ?? this.retailer_profileurl,
      get_all_address_customer:
          get_all_address_customer ?? this.get_all_address_customer,
      customerDetails: customerDetails ?? this.customerDetails,
      productDetails: productDetails ?? this.productDetails,
      RetailerDetails: RetailerDetails ?? this.RetailerDetails,
      delivery_fee: delivery_fee ?? this.delivery_fee,
      sub_total: sub_total ?? this.sub_total,
      discount_amt: discount_amt ?? this.discount_amt,
      discount_amt_range: discount_amt_range ?? this.discount_amt_range,
      taxes: taxes ?? this.taxes,
      total: total ?? this.total,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'message': message,
      'used_promocode': used_promocode,
      'get_all_address_customer': get_all_address_customer,
      'customerDetails': customerDetails,
      'product_baseurl': product_baseurl,
      'retailer_profileurl': retailer_profileurl,
      'productDetails': productDetails,
      'RetailerDetails': RetailerDetails,
      'delivery_fee': delivery_fee,
      'sub_total': sub_total,
      'discount_amt': discount_amt,
      'discount_amt_range': discount_amt_range,
      'taxes': taxes,
      'total': total,
    };
  }

  factory CartListViewModel.fromMap(Map<String, dynamic> map) {
    return CartListViewModel(
      status: map['status'],
      message: map['message'],
      used_promocode: map['used_promocode'],
      product_baseurl: map['product_baseurl'],
      retailer_profileurl: map['retailer_profileurl'],
      productDetails: map['productDetails'],
      RetailerDetails: map['RetailerDetails'],
      get_all_address_customer: map['get_all_address_customer'],
      customerDetails: map['customerDetails'],
      delivery_fee: map['delivery_fee'],
      sub_total: map['sub_total'],
      discount_amt: map['discount_amt'],
      discount_amt_range: map['discount_amt_range'],
      taxes: map['taxes'],
      total: map['total'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CartListViewModel.fromJson(String source) =>
      CartListViewModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CartListViewModel(status: $status,get_all_address_customer :$get_all_address_customer,customerDetails :$customerDetails,used_promocode :$used_promocode, message: $message, product_baseurl: $product_baseurl, retailer_profileurl: $retailer_profileurl, product_list: $productDetails, RetailerCartlist: $RetailerDetails, delivery_fee: $delivery_fee, sub_total: $sub_total, taxes: $taxes, total: $total,'
        'discount_amt : $discount_amt,discount_amt_range: $discount_amt_range)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CartListViewModel &&
        other.status == status &&
        other.message == message &&
        other.get_all_address_customer == get_all_address_customer &&
        other.customerDetails == customerDetails &&
        other.product_baseurl == product_baseurl &&
        other.used_promocode == used_promocode &&
        other.retailer_profileurl == retailer_profileurl &&
        other.productDetails == productDetails &&
        other.RetailerDetails == RetailerDetails &&
        other.discount_amt == discount_amt &&
        other.discount_amt_range == discount_amt_range &&
        other.delivery_fee == delivery_fee &&
        other.sub_total == sub_total &&
        other.taxes == taxes &&
        other.total == total;
  }

  @override
  int get hashCode {
    return status.hashCode ^
        message.hashCode ^
        get_all_address_customer.hashCode ^
        customerDetails.hashCode ^
        used_promocode.hashCode ^
        product_baseurl.hashCode ^
        retailer_profileurl.hashCode ^
        productDetails.hashCode ^
        RetailerDetails.hashCode ^
        discount_amt.hashCode ^
        discount_amt_range.hashCode ^
        delivery_fee.hashCode ^
        sub_total.hashCode ^
        taxes.hashCode ^
        total.hashCode;
  }
}

class ProductCartList {
  String? id;
  String? menu_id;
  String? menu_name;
  String? outlet_id;
  List<String?>? product_image;
  String? quantity;
  String? current_price;
  String? total_price;
  String? description;
  String? cart_status;

  String? rating;
  String? no_review;

  ProductCartList({
    this.id,
    this.description,
    this.rating,
    this.menu_name,
    this.no_review,
    this.cart_status,
    this.current_price,
    this.menu_id,
    this.outlet_id,
    this.product_image,
    this.quantity,
    this.total_price,
  });

  ProductCartList copyWith(
      {String? id,
      String? menu_id,
      String? menu_name,
      String? outlet_id,
      List<String>? product_image,
      String? quantity,
      String? current_price,
      String? total_price,
      String? description,
      String? cart_status,
      String? rating,
      String? no_review}) {
    return ProductCartList(
      id: id ?? this.id,
      menu_id: menu_id ?? this.menu_id,
      outlet_id: outlet_id ?? this.outlet_id,
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
      current_price: current_price ?? this.current_price,
      product_image: product_image ?? this.product_image,
      menu_name: menu_name ?? this.menu_name,
      total_price: total_price ?? this.total_price,
      no_review: no_review ?? this.no_review,
      rating: rating ?? this.rating,
      cart_status: cart_status ?? this.cart_status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'menu_id': menu_id,
      'outlet_id': outlet_id,
      'quantity': quantity,
      'current_price': current_price,
      'product_image': product_image,
      'description': description,
      'total_price': total_price,
      'cart_status': cart_status,
      'menu_name': menu_name,
      'no_review': no_review,
      'rating': rating,
    };
  }

  factory ProductCartList.fromMap(Map<String, dynamic> map) {
    return ProductCartList(
      id: map['id'],
      description: map['description'],
      menu_id: map['menu_id'],
      outlet_id: map['outlet_id'],
      // menu_image: map['menu_image'],

      product_image: List.generate(
          map['product_image'].length, (index) => map['product_image'][index]),
      quantity: map['quantity'],
      menu_name: map['menu_name'],
      no_review: map['no_review'],
      rating: map['rating'],
      current_price: map['current_price'],
      total_price: map['total_price'],
      cart_status: map['cart_status'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductCartList.fromJson(String source) =>
      ProductCartList.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProductCartList(id: $id, description: $description, menu_id: $menu_id, outlet_id: $outlet_id, menu_name: $menu_name,product_image: $product_image, quantity: $quantity, no_review: $no_review, current_price: $current_price, total_price: $total_price, cart_status: $cart_status)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductCartList &&
        other.id == id &&
        other.description == description &&
        other.no_review == no_review &&
        other.quantity == quantity &&
        other.outlet_id == outlet_id &&
        other.menu_id == menu_id &&
        listEquals(other.product_image, product_image) &&
        other.menu_name == menu_name &&
        other.rating == rating &&
        other.total_price == total_price &&
        other.current_price == menu_name &&
        other.cart_status == rating;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        description.hashCode ^
        no_review.hashCode ^
        menu_id.hashCode ^
        outlet_id.hashCode ^
        quantity.hashCode ^
        menu_name.hashCode ^
        product_image.hashCode ^
        rating.hashCode ^
        menu_id.hashCode ^
        total_price.hashCode ^
        current_price.hashCode ^
        cart_status.hashCode;
  }
}

class RetailerCartlist {
  String? id;
  String? outlet_name;
  String? outlet_address;

  // List<String> menu_image;
  // String outlet_image;
  String? lat;
  String? long;
  String? duration;
  String? distance;
  String? rating;
  String? no_review;

  RetailerCartlist(
      {this.id,
      this.distance,
      this.lat,
      this.outlet_address,
      // this.menu_image,
      this.outlet_name,
      this.long,
      this.no_review,
      this.rating,
      this.duration});

  RetailerCartlist copyWith({
    String? id,
    String? distance,
    String? lat,
    String? outlet_address,

    // String outlet_image,
    // String menu_image,
    String? outlet_name,
    String? long,
    String? no_review,
    String? rating,
    String? duration,
  }) {
    return RetailerCartlist(
      id: id ?? this.id,
      distance: distance ?? this.distance,
      lat: lat ?? this.lat,
      outlet_address: outlet_address ?? this.outlet_address,
      // outlet_image: outlet_image ?? this.outlet_image,
      // menu_image: menu_image ?? this.menu_image,
      outlet_name: outlet_name ?? this.outlet_name,
      long: long ?? this.long,
      no_review: no_review ?? this.no_review,
      rating: rating ?? this.rating,
      duration: duration ?? this.duration,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'distance': distance,
      'outlet_address': outlet_address,
      'lat': lat,
      // 'outlet_image': outlet_image,
      // 'menu_image': menu_image,
      'outlet_name': outlet_name,
      'long': long,
      'no_review': no_review,
      'rating': rating,
      'duration': duration,
    };
  }

  factory RetailerCartlist.fromMap(Map<String, dynamic> map) {
    return RetailerCartlist(
      id: map['id'],
      distance: map['distance'],
      outlet_address: map['outlet_address'],
      lat: map['lat'],
      // outlet_image: map['outlet_image'],
      // menu_image: map['menu_image'],
      outlet_name: map['outlet_name'],
      long: map['long'],
      no_review: map['no_review'],
      rating: map['rating'],
      duration: map['duration'],
    );
  }

  String toJson() => json.encode(toMap());

  factory RetailerCartlist.fromJson(String source) =>
      RetailerCartlist.fromMap(json.decode(source));

  @override
  String toString() {
    return 'RetailerCartlist(id: $id,outlet_address :$outlet_address, distance: $distance, lat: $lat, outlet_name: $outlet_name, long: $long, no_review: $no_review, rating: $rating, duration: $duration)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RetailerCartlist &&
        other.id == id &&
        other.distance == distance &&
        other.no_review == no_review &&
        other.duration == duration &&
        other.outlet_address == outlet_address &&
        other.lat == lat &&
        // other.outlet_image == outlet_image &&
        // other.menu_image == menu_image &&
        other.outlet_name == outlet_name &&
        other.rating == rating &&
        other.long == long;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        distance.hashCode ^
        no_review.hashCode ^
        duration.hashCode ^
        // outlet_image.hashCode ^
        lat.hashCode ^
        outlet_name.hashCode ^
        // menu_image.hashCode ^
        rating.hashCode ^
        long.hashCode;
  }
}

///--------------
///
class CartResponseModel {
  String? status;
  String? message;
  String? productBaseurl;
  String? retailerProfileurl;
  String? quickerStatus;
  bool? quickerMessage;
  String? deliveryStatus;
  String? quickerDeliveryFees;
  List<CustomerDetails>? customerDetails;
  GetAllAddressCustomer? getAllAddressCustomer;
  List<ProductDetails>? productDetails;
  List<RetailerDetails>? retailerDetails;
  String? discountAmt;
  String? usedPromocode;
  String? packingTax;
  String? consalationTax;
  String? deliveryFee;
  String? carryBag;
  String? subTotal;
  String? total;
  String? gstTax;
  String? quickerDeliveryTime;
  String? dunzoStatus;
  bool? dunzoMessage;
  String? dunzoDeliveryFees;
  String? dunzoDeliveryTime;
  String? packingCharge;

  CartResponseModel(
      {this.status,
      this.message,
      this.productBaseurl,
      this.retailerProfileurl,
      this.quickerStatus,
      this.quickerMessage,
      this.quickerDeliveryFees,
      this.customerDetails,
      this.getAllAddressCustomer,
      this.deliveryStatus,
      this.productDetails,
      this.quickerDeliveryTime,
      this.dunzoDeliveryFees,
      this.dunzoDeliveryTime,
      this.dunzoMessage,
      this.dunzoStatus,
      this.retailerDetails,
      this.discountAmt,
      this.usedPromocode,
      this.packingTax,
      this.consalationTax,
      this.gstTax,
      this.deliveryFee,
      this.carryBag,
      this.subTotal,
      this.total});

  CartResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    productBaseurl = json['product_baseurl'];
    retailerProfileurl = json['retailer_profileurl'];
    quickerStatus = json['quicker_status'];
    quickerDeliveryTime = json['quicker_delivery_time'];
    quickerMessage = json['quicker_message'];
    deliveryStatus = json['delivery_status'];
    quickerDeliveryFees = json['quicker_delivery_fees'];
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
    packingTax = json['packing_charge'];
    consalationTax = json['consalation_tax'];
    dunzoDeliveryFees = json['dunzo_delivery_fees'];
    dunzoDeliveryTime = json['dunzo_delivery_time'];
    dunzoStatus = json['dunzo_status'];
    dunzoMessage = json['dunzo_message'];

    deliveryFee = json['delivery_fee'];
    carryBag = json['carry_bag'];
    gstTax = json['gst_tax'];
    subTotal = json['sub_total'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['product_baseurl'] = this.productBaseurl;
    data['retailer_profileurl'] = this.retailerProfileurl;
    data['quicker_status'] = this.quickerStatus;
    data['quicker_message'] = this.quickerMessage;
    data['quicker_delivery_fees'] = this.quickerDeliveryFees;
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
    data['packing_tax'] = this.packingTax;
    data['consalation_tax'] = this.consalationTax;
    data['delivery_fee'] = this.deliveryFee;
    data['carry_bag'] = this.carryBag;
    data['sub_total'] = this.subTotal;
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
  String? firebaseId;
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
      this.firebaseId,
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
    firebaseId = json['firebase_id'];
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
    data['firebase_id'] = this.firebaseId;
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
  List<AdonList>? adonList;
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
      this.adonList,
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
    if (json['adon_list'] != null) {
      adonList = <AdonList>[];
      json['adon_list'].forEach((v) {
        adonList!.add(new AdonList.fromJson(v));
      });
    }
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

class AdonList {
  String? id;
  String? adonName;
  String? salePrice;

  AdonList({this.id, this.adonName, this.salePrice});

  AdonList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    adonName = json['adon_name'];
    salePrice = json['sale_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['adon_name'] = this.adonName;
    data['sale_price'] = this.salePrice;
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
