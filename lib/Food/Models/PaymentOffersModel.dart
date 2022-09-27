import 'dart:convert';

import 'package:mycityapp/Food/Models/TopOffersModel.dart';

class PaymentOfferModel {
  String? status;
  String? message;
  String? restaurant_baseurl;
  List<OffersModel>? payment_offers;

  PaymentOfferModel(
      {this.payment_offers,
      this.status,
      this.message,
      this.restaurant_baseurl});

  PaymentOfferModel copyWith(
      {String? status,
      String? message,
      String? user_id,
      OffersModel? payment_offers}) {
    return PaymentOfferModel(
      status: status ?? this.status,
      message: message ?? this.message,
      restaurant_baseurl: restaurant_baseurl ?? this.restaurant_baseurl,
      payment_offers:
          payment_offers as List<OffersModel>? ?? this.payment_offers,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'message': message,
      'restaurant_baseurl': restaurant_baseurl,
      'payment_offers': payment_offers,
    };
  }

  factory PaymentOfferModel.fromMap(Map<String, dynamic> map) {
    return PaymentOfferModel(
        status: map['status'],
        message: map['message'],
        restaurant_baseurl: map['restaurant_baseurl'],
        payment_offers: List.generate(
          map['payment_offers'].length,
          (index) => OffersModel(
              id: map['payment_offers'][index]['id'],
              coupon_name: map['payment_offers'][index]['coupon_name'],
              percentage_amount: map['payment_offers'][index]
                  ['percentage_amount'],
              restaurant_name: map['payment_offers'][index]['restaurant_name'],
              apply_status: map['payment_offers'][index]['apply_status'],
              up_to: map['payment_offers'][index]['up_to']),
        ).toList());
  }

  String toJson() => json.encode(toMap());

  factory PaymentOfferModel.fromJson(String source) =>
      PaymentOfferModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(status: $status, message: $message, restaurant_baseurl: $restaurant_baseurl, payment_offers: $payment_offers'
        ')';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PaymentOfferModel &&
        other.status == status &&
        other.message == message &&
        other.restaurant_baseurl == restaurant_baseurl &&
        other.payment_offers == payment_offers;
  }

  @override
  int get hashCode {
    return status.hashCode ^
        message.hashCode ^
        restaurant_baseurl.hashCode ^
        payment_offers.hashCode;
  }
}
