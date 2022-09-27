import 'dart:convert';

import 'package:flutter/material.dart';

class DishesList {
  String? duration_lt;
  String? id;
  String? dishes_name;
  String? image;
  dynamic price;
  String? discount_amount;

  DishesList(
      {this.duration_lt,
      this.id,
      this.dishes_name,
      this.image,
      this.price,
      this.discount_amount});

  DishesList copyWith({
    String? duration_lt,
    String? id,
    String? dishes_name,
    String? image,
    dynamic price,
    String? discount_amount,
  }) {
    return DishesList(
        duration_lt: duration_lt ?? this.duration_lt,
        id: id ?? this.id,
        dishes_name: dishes_name ?? this.dishes_name,
        image: image ?? this.image,
        price: price ?? this.price,
        discount_amount: discount_amount ?? this.discount_amount);
  }

  Map<String, dynamic> toMap() {
    return {
      'duration_lt': duration_lt,
      'id': id,
      'dishes_name': dishes_name,
      'image': image,
      'price': price,
      'discount_amount': discount_amount
    };
  }

  factory DishesList.fromMap(Map<String, dynamic> map) {
    return DishesList(
        duration_lt: map['duration_lt'],
        id: map['id'],
        dishes_name: map['dishes_name'],
        image: map['image'],
        price: map['price'],
        discount_amount: map['discount_amount']);
  }

  String toJson() => json.encode(toMap());

  factory DishesList.fromJson(String source) =>
      DishesList.fromMap(json.decode(source));

  @override
  String toString() {
    return 'DishesList(duration_lt: $duration_lt, id: $id, dishes_name: $dishes_name, image: $image, price: $price, discount_amount: $discount_amount)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DishesList &&
        other.duration_lt == duration_lt &&
        other.id == id &&
        other.dishes_name == dishes_name &&
        other.price == price &&
        other.discount_amount == discount_amount &&
        other.image == image;
  }

  @override
  int get hashCode {
    return duration_lt.hashCode ^
        id.hashCode ^
        dishes_name.hashCode ^
        price.hashCode ^
        discount_amount.hashCode ^
        image.hashCode;
  }
}

class BeverageResponseModel {
  String? status;
  String? message;
  String? menuBaseurl;
  List<NewArrival>? newArrival;

  BeverageResponseModel(
      {this.status, this.message, this.menuBaseurl, this.newArrival});

  BeverageResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    menuBaseurl = json['menu_baseurl'];
    if (json['newArrival'] != null) {
      newArrival = <NewArrival>[];
      json['newArrival'].forEach((v) {
        newArrival!.add(new NewArrival.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['menu_baseurl'] = this.menuBaseurl;
    if (this.newArrival != null) {
      data['newArrival'] = this.newArrival!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NewArrival {
  String? durationLt;
  String? id;
  String? dishesName;
  String? image;
  String? price;
  String? discountAmount;

  NewArrival(
      {this.durationLt,
      this.id,
      this.dishesName,
      this.image,
      this.price,
      this.discountAmount});

  NewArrival.fromJson(Map<String, dynamic> json) {
    durationLt = json['duration_lt'];
    id = json['id'];
    dishesName = json['dishes_name'];
    image = json['image'];
    price = json['price'];
    discountAmount = json['discount_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['duration_lt'] = this.durationLt;
    data['id'] = this.id;
    data['dishes_name'] = this.dishesName;
    data['image'] = this.image;
    data['price'] = this.price;
    data['discount_amount'] = this.discountAmount;
    return data;
  }
}
