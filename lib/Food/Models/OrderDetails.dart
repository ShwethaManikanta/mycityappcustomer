class OrderDetails {
  String? status;
  String? message;
  String? retailerProfileurl;
  List<GetOrderList>? getOrderList;

  OrderDetails(
      {this.status, this.message, this.retailerProfileurl, this.getOrderList});

  OrderDetails.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    retailerProfileurl = json['retailer_profileurl'];
    if (json['get_order_list'] != null) {
      getOrderList = [];
      json['get_order_list'].forEach((v) {
        getOrderList!.add(new GetOrderList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['retailer_profileurl'] = this.retailerProfileurl;
    if (this.getOrderList != null) {
      data['get_order_list'] =
          this.getOrderList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetOrderList {
  String? id;
  List<ProductDetails>? productDetails;
  CustomerName? customerName;
  HotelDetails? hotelDetails;
  DriverDetails? driverDetails;
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

  GetOrderList(
      {this.id,
      this.productDetails,
      this.customerName,
      this.hotelDetails,
      this.driverDetails,
      this.address,
      this.itemTotal,
      this.total,
      this.deliveryFee,
      this.lat,
      this.long,
      this.outletId,
      this.taxes,
      this.deliveryDate,
      this.status});

  GetOrderList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['product_details'] != null) {
      productDetails = [];
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
    driverDetails = json['driver_details'] != null
        ? new DriverDetails.fromJson(json['driver_details'])
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
    if (this.driverDetails != null) {
      data['driver_details'] = this.driverDetails!.toJson();
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
    return data;
  }
}

class ProductDetails {
  String? id;
  String? productName;
  String? qty;
  int? price;

  ProductDetails({this.id, this.productName, this.qty, this.price});

  ProductDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productName = json['product_name'];
    qty = json['qty'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_name'] = this.productName;
    data['qty'] = this.qty;
    data['price'] = this.price;
    return data;
  }
}

class CustomerName {
  String? id;
  String? customerName;
  String? mobile;
  String? password;
  String? pwdOtp;
  Null addtionalNumber;
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
  String? email;
  String? password;
  String? decryptPassword;
  String? mobile;
  String? pwdOtp;
  String? image;
  String? atharImage;
  String? licenseImage;
  String? outletName;
  String? outletAddress;
  String? deliveryTime;
  String? offerSpot;
  String? upTo;
  Null outletImage;
  String? latitude;
  String? longitude;
  String? foodTypeId;
  Null gstStatus;
  Null gstPercentage;
  String? gstNumber;
  String? sponsor;
  String? orderType;
  String? deviceToken;
  String? status;
  String? requestStatus;
  String? requestAmt;
  String? createdAt;
  Null updatedAt;

  HotelDetails(
      {this.id,
      this.email,
      this.password,
      this.decryptPassword,
      this.mobile,
      this.pwdOtp,
      this.image,
      this.atharImage,
      this.licenseImage,
      this.outletName,
      this.outletAddress,
      this.deliveryTime,
      this.offerSpot,
      this.upTo,
      this.outletImage,
      this.latitude,
      this.longitude,
      this.foodTypeId,
      this.gstStatus,
      this.gstPercentage,
      this.gstNumber,
      this.sponsor,
      this.orderType,
      this.deviceToken,
      this.status,
      this.requestStatus,
      this.requestAmt,
      this.createdAt,
      this.updatedAt});

  HotelDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    password = json['password'];
    decryptPassword = json['decrypt_password'];
    mobile = json['mobile'];
    pwdOtp = json['pwd_otp'];
    image = json['image'];
    atharImage = json['athar_image'];
    licenseImage = json['license_image'];
    outletName = json['outlet_name'];
    outletAddress = json['outlet_address'];
    deliveryTime = json['delivery_time'];
    offerSpot = json['offer_spot'];
    upTo = json['up_to'];
    outletImage = json['outlet_image'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    foodTypeId = json['food_type_id'];
    gstStatus = json['gst_status'];
    gstPercentage = json['gst_percentage'];
    gstNumber = json['gst_number'];
    sponsor = json['sponsor'];
    orderType = json['order_type'];
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
    data['email'] = this.email;
    data['password'] = this.password;
    data['decrypt_password'] = this.decryptPassword;
    data['mobile'] = this.mobile;
    data['pwd_otp'] = this.pwdOtp;
    data['image'] = this.image;
    data['athar_image'] = this.atharImage;
    data['license_image'] = this.licenseImage;
    data['outlet_name'] = this.outletName;
    data['outlet_address'] = this.outletAddress;
    data['delivery_time'] = this.deliveryTime;
    data['offer_spot'] = this.offerSpot;
    data['up_to'] = this.upTo;
    data['outlet_image'] = this.outletImage;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['food_type_id'] = this.foodTypeId;
    data['gst_status'] = this.gstStatus;
    data['gst_percentage'] = this.gstPercentage;
    data['gst_number'] = this.gstNumber;
    data['sponsor'] = this.sponsor;
    data['order_type'] = this.orderType;
    data['device_token'] = this.deviceToken;
    data['status'] = this.status;
    data['request_status'] = this.requestStatus;
    data['request_amt'] = this.requestAmt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class DriverDetails {
  String? id;
  String? deliveryBoyName;
  String? profile;
  String? email;
  String? mobile;
  String? password;
  String? decryptPassword;
  String? address;
  String? addressProf;
  String? drivingLicense;
  String? insurance;
  String? vehicleNo;
  String? rc;
  String? additionalMobile;
  String? latitude;
  String? longitude;
  String? status;
  String? deviceType;
  String? deviceToken;
  String? createdAt;
  String? updatedAt;
  String? onlineStatus;

  DriverDetails(
      {this.id,
      this.deliveryBoyName,
      this.profile,
      this.email,
      this.mobile,
      this.password,
      this.decryptPassword,
      this.address,
      this.addressProf,
      this.drivingLicense,
      this.insurance,
      this.vehicleNo,
      this.rc,
      this.additionalMobile,
      this.latitude,
      this.longitude,
      this.status,
      this.deviceType,
      this.deviceToken,
      this.createdAt,
      this.updatedAt,
      this.onlineStatus});

  DriverDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    deliveryBoyName = json['delivery_boy_name'];
    profile = json['profile'];
    email = json['email'];
    mobile = json['mobile'];
    password = json['password'];
    decryptPassword = json['decrypt_password'];
    address = json['address'];
    addressProf = json['address_prof'];
    drivingLicense = json['driving_license'];
    insurance = json['insurance'];
    vehicleNo = json['vehicle_no'];
    rc = json['rc'];
    additionalMobile = json['additional_mobile'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    status = json['status'];
    deviceType = json['device_type'];
    deviceToken = json['device_token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    onlineStatus = json['online_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['delivery_boy_name'] = this.deliveryBoyName;
    data['profile'] = this.profile;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['password'] = this.password;
    data['decrypt_password'] = this.decryptPassword;
    data['address'] = this.address;
    data['address_prof'] = this.addressProf;
    data['driving_license'] = this.drivingLicense;
    data['insurance'] = this.insurance;
    data['vehicle_no'] = this.vehicleNo;
    data['rc'] = this.rc;
    data['additional_mobile'] = this.additionalMobile;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['status'] = this.status;
    data['device_type'] = this.deviceType;
    data['device_token'] = this.deviceToken;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['online_status'] = this.onlineStatus;
    return data;
  }
}
