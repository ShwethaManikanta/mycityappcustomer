class EditProfileRequestModel {
  final String userId, userName, email, mobile, address, lat, long;

  EditProfileRequestModel(
      {required this.userId,
      required this.userName,
      required this.email,
      required this.mobile,
      required this.address,
      required this.lat,
      required this.long});

  toMap() {
    return {
      'user_id': userId,
      'user_name': userName,
      'email': email,
      'mobile': mobile,
      'address': address,
      'lat': lat,
      'long': long
    };
  }

  onlyUserNameMap() {
    return {
      'user_id': userId,
      'email': email,
      'address': address,
      'lat': lat,
      'long': long
    };
  }
}

class EditProfileResponseModel {
  String? status;
  String? message;
  UserDetails? userDetails;

  EditProfileResponseModel({this.status, this.message, this.userDetails});

  EditProfileResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    userDetails = json['user_details'] != null
        ? new UserDetails.fromJson(json['user_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.userDetails != null) {
      data['user_details'] = this.userDetails!.toJson();
    }
    return data;
  }
}

class UserDetails {
  String? id;
  String? firebaseId;
  String? customerName;
  String? mobile;
  String? password;
  String? pwdOtp;
  String? addtionalNumber;
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

  UserDetails(
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

  UserDetails.fromJson(Map<String, dynamic> json) {
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
