


class VehicleCategoriesResponseModel {
  String? status;
  String? message;
  String? vehicleBaseurl;
  ContactDetails? contactDetails;
  String? waitingCharge;
  String? kmLimitStatus;
  String? outerState;
  String? outerCharge;
  LabourDetails? labourDetails;
  List<VehicleList>? vehicleList;

  VehicleCategoriesResponseModel(
      {this.status,
        this.message,
        this.vehicleBaseurl,
        this.contactDetails,
        this.waitingCharge,
        this.kmLimitStatus,
        this.outerState,
        this.outerCharge,
        this.labourDetails,
        this.vehicleList});

  VehicleCategoriesResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    vehicleBaseurl = json['vehicle_baseurl'];
    contactDetails = json['contact_details'] != null
        ? new ContactDetails.fromJson(json['contact_details'])
        : null;
    waitingCharge = json['waiting_charge'];
    kmLimitStatus = json['km_limit_status'];
    outerState = json['outer_state'];
    outerCharge = json['outer_charge'];
    labourDetails = json['labour_details'] != null
        ? new LabourDetails.fromJson(json['labour_details'])
        : null;
    if (json['vehicle_list'] != null) {
      vehicleList = <VehicleList>[];
      json['vehicle_list'].forEach((v) {
        vehicleList!.add(new VehicleList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['vehicle_baseurl'] = this.vehicleBaseurl;
    if (this.contactDetails != null) {
      data['contact_details'] = this.contactDetails!.toJson();
    }
    data['waiting_charge'] = this.waitingCharge;
    data['km_limit_status'] = this.kmLimitStatus;
    data['outer_state'] = this.outerState;
    data['outer_charge'] = this.outerCharge;
    if (this.labourDetails != null) {
      data['labour_details'] = this.labourDetails!.toJson();
    }
    if (this.vehicleList != null) {
      data['vehicle_list'] = this.vehicleList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ContactDetails {
  String? id;
  String? firebaseId;
  String? languageType;
  String? countryId;
  String? userName;
  String? mobile;
  String? orderMobile;
  String? email;
  String? password;
  String? decryptPassword;
  String? pwdOtp;
  String? dob;
  String? address;
  String? atharImage;
  String? profileImage;
  String? pancardImage;
  String? drivingLicense;
  String? voterImage;
  String? deviceType;
  String? deviceToken;
  String? status;
  String? createdAt;
  String? updatedAt;

  ContactDetails(
      {this.id,
        this.firebaseId,
        this.languageType,
        this.countryId,
        this.userName,
        this.mobile,
        this.orderMobile,
        this.email,
        this.password,
        this.decryptPassword,
        this.pwdOtp,
        this.dob,
        this.address,
        this.atharImage,
        this.profileImage,
        this.pancardImage,
        this.drivingLicense,
        this.voterImage,
        this.deviceType,
        this.deviceToken,
        this.status,
        this.createdAt,
        this.updatedAt});

  ContactDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firebaseId = json['firebase_id'];
    languageType = json['language_type'];
    countryId = json['country_id'];
    userName = json['user_name'];
    mobile = json['mobile'];
    orderMobile = json['order_mobile'];
    email = json['email'];
    password = json['password'];
    decryptPassword = json['decrypt_password'];
    pwdOtp = json['pwd_otp'];
    dob = json['dob'];
    address = json['address'];
    atharImage = json['athar_image'];
    profileImage = json['profile_image'];
    pancardImage = json['pancard_image'];
    drivingLicense = json['driving_license'];
    voterImage = json['voter_image'];
    deviceType = json['device_type'];
    deviceToken = json['device_token'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firebase_id'] = this.firebaseId;
    data['language_type'] = this.languageType;
    data['country_id'] = this.countryId;
    data['user_name'] = this.userName;
    data['mobile'] = this.mobile;
    data['order_mobile'] = this.orderMobile;
    data['email'] = this.email;
    data['password'] = this.password;
    data['decrypt_password'] = this.decryptPassword;
    data['pwd_otp'] = this.pwdOtp;
    data['dob'] = this.dob;
    data['address'] = this.address;
    data['athar_image'] = this.atharImage;
    data['profile_image'] = this.profileImage;
    data['pancard_image'] = this.pancardImage;
    data['driving_license'] = this.drivingLicense;
    data['voter_image'] = this.voterImage;
    data['device_type'] = this.deviceType;
    data['device_token'] = this.deviceToken;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class LabourDetails {
  String? id;
  String? price;
  String? limit;
  String? status;
  String? createdAt;

  LabourDetails({this.id, this.price, this.limit, this.status, this.createdAt});

  LabourDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    limit = json['limit'];
    status = json['status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['price'] = this.price;
    data['limit'] = this.limit;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class VehicleList {
  String? id;
  String? wheeler;
  String? image;
  String? capacity;
  String? size;
  List<String>? description;
  String? pricePerKm;
  String? vehiclePrice;
  String? totalKm;
  String? time;
  String? labour;
  String? labourQty;
  String? labourTotal;
  String? gst;
  String? withoutGst;
  String? totalPrice;
  String? outerState;
  String? outerCharge;

  VehicleList(
      {this.id,
        this.wheeler,
        this.image,
        this.capacity,
        this.size,
        this.description,
        this.pricePerKm,
        this.vehiclePrice,
        this.totalKm,
        this.time,
        this.labour,
        this.labourQty,
        this.labourTotal,
        this.gst,
        this.withoutGst,
        this.totalPrice,
        this.outerState,
        this.outerCharge});

  VehicleList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    wheeler = json['wheeler'];
    image = json['image'];
    capacity = json['capacity'];
    size = json['size'];
    description = json['description'].cast<String>();
    pricePerKm = json['price_per_km'];
    vehiclePrice = json['vehicle_price'];
    totalKm = json['total_km'];
    time = json['time'];
    labour = json['labour'];
    labourQty = json['labour_qty'];
    labourTotal = json['labour_total'];
    gst = json['gst'];
    withoutGst = json['without_gst'];
    totalPrice = json['total_price'];
    outerState = json['outer_state'];
    outerCharge = json['outer_charge'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['wheeler'] = this.wheeler;
    data['image'] = this.image;
    data['capacity'] = this.capacity;
    data['size'] = this.size;
    data['description'] = this.description;
    data['price_per_km'] = this.pricePerKm;
    data['vehicle_price'] = this.vehiclePrice;
    data['total_km'] = this.totalKm;
    data['time'] = this.time;
    data['labour'] = this.labour;
    data['labour_qty'] = this.labourQty;
    data['labour_total'] = this.labourTotal;
    data['gst'] = this.gst;
    data['without_gst'] = this.withoutGst;
    data['total_price'] = this.totalPrice;
    data['outer_state'] = this.outerState;
    data['outer_charge'] = this.outerCharge;
    return data;
  }
}












////// OlD MODEL

/*
class VehicleCategoriesResponseModel {
  String? status;
  String? message;
  String? vehicleBaseurl;
  ContactDetails? contactDetails;
  String? kmLimitStatus;
  String? outerState;
  String? outerCharge;
  LabourDetails? labourDetails;
  List<VehicleList>? vehicleList;
  String? waitingCharge;

  VehicleCategoriesResponseModel(
      {this.status,
      this.message,
      this.vehicleBaseurl,
      this.contactDetails,
        this.kmLimitStatus,
      this.outerState,
      this.outerCharge,
      this.waitingCharge,
      this.labourDetails,
      this.vehicleList});

  VehicleCategoriesResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    vehicleBaseurl = json['vehicle_baseurl'];
    contactDetails = json['contact_details'] != null
        ? new ContactDetails.fromJson(json['contact_details'])
        : null;
    waitingCharge = json['waiting_charge'] ?? "0";

    kmLimitStatus = json['km_limit_status'];
    outerState = json['outer_state'];
    outerCharge = json['outer_charge'];
    labourDetails = json['labour_details'] != null
        ? new LabourDetails.fromJson(json['labour_details'])
        : null;
    if (json['vehicle_list'] != null) {
      vehicleList = <VehicleList>[];
      json['vehicle_list'].forEach((v) {
        vehicleList!.add(new VehicleList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['vehicle_baseurl'] = this.vehicleBaseurl;
    if (this.contactDetails != null) {
      data['contact_details'] = this.contactDetails!.toJson();
    }
    data['km_limit_status'] = this.kmLimitStatus;
    data['outer_state'] = this.outerState;
    data['outer_charge'] = this.outerCharge;
    if (this.labourDetails != null) {
      data['labour_details'] = this.labourDetails!.toJson();
    }
    if (this.vehicleList != null) {
      data['vehicle_list'] = this.vehicleList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ContactDetails {
  String? id;
  String? firebaseId;
  String? languageType;
  String? countryId;
  String? userName;
  String? mobile;
  String? orderMobile;
  String? email;
  String? password;
  String? decryptPassword;
  String? pwdOtp;
  String? dob;
  String? address;
  String? atharImage;
  String? profileImage;
  String? pancardImage;
  String? drivingLicense;
  String? voterImage;
  String? deviceType;
  String? deviceToken;
  String? status;
  String? createdAt;
  String? updatedAt;

  ContactDetails(
      {this.id,
      this.firebaseId,
      this.languageType,
      this.countryId,
      this.userName,
      this.mobile,
      this.orderMobile,
      this.email,
      this.password,
      this.decryptPassword,
      this.pwdOtp,
      this.dob,
      this.address,
      this.atharImage,
      this.profileImage,
      this.pancardImage,
      this.drivingLicense,
      this.voterImage,
      this.deviceType,
      this.deviceToken,
      this.status,
      this.createdAt,
      this.updatedAt});

  ContactDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firebaseId = json['firebase_id'];
    languageType = json['language_type'];
    countryId = json['country_id'];
    userName = json['user_name'];
    mobile = json['mobile'];
    orderMobile = json['order_mobile'];
    email = json['email'];
    password = json['password'];
    decryptPassword = json['decrypt_password'];
    pwdOtp = json['pwd_otp'];
    dob = json['dob'];
    address = json['address'];
    atharImage = json['athar_image'];
    profileImage = json['profile_image'];
    pancardImage = json['pancard_image'];
    drivingLicense = json['driving_license'];
    voterImage = json['voter_image'];
    deviceType = json['device_type'];
    deviceToken = json['device_token'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firebase_id'] = this.firebaseId;
    data['language_type'] = this.languageType;
    data['country_id'] = this.countryId;
    data['user_name'] = this.userName;
    data['mobile'] = this.mobile;
    data['order_mobile'] = this.orderMobile;
    data['email'] = this.email;
    data['password'] = this.password;
    data['decrypt_password'] = this.decryptPassword;
    data['pwd_otp'] = this.pwdOtp;
    data['dob'] = this.dob;
    data['address'] = this.address;
    data['athar_image'] = this.atharImage;
    data['profile_image'] = this.profileImage;
    data['pancard_image'] = this.pancardImage;
    data['driving_license'] = this.drivingLicense;
    data['voter_image'] = this.voterImage;
    data['device_type'] = this.deviceType;
    data['device_token'] = this.deviceToken;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class LabourDetails {
  String? id;
  String? price;
  String? limit;
  String? status;
  String? createdAt;

  LabourDetails({this.id, this.price, this.limit, this.status, this.createdAt});

  LabourDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    limit = json['limit'];
    status = json['status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['price'] = this.price;
    data['limit'] = this.limit;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class VehicleList {
  String? id;
  String? wheeler;
  String? image;
  String? capacity;
  String? size;
  List<String>? description;
  String? pricePerKm;
  String? vehiclePrice;
  String? totalKm;
  String? time;
  String? labour;
  String? labourQty;
  String? labourTotal;
  String? totalPrice;
  String? outerState;
  String? outerCharge;
  String? gst;
  String? withoutGst;

  VehicleList(
      {this.id,
      this.wheeler,
      this.image,
      this.capacity,
      this.size,
      this.description,
      this.pricePerKm,
      this.vehiclePrice,
      this.totalKm,
      this.gst,
      this.withoutGst,
      this.time,
      this.labour,
      this.labourQty,
      this.labourTotal,
      this.totalPrice,
      this.outerState,
      this.outerCharge});

  VehicleList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    wheeler = json['wheeler'];
    image = json['image'];
    capacity = json['capacity'];
    size = json['size'];
    description = json['description'].cast<String>();
    pricePerKm = json['price_per_km'];
    vehiclePrice = json['vehicle_price'];
    totalKm = json['total_km'];
    time = json['time'];
    labour = json['labour'];
    gst = json['gst'];
    withoutGst = json['without_gst'];
    labourQty = json['labour_qty'];
    labourTotal = json['labour_total'];
    totalPrice = json['total_price'];
    outerState = json['outer_state'];
    outerCharge = json['outer_charge'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = this.id;
    data['wheeler'] = this.wheeler;
    data['image'] = this.image;
    data['capacity'] = this.capacity;
    data['size'] = this.size;
    data['description'] = this.description;
    data['price_per_km'] = this.pricePerKm;
    data['vehicle_price'] = this.vehiclePrice;
    data['total_km'] = this.totalKm;
    data['time'] = this.time;
    data['labour'] = this.labour;
    data['labour_qty'] = this.labourQty;
    data['labour_total'] = this.labourTotal;
    data['total_price'] = this.totalPrice;
    data['outer_state'] = this.outerState;
    data['outer_charge'] = this.outerCharge;
    return data;
  }
}
*/
