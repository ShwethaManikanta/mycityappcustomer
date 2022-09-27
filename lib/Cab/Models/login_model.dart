import 'dart:convert';

class LoginRequest {
  late int mobile;
  late int otp;
  LoginRequest({
    required this.mobile,
    required this.otp,
  });

  LoginRequest copyWith({
    int? mobile,
    int? otp,
  }) {
    return LoginRequest(
      mobile: mobile ?? this.mobile,
      otp: otp ?? this.otp,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'mobile': mobile,
      'otp': otp,
    };
  }

  factory LoginRequest.fromMap(Map<String, dynamic> map) {
    return LoginRequest(
      mobile: map['mobile'],
      otp: map['otp'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginRequest.fromJson(String source) =>
      LoginRequest.fromMap(json.decode(source));

  @override
  String toString() => 'LoginRequest(mobile: $mobile, otp: $otp)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LoginRequest && other.mobile == mobile && other.otp == otp;
  }

  @override
  int get hashCode => mobile.hashCode ^ otp.hashCode;
}

// ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
class LoginRespones {
  late String status;
  late String message;
  late String errorCode;
  late Data data;
  LoginRespones({
    required this.status,
    required this.message,
    required this.errorCode,
    required this.data,
  });

  LoginRespones copyWith({
    String? status,
    String? message,
    String? errorCode,
    Data? data,
  }) {
    return LoginRespones(
      status: status ?? this.status,
      message: message ?? this.message,
      errorCode: errorCode ?? this.errorCode,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'message': message,
      'errorCode': errorCode,
      'data': data.toMap(),
    };
  }

  factory LoginRespones.fromMap(Map<String, dynamic> map) {
    return LoginRespones(
      status: map['status'],
      message: map['message'],
      errorCode: map['errorCode'],
      data: Data.fromMap(map['data']),
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginRespones.fromJson(String source) =>
      LoginRespones.fromMap(json.decode(source));

  @override
  String toString() {
    return 'LoginRespones(status: $status, message: $message, errorCode: $errorCode, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LoginRespones &&
        other.status == status &&
        other.message == message &&
        other.errorCode == errorCode &&
        other.data == data;
  }

  @override
  int get hashCode {
    return status.hashCode ^
        message.hashCode ^
        errorCode.hashCode ^
        data.hashCode;
  }
}

class Data {
  late String userId;
  late String name;
  late String email;
  late String mobile;
  Data({
    required this.userId,
    required this.name,
    required this.email,
    required this.mobile,
  });

  Data copyWith({
    String? userId,
    String? name,
    String? email,
    String? mobile,
  }) {
    return Data(
      userId: userId ?? this.userId,
      name: name ?? this.name,
      email: email ?? this.email,
      mobile: mobile ?? this.mobile,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'name': name,
      'email': email,
      'mobile': mobile,
    };
  }

  factory Data.fromMap(Map<String, dynamic> map) {
    return Data(
      userId: map['user_id'],
      name: map['name'],
      email: map['email'],
      mobile: map['mobile'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Data.fromJson(String source) => Data.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Data(user_id: $userId, name: $name, email: $email, mobile: $mobile)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Data &&
        other.userId == userId &&
        other.name == name &&
        other.email == email &&
        other.mobile == mobile;
  }

  @override
  int get hashCode {
    return userId.hashCode ^ name.hashCode ^ email.hashCode ^ mobile.hashCode;
  }
}

class LoginResponseModel {
  String? status;
  String? message;
  String? driverId;
  UserDetails? userDetails;

  LoginResponseModel(
      {this.status, this.message, this.driverId, this.userDetails});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    driverId = json['driver_id'];
    userDetails = json['user_details'] != null
        ? new UserDetails.fromJson(json['user_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['driver_id'] = this.driverId;
    if (this.userDetails != null) {
      data['user_details'] = this.userDetails!.toJson();
    }
    return data;
  }
}

class UserDetails {
  String? id;
  String? languageType;
  String? countryId;
  String? userName;
  String? mobile;
  String? email;
  String? password;
  String? decryptPassword;
  String? pwdOtp;
  String? dob;
  String? address;
  String? atharImage;
  String? pancardImage;
  String? drivingLicense;
  String? voterImage;
  String? deviceType;
  String? deviceToken;
  String? status;
  String? createdAt;
  String? updatedAt;

  UserDetails(
      {this.id,
      this.languageType,
      this.countryId,
      this.userName,
      this.mobile,
      this.email,
      this.password,
      this.decryptPassword,
      this.pwdOtp,
      this.dob,
      this.address,
      this.atharImage,
      this.pancardImage,
      this.drivingLicense,
      this.voterImage,
      this.deviceType,
      this.deviceToken,
      this.status,
      this.createdAt,
      this.updatedAt});

  UserDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    languageType = json['language_type'];
    countryId = json['country_id'];
    userName = json['user_name'];
    mobile = json['mobile'];
    email = json['email'];
    password = json['password'];
    decryptPassword = json['decrypt password'];
    pwdOtp = json['pwd_otp'];
    dob = json['dob'];
    address = json['address'];
    atharImage = json['athar_image'];
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
    data['language_type'] = this.languageType;
    data['country_id'] = this.countryId;
    data['user_name'] = this.userName;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['password'] = this.password;
    data['decrypt password'] = this.decryptPassword;
    data['pwd_otp'] = this.pwdOtp;
    data['dob'] = this.dob;
    data['address'] = this.address;
    data['athar_image'] = this.atharImage;
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
