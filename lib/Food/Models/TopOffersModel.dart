import 'dart:convert';

import 'package:flutter/foundation.dart';

class TopOfferModel {
  String? duration_lt;
  String? id;
  String? restaurant_name;
  String? category;
  String? rating;
  String? offer;
  String? up_to;
  String? image;

  TopOfferModel({
    this.duration_lt,
    this.id,
    this.restaurant_name,
    this.category,
    this.rating,
    this.offer,
    this.up_to,
    this.image,
  });

  TopOfferModel copyWith({
    String? duration_lt,
    String? id,
    String? up_to,
    String? restaurant_name,
    String? category,
    String? rating,
    String? offer,
    String? image,
  }) {
    return TopOfferModel(
      duration_lt: duration_lt ?? this.duration_lt,
      id: id ?? this.id,
      restaurant_name: restaurant_name ?? this.restaurant_name,
      up_to: up_to ?? this.up_to,
      category: category ?? this.category,
      rating: rating ?? this.rating,
      offer: offer ?? this.offer,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'duration_lt': duration_lt,
      'id': id,
      'up_to': up_to,
      'restaurant_name': restaurant_name,
      'category': category,
      'rating': rating,
      'offer': offer,
      'image': image,
    };
  }

  factory TopOfferModel.fromMap(Map<String, dynamic> map) {
    return TopOfferModel(
      duration_lt: map['duration_lt'],
      up_to: map['up_to'],
      id: map['id'],
      restaurant_name: map['restaurant_name'],
      category: map['category'],
      rating: map['rating'],
      offer: map['offer'],
      // offer: List.generate(map['offer'].length, (index) =>OffersModel()),
      image: map['image'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TopOfferModel.fromJson(String source) =>
      TopOfferModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TopOfferModel(duration_lt: $duration_lt,up_to :$up_to, id: $id, restaurant_name: $restaurant_name,offer: $offer, category: $category, rating: $rating, image: $image)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TopOfferModel &&
        other.duration_lt == duration_lt &&
        other.id == id &&
        other.up_to == up_to &&
        other.restaurant_name == restaurant_name &&
        other.category == category &&
        other.offer == offer &&
        other.rating == rating &&
        other.image == image;
  }

  @override
  int get hashCode {
    return duration_lt.hashCode ^
        id.hashCode ^
        up_to.hashCode ^
        restaurant_name.hashCode ^
        category.hashCode ^
        rating.hashCode ^
        offer.hashCode ^
        image.hashCode;
  }
}

class OffersModel {
  String? id;
  String? restaurant_name;
  String? coupon_name;
  String? percentage_amount;
  String? up_to;
  String? apply_status;

  OffersModel({
    this.id,
    this.restaurant_name,
    this.coupon_name,
    this.percentage_amount,
    this.up_to,
    this.apply_status,
  });

  OffersModel copyWith({
    String? id,
    String? restaurant_name,
    String? apply_status,
    String? coupon_name,
    String? percentage_amount,
    String? up_to,
  }) {
    return OffersModel(
      id: id ?? this.id,
      restaurant_name: restaurant_name ?? this.restaurant_name,
      apply_status: apply_status ?? this.apply_status,
      coupon_name: coupon_name ?? this.coupon_name,
      percentage_amount: percentage_amount ?? this.percentage_amount,
      up_to: up_to ?? this.up_to,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'apply_status': apply_status,
      'restaurant_name': restaurant_name,
      'coupon_name': coupon_name,
      'percentage_amount': percentage_amount,
      'up_to': up_to,
    };
  }

  factory OffersModel.fromMap(Map<String, dynamic> map) {
    return OffersModel(
      id: map['id'],
      apply_status: map['apply_status'],
      restaurant_name: map['restaurant_name'],
      coupon_name: map['coupon_name'],
      percentage_amount: map['percentage_amount'],
      up_to: map['up_to'],
    );
  }

  String toJson() => json.encode(toMap());

  factory OffersModel.fromJson(String source) =>
      OffersModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OffersModel(id: $id,apply_status :$apply_status, restaurant_name: $restaurant_name,coupon_name: $coupon_name, percentage_amount: $percentage_amount, '
        'up_to: $up_to,)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OffersModel &&
        other.id == id &&
        other.apply_status == apply_status &&
        other.restaurant_name == restaurant_name &&
        other.up_to == up_to &&
        other.percentage_amount == percentage_amount &&
        other.coupon_name == coupon_name;
  }

  @override
  int get hashCode {
    return up_to.hashCode ^
        id.hashCode ^
        apply_status.hashCode ^
        restaurant_name.hashCode ^
        percentage_amount.hashCode ^
        coupon_name.hashCode;
  }
}

class TopOfferResponseModel {
  String? status;
  String? message;
  String? restaurantBaseurl;
  List<TopOffers>? topOffers;

  TopOfferResponseModel(
      {this.status, this.message, this.restaurantBaseurl, this.topOffers});

  TopOfferResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    restaurantBaseurl = json['restaurant_baseurl'];
    if (json['top_offers'] != null) {
      topOffers = <TopOffers>[];
      json['top_offers'].forEach((v) {
        topOffers!.add(new TopOffers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['restaurant_baseurl'] = this.restaurantBaseurl;
    if (this.topOffers != null) {
      data['top_offers'] = this.topOffers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TopOffers {
  String? durationLt;
  String? id;
  String? restaurantName;
  String? restaurantAddress;
  String? category;
  String? offer;
  String? upTo;
  String? rating;
  String? image;

  TopOffers(
      {this.durationLt,
      this.id,
      this.restaurantName,
      this.restaurantAddress,
      this.category,
      this.offer,
      this.upTo,
      this.rating,
      this.image});

  TopOffers.fromJson(Map<String, dynamic> json) {
    durationLt = json['duration_lt'];
    id = json['id'];
    restaurantName = json['restaurant_name'];
    restaurantAddress = json['restaurant_address'];
    category = json['category'];
    offer = json['offer'];
    upTo = json['up_to'];
    rating = json['rating'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['duration_lt'] = this.durationLt;
    data['id'] = this.id;
    data['restaurant_name'] = this.restaurantName;
    data['restaurant_address'] = this.restaurantAddress;
    data['category'] = this.category;
    data['offer'] = this.offer;
    data['up_to'] = this.upTo;
    data['rating'] = this.rating;
    data['image'] = this.image;
    return data;
  }
}
