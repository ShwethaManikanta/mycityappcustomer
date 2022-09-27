class OngoingOrderResponseModel {
  String? status;
  String? message;
  String? menuProfileurl;
  List<OrderOngoing>? orderOngoing;

  OngoingOrderResponseModel(
      {this.status, this.message, this.menuProfileurl, this.orderOngoing});

  OngoingOrderResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    menuProfileurl = json['menu_profileurl'];
    if (json['order_ongoing'] != null) {
      orderOngoing = <OrderOngoing>[];
      json['order_ongoing'].forEach((v) {
        orderOngoing!.add(new OrderOngoing.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['menu_profileurl'] = this.menuProfileurl;
    if (this.orderOngoing != null) {
      data['order_ongoing'] =
          this.orderOngoing!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderOngoing {
  String? id;
  List<ProductDetails>? productDetails;
  CustomerName? customerName;
  HotelDetails? hotelDetails;
  DeliveyDetails? deliveyDetails;
  CurrentLocationCoordinates? currentLocationCoordinates;
  String? address;
  String? itemTotal;
  String? total;
  String? deliveryFee;
  String? lat;
  String? long;
  String? outletId;
  String? taxes;
  String? deliveryDate;
  String? status;
  String? deliveryPartnerStatus;

  OrderOngoing(
      {this.id,
      this.productDetails,
      this.customerName,
      this.hotelDetails,
      this.deliveyDetails,
      this.currentLocationCoordinates,
      this.address,
      this.itemTotal,
      this.total,
      this.deliveryFee,
      this.lat,
      this.long,
      this.outletId,
      this.taxes,
      this.deliveryDate,
      this.status,
      this.deliveryPartnerStatus});

  OrderOngoing.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['product_details'] != null) {
      productDetails = <ProductDetails>[];
      json['product_details'].forEach((v) {
        productDetails!.add(new ProductDetails.fromJson(v));
      });
    }
    customerName = json['customer_name'] != null
        ? new CustomerName.fromJson(json['customer_name'])
        : null;
    hotelDetails = json['hotel_details'] != null
        ? new HotelDetails.fromJson(json['hotel_details'])
        : null;
    deliveyDetails = json['deliveyDetails'] != null
        ? new DeliveyDetails.fromJson(json['deliveyDetails'])
        : null;
    currentLocationCoordinates = json['current_location_coordinates'] != null
        ? new CurrentLocationCoordinates.fromJson(
            json['current_location_coordinates'])
        : null;
    address = json['address'];
    itemTotal = json['item_total'];
    total = json['total'];
    deliveryFee = json['delivery_fee'];
    lat = json['lat'];
    long = json['long'];
    outletId = json['outlet_id'];
    taxes = json['taxes'];
    deliveryDate = json['delivery_date'];
    status = json['status'];
    deliveryPartnerStatus = json['delivery_partner_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.productDetails != null) {
      data['product_details'] =
          this.productDetails!.map((v) => v.toJson()).toList();
    }
    if (this.customerName != null) {
      data['customer_name'] = this.customerName!.toJson();
    }
    if (this.hotelDetails != null) {
      data['hotel_details'] = this.hotelDetails!.toJson();
    }
    if (this.deliveyDetails != null) {
      data['deliveyDetails'] = this.deliveyDetails!.toJson();
    }
    if (this.currentLocationCoordinates != null) {
      data['current_location_coordinates'] =
          this.currentLocationCoordinates!.toJson();
    }
    data['address'] = this.address;
    data['item_total'] = this.itemTotal;
    data['total'] = this.total;
    data['delivery_fee'] = this.deliveryFee;
    data['lat'] = this.lat;
    data['long'] = this.long;
    data['outlet_id'] = this.outletId;
    data['taxes'] = this.taxes;
    data['delivery_date'] = this.deliveryDate;
    data['status'] = this.status;
    data['delivery_partner_status'] = this.deliveryPartnerStatus;
    return data;
  }
}

class ProductDetails {
  String? id;
  String? productName;
  String? productImage;
  String? qty;
  int? price;

  ProductDetails(
      {this.id, this.productName, this.productImage, this.qty, this.price});

  ProductDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productName = json['product_name'];
    productImage = json['product_image'];
    qty = json['qty'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_name'] = this.productName;
    data['product_image'] = this.productImage;
    data['qty'] = this.qty;
    data['price'] = this.price;
    return data;
  }
}

class CustomerName {
  String? id;
  String? firebaseId;
  String? customerName;
  String? mobile;
  Null? password;
  String? pwdOtp;
  Null? addtionalNumber;
  String? email;
  String? addressTypeId;
  String? selectedAddress;
  String? address;
  String? landMark;
  String? floor;
  String? reach;
  String? lat;
  String? long;
  String? status;
  String? deviceType;
  String? deviceToken;
  String? createdAt;

  CustomerName(
      {this.id,
      this.firebaseId,
      this.customerName,
      this.mobile,
      this.password,
      this.pwdOtp,
      this.addtionalNumber,
      this.email,
      this.addressTypeId,
      this.selectedAddress,
      this.address,
      this.landMark,
      this.floor,
      this.reach,
      this.lat,
      this.long,
      this.status,
      this.deviceType,
      this.deviceToken,
      this.createdAt});

  CustomerName.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firebaseId = json['firebase_id'];
    customerName = json['customer_name'];
    mobile = json['mobile'];
    password = json['password'];
    pwdOtp = json['pwd_otp'];
    addtionalNumber = json['addtional_number'];
    email = json['email'];
    addressTypeId = json['address_type_id'];
    selectedAddress = json['selected_address'];
    address = json['address'];
    landMark = json['land_mark'];
    floor = json['floor'];
    reach = json['reach'];
    lat = json['lat'];
    long = json['long'];
    status = json['status'];
    deviceType = json['device_type'];
    deviceToken = json['device_token'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firebase_id'] = this.firebaseId;
    data['customer_name'] = this.customerName;
    data['mobile'] = this.mobile;
    data['password'] = this.password;
    data['pwd_otp'] = this.pwdOtp;
    data['addtional_number'] = this.addtionalNumber;
    data['email'] = this.email;
    data['address_type_id'] = this.addressTypeId;
    data['selected_address'] = this.selectedAddress;
    data['address'] = this.address;
    data['land_mark'] = this.landMark;
    data['floor'] = this.floor;
    data['reach'] = this.reach;
    data['lat'] = this.lat;
    data['long'] = this.long;
    data['status'] = this.status;
    data['device_type'] = this.deviceType;
    data['device_token'] = this.deviceToken;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class HotelDetails {
  String? id;
  String? type;
  String? outletMainId;
  String? outletSubId;
  String? email;
  String? password;
  String? decryptPassword;
  String? mobile;
  String? pwdOtp;
  String? image;
  String? atharImage;
  String? panNumber;
  String? licenseImage;
  String? fssaiNumber;
  String? fssaiExpiryDate;
  String? outletName;
  String? outletAddress;
  String? area;
  String? deliveryTime;
  String? offerSpot;
  String? upTo;
  Null? outletImage;
  String? latitude;
  String? longitude;
  String? foodTypeId;
  String? restaurantType;
  Null? gstStatus;
  Null? gstPercentage;
  String? gstImage;
  String? gstNumber;
  String? carryBag;
  String? sponsor;
  String? orderType;
  String? bankCheckList;
  String? bankAccountNumber;
  String? bankIfscCode;
  String? bankHolderName;
  String? description;
  String? deviceType;
  String? deviceToken;
  String? status;
  String? requestStatus;
  String? requestAmt;
  String? createdAt;
  Null? updatedAt;

  HotelDetails(
      {this.id,
      this.type,
      this.outletMainId,
      this.outletSubId,
      this.email,
      this.password,
      this.decryptPassword,
      this.mobile,
      this.pwdOtp,
      this.image,
      this.atharImage,
      this.panNumber,
      this.licenseImage,
      this.fssaiNumber,
      this.fssaiExpiryDate,
      this.outletName,
      this.outletAddress,
      this.area,
      this.deliveryTime,
      this.offerSpot,
      this.upTo,
      this.outletImage,
      this.latitude,
      this.longitude,
      this.foodTypeId,
      this.restaurantType,
      this.gstStatus,
      this.gstPercentage,
      this.gstImage,
      this.gstNumber,
      this.carryBag,
      this.sponsor,
      this.orderType,
      this.bankCheckList,
      this.bankAccountNumber,
      this.bankIfscCode,
      this.bankHolderName,
      this.description,
      this.deviceType,
      this.deviceToken,
      this.status,
      this.requestStatus,
      this.requestAmt,
      this.createdAt,
      this.updatedAt});

  HotelDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    outletMainId = json['outlet_main_id'];
    outletSubId = json['outlet_sub_id'];
    email = json['email'];
    password = json['password'];
    decryptPassword = json['decrypt_password'];
    mobile = json['mobile'];
    pwdOtp = json['pwd_otp'];
    image = json['image'];
    atharImage = json['athar_image'];
    panNumber = json['pan_number'];
    licenseImage = json['license_image'];
    fssaiNumber = json['fssai_number'];
    fssaiExpiryDate = json['fssai_expiry_date'];
    outletName = json['outlet_name'];
    outletAddress = json['outlet_address'];
    area = json['area'];
    deliveryTime = json['delivery_time'];
    offerSpot = json['offer_spot'];
    upTo = json['up_to'];
    outletImage = json['outlet_image'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    foodTypeId = json['food_type_id'];
    restaurantType = json['restaurant_type'];
    gstStatus = json['gst_status'];
    gstPercentage = json['gst_percentage'];
    gstImage = json['gst_image'];
    gstNumber = json['gst_number'];
    carryBag = json['carry_bag'];
    sponsor = json['sponsor'];
    orderType = json['order_type'];
    bankCheckList = json['bank_check_list'];
    bankAccountNumber = json['bank_account_number'];
    bankIfscCode = json['bank_ifsc_code'];
    bankHolderName = json['bank_holder_name'];
    description = json['description'];
    deviceType = json['device_type'];
    deviceToken = json['device_token'];
    status = json['status'];
    requestStatus = json['request_status'];
    requestAmt = json['request_amt'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['outlet_main_id'] = this.outletMainId;
    data['outlet_sub_id'] = this.outletSubId;
    data['email'] = this.email;
    data['password'] = this.password;
    data['decrypt_password'] = this.decryptPassword;
    data['mobile'] = this.mobile;
    data['pwd_otp'] = this.pwdOtp;
    data['image'] = this.image;
    data['athar_image'] = this.atharImage;
    data['pan_number'] = this.panNumber;
    data['license_image'] = this.licenseImage;
    data['fssai_number'] = this.fssaiNumber;
    data['fssai_expiry_date'] = this.fssaiExpiryDate;
    data['outlet_name'] = this.outletName;
    data['outlet_address'] = this.outletAddress;
    data['area'] = this.area;
    data['delivery_time'] = this.deliveryTime;
    data['offer_spot'] = this.offerSpot;
    data['up_to'] = this.upTo;
    data['outlet_image'] = this.outletImage;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['food_type_id'] = this.foodTypeId;
    data['restaurant_type'] = this.restaurantType;
    data['gst_status'] = this.gstStatus;
    data['gst_percentage'] = this.gstPercentage;
    data['gst_image'] = this.gstImage;
    data['gst_number'] = this.gstNumber;
    data['carry_bag'] = this.carryBag;
    data['sponsor'] = this.sponsor;
    data['order_type'] = this.orderType;
    data['bank_check_list'] = this.bankCheckList;
    data['bank_account_number'] = this.bankAccountNumber;
    data['bank_ifsc_code'] = this.bankIfscCode;
    data['bank_holder_name'] = this.bankHolderName;
    data['description'] = this.description;
    data['device_type'] = this.deviceType;
    data['device_token'] = this.deviceToken;
    data['status'] = this.status;
    data['request_status'] = this.requestStatus;
    data['request_amt'] = this.requestAmt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class DeliveyDetails {
  Null? riderName;
  Null? riderMobile;
  String? deliveryPartnerStatus;

  DeliveyDetails(
      {this.riderName, this.riderMobile, this.deliveryPartnerStatus});

  DeliveyDetails.fromJson(Map<String, dynamic> json) {
    riderName = json['rider_name'];
    riderMobile = json['rider_mobile'];
    deliveryPartnerStatus = json['delivery_partner_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rider_name'] = this.riderName;
    data['rider_mobile'] = this.riderMobile;
    data['delivery_partner_status'] = this.deliveryPartnerStatus;
    return data;
  }
}

class CurrentLocationCoordinates {
  String? lat;
  String? long;

  CurrentLocationCoordinates({this.lat, this.long});

  CurrentLocationCoordinates.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    long = json['long'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['long'] = this.long;
    return data;
  }
}

// class OngoingOrderResponseModel {
//   String? status;
//   String? message;
//   String? menuProfileurl;
//   List<OrderOngoing>? orderOngoing;

//   OngoingOrderResponseModel(
//       {this.status, this.message, this.menuProfileurl, this.orderOngoing});

//   OngoingOrderResponseModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     menuProfileurl = json['menu_profileurl'];
//     if (json['order_ongoing'] != null) {
//       orderOngoing = <OrderOngoing>[];
//       json['order_ongoing'].forEach((v) {
//         orderOngoing!.add(new OrderOngoing.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['message'] = this.message;
//     data['menu_profileurl'] = this.menuProfileurl;
//     if (this.orderOngoing != null) {
//       data['order_ongoing'] =
//           this.orderOngoing!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class OrderOngoing {
//   String? id;
//   List<ProductDetails>? productDetails;
//   CustomerName? customerName;
//   HotelDetails? hotelDetails;
//   DeliveyDetails? deliveyDetails;
//   CurrentLocationCoordinates? currentLocationCoordinates;
//   String? address;
//   String? itemTotal;
//   String? total;
//   String? deliveryFee;
//   String? lat;
//   String? long;
//   String? outletId;
//   String? taxes;
//   String? deliveryDate;
//   String? status;
//   String? deliveryPartnerStatus;

//   OrderOngoing(
//       {this.id,
//       this.productDetails,
//       this.customerName,
//       this.hotelDetails,
//       this.deliveyDetails,
//       this.currentLocationCoordinates,
//       this.address,
//       this.itemTotal,
//       this.total,
//       this.deliveryFee,
//       this.lat,
//       this.long,
//       this.outletId,
//       this.taxes,
//       this.deliveryDate,
//       this.status,
//       this.deliveryPartnerStatus});

//   OrderOngoing.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     if (json['product_details'] != null) {
//       productDetails = <ProductDetails>[];
//       json['product_details'].forEach((v) {
//         productDetails!.add(new ProductDetails.fromJson(v));
//       });
//     }
//     customerName = json['customer_name'] != null
//         ? new CustomerName.fromJson(json['customer_name'])
//         : null;
//     hotelDetails = json['hotel_details'] != null
//         ? new HotelDetails.fromJson(json['hotel_details'])
//         : null;
//     deliveyDetails = json['deliveyDetails'] != null
//         ? new DeliveyDetails.fromJson(json['deliveyDetails'])
//         : null;
//     currentLocationCoordinates = json['current_location_coordinates'] != null
//         ? new CurrentLocationCoordinates.fromJson(
//             json['current_location_coordinates'])
//         : null;
//     address = json['address'];
//     itemTotal = json['item_total'];
//     total = json['total'];
//     deliveryFee = json['delivery_fee'];
//     lat = json['lat'];
//     long = json['long'];
//     outletId = json['outlet_id'];
//     taxes = json['taxes'];
//     deliveryDate = json['delivery_date'];
//     status = json['status'];
//     deliveryPartnerStatus = json['delivery_partner_status'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     if (this.productDetails != null) {
//       data['product_details'] =
//           this.productDetails!.map((v) => v.toJson()).toList();
//     }
//     if (this.customerName != null) {
//       data['customer_name'] = this.customerName!.toJson();
//     }
//     if (this.hotelDetails != null) {
//       data['hotel_details'] = this.hotelDetails!.toJson();
//     }
//     if (this.deliveyDetails != null) {
//       data['deliveyDetails'] = this.deliveyDetails!.toJson();
//     }
//     if (this.currentLocationCoordinates != null) {
//       data['current_location_coordinates'] =
//           this.currentLocationCoordinates!.toJson();
//     }
//     data['address'] = this.address;
//     data['item_total'] = this.itemTotal;
//     data['total'] = this.total;
//     data['delivery_fee'] = this.deliveryFee;
//     data['lat'] = this.lat;
//     data['long'] = this.long;
//     data['outlet_id'] = this.outletId;
//     data['taxes'] = this.taxes;
//     data['delivery_date'] = this.deliveryDate;
//     data['status'] = this.status;
//     data['delivery_partner_status'] = this.deliveryPartnerStatus;
//     return data;
//   }
// }

// class ProductDetails {
//   String? id;
//   String? productName;
//   String? productImage;
//   String? qty;
//   int? price;

//   ProductDetails(
//       {this.id, this.productName, this.productImage, this.qty, this.price});

//   ProductDetails.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     productName = json['product_name'];
//     productImage = json['product_image'];
//     qty = json['qty'];
//     price = json['price'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['product_name'] = this.productName;
//     data['product_image'] = this.productImage;
//     data['qty'] = this.qty;
//     data['price'] = this.price;
//     return data;
//   }
// }

// class CustomerName {
//   String? id;
//   String? firebaseId;
//   String? customerName;
//   String? mobile;
//   Null? password;
//   String? pwdOtp;
//   Null? addtionalNumber;
//   String? email;
//   String? addressTypeId;
//   String? selectedAddress;
//   String? address;
//   String? landMark;
//   String? floor;
//   String? reach;
//   String? lat;
//   String? long;
//   String? status;
//   String? deviceType;
//   String? deviceToken;
//   String? createdAt;

//   CustomerName(
//       {this.id,
//       this.firebaseId,
//       this.customerName,
//       this.mobile,
//       this.password,
//       this.pwdOtp,
//       this.addtionalNumber,
//       this.email,
//       this.addressTypeId,
//       this.selectedAddress,
//       this.address,
//       this.landMark,
//       this.floor,
//       this.reach,
//       this.lat,
//       this.long,
//       this.status,
//       this.deviceType,
//       this.deviceToken,
//       this.createdAt});

//   CustomerName.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     firebaseId = json['firebase_id'];
//     customerName = json['customer_name'];
//     mobile = json['mobile'];
//     password = json['password'];
//     pwdOtp = json['pwd_otp'];
//     addtionalNumber = json['addtional_number'];
//     email = json['email'];
//     addressTypeId = json['address_type_id'];
//     selectedAddress = json['selected_address'];
//     address = json['address'];
//     landMark = json['land_mark'];
//     floor = json['floor'];
//     reach = json['reach'];
//     lat = json['lat'];
//     long = json['long'];
//     status = json['status'];
//     deviceType = json['device_type'];
//     deviceToken = json['device_token'];
//     createdAt = json['created_at'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['firebase_id'] = this.firebaseId;
//     data['customer_name'] = this.customerName;
//     data['mobile'] = this.mobile;
//     data['password'] = this.password;
//     data['pwd_otp'] = this.pwdOtp;
//     data['addtional_number'] = this.addtionalNumber;
//     data['email'] = this.email;
//     data['address_type_id'] = this.addressTypeId;
//     data['selected_address'] = this.selectedAddress;
//     data['address'] = this.address;
//     data['land_mark'] = this.landMark;
//     data['floor'] = this.floor;
//     data['reach'] = this.reach;
//     data['lat'] = this.lat;
//     data['long'] = this.long;
//     data['status'] = this.status;
//     data['device_type'] = this.deviceType;
//     data['device_token'] = this.deviceToken;
//     data['created_at'] = this.createdAt;
//     return data;
//   }
// }

// class HotelDetails {
//   String? id;
//   String? type;
//   String? outletMainId;
//   String? outletSubId;
//   String? email;
//   String? password;
//   String? decryptPassword;
//   String? mobile;
//   String? pwdOtp;
//   String? image;
//   String? atharImage;
//   String? panNumber;
//   String? licenseImage;
//   String? fssaiNumber;
//   String? fssaiExpiryDate;
//   String? outletName;
//   String? outletAddress;
//   String? area;
//   String? deliveryTime;
//   String? offerSpot;
//   String? upTo;
//   Null? outletImage;
//   String? latitude;
//   String? longitude;
//   String? foodTypeId;
//   String? restaurantType;
//   Null? gstStatus;
//   Null? gstPercentage;
//   String? gstImage;
//   String? gstNumber;
//   String? carryBag;
//   String? sponsor;
//   String? orderType;
//   String? bankCheckList;
//   String? bankAccountNumber;
//   String? bankIfscCode;
//   String? bankHolderName;
//   String? description;
//   String? deviceType;
//   String? deviceToken;
//   String? status;
//   String? requestStatus;
//   String? requestAmt;
//   String? createdAt;
//   Null? updatedAt;

//   HotelDetails(
//       {this.id,
//       this.type,
//       this.outletMainId,
//       this.outletSubId,
//       this.email,
//       this.password,
//       this.decryptPassword,
//       this.mobile,
//       this.pwdOtp,
//       this.image,
//       this.atharImage,
//       this.panNumber,
//       this.licenseImage,
//       this.fssaiNumber,
//       this.fssaiExpiryDate,
//       this.outletName,
//       this.outletAddress,
//       this.area,
//       this.deliveryTime,
//       this.offerSpot,
//       this.upTo,
//       this.outletImage,
//       this.latitude,
//       this.longitude,
//       this.foodTypeId,
//       this.restaurantType,
//       this.gstStatus,
//       this.gstPercentage,
//       this.gstImage,
//       this.gstNumber,
//       this.carryBag,
//       this.sponsor,
//       this.orderType,
//       this.bankCheckList,
//       this.bankAccountNumber,
//       this.bankIfscCode,
//       this.bankHolderName,
//       this.description,
//       this.deviceType,
//       this.deviceToken,
//       this.status,
//       this.requestStatus,
//       this.requestAmt,
//       this.createdAt,
//       this.updatedAt});

//   HotelDetails.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     type = json['type'];
//     outletMainId = json['outlet_main_id'];
//     outletSubId = json['outlet_sub_id'];
//     email = json['email'];
//     password = json['password'];
//     decryptPassword = json['decrypt_password'];
//     mobile = json['mobile'];
//     pwdOtp = json['pwd_otp'];
//     image = json['image'];
//     atharImage = json['athar_image'];
//     panNumber = json['pan_number'];
//     licenseImage = json['license_image'];
//     fssaiNumber = json['fssai_number'];
//     fssaiExpiryDate = json['fssai_expiry_date'];
//     outletName = json['outlet_name'];
//     outletAddress = json['outlet_address'];
//     area = json['area'];
//     deliveryTime = json['delivery_time'];
//     offerSpot = json['offer_spot'];
//     upTo = json['up_to'];
//     outletImage = json['outlet_image'];
//     latitude = json['latitude'];
//     longitude = json['longitude'];
//     foodTypeId = json['food_type_id'];
//     restaurantType = json['restaurant_type'];
//     gstStatus = json['gst_status'];
//     gstPercentage = json['gst_percentage'];
//     gstImage = json['gst_image'];
//     gstNumber = json['gst_number'];
//     carryBag = json['carry_bag'];
//     sponsor = json['sponsor'];
//     orderType = json['order_type'];
//     bankCheckList = json['bank_check_list'];
//     bankAccountNumber = json['bank_account_number'];
//     bankIfscCode = json['bank_ifsc_code'];
//     bankHolderName = json['bank_holder_name'];
//     description = json['description'];
//     deviceType = json['device_type'];
//     deviceToken = json['device_token'];
//     status = json['status'];
//     requestStatus = json['request_status'];
//     requestAmt = json['request_amt'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['type'] = this.type;
//     data['outlet_main_id'] = this.outletMainId;
//     data['outlet_sub_id'] = this.outletSubId;
//     data['email'] = this.email;
//     data['password'] = this.password;
//     data['decrypt_password'] = this.decryptPassword;
//     data['mobile'] = this.mobile;
//     data['pwd_otp'] = this.pwdOtp;
//     data['image'] = this.image;
//     data['athar_image'] = this.atharImage;
//     data['pan_number'] = this.panNumber;
//     data['license_image'] = this.licenseImage;
//     data['fssai_number'] = this.fssaiNumber;
//     data['fssai_expiry_date'] = this.fssaiExpiryDate;
//     data['outlet_name'] = this.outletName;
//     data['outlet_address'] = this.outletAddress;
//     data['area'] = this.area;
//     data['delivery_time'] = this.deliveryTime;
//     data['offer_spot'] = this.offerSpot;
//     data['up_to'] = this.upTo;
//     data['outlet_image'] = this.outletImage;
//     data['latitude'] = this.latitude;
//     data['longitude'] = this.longitude;
//     data['food_type_id'] = this.foodTypeId;
//     data['restaurant_type'] = this.restaurantType;
//     data['gst_status'] = this.gstStatus;
//     data['gst_percentage'] = this.gstPercentage;
//     data['gst_image'] = this.gstImage;
//     data['gst_number'] = this.gstNumber;
//     data['carry_bag'] = this.carryBag;
//     data['sponsor'] = this.sponsor;
//     data['order_type'] = this.orderType;
//     data['bank_check_list'] = this.bankCheckList;
//     data['bank_account_number'] = this.bankAccountNumber;
//     data['bank_ifsc_code'] = this.bankIfscCode;
//     data['bank_holder_name'] = this.bankHolderName;
//     data['description'] = this.description;
//     data['device_type'] = this.deviceType;
//     data['device_token'] = this.deviceToken;
//     data['status'] = this.status;
//     data['request_status'] = this.requestStatus;
//     data['request_amt'] = this.requestAmt;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
// }

// class DeliveyDetails {
//   String? riderName;
//   String? riderMobile;
//   String? deliveryPartnerStatus;

//   DeliveyDetails(
//       {this.riderName, this.riderMobile, this.deliveryPartnerStatus});

//   DeliveyDetails.fromJson(Map<String, dynamic> json) {
//     riderName = json['rider_name'];
//     riderMobile = json['rider_mobile'];
//     deliveryPartnerStatus = json['delivery_partner_status'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['rider_name'] = this.riderName;
//     data['rider_mobile'] = this.riderMobile;
//     data['delivery_partner_status'] = this.deliveryPartnerStatus;
//     return data;
//   }
// }

// class CurrentLocationCoordinates {
//   Null? lat;
//   Null? long;

//   CurrentLocationCoordinates({this.lat, this.long});

//   CurrentLocationCoordinates.fromJson(Map<String, dynamic> json) {
//     lat = json['lat'];
//     long = json['long'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['lat'] = this.lat;
//     data['long'] = this.long;
//     return data;
//   }
// }

