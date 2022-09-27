import 'dart:convert';

import 'package:flutter/foundation.dart';

class TakeAwayModel {
  String? durationLt;
  String? id;
  String? restaurantName;
  String? restaurantAddress;
  String? category;
  String? rating;
  String? offer;
  String? up_to;
  String? status;
  String? image;

  TakeAwayModel(
      {this.durationLt,
      this.id,
      this.restaurantName,
      this.category,
      this.restaurantAddress,
      this.rating,
      this.up_to,
      this.offer,
      this.image,
      this.status});

  TakeAwayModel copyWith({
    String? durationLt,
    String? id,
    String? restaurantName,
    String? restaurantAddress,
    String? category,
    String? rating,
    String? offer,
    String? up_to,
    String? status,
    String? image,
  }) {
    return TakeAwayModel(
        durationLt: durationLt ?? this.durationLt,
        id: id ?? this.id,
        restaurantName: restaurantName ?? this.restaurantName,
        restaurantAddress: restaurantAddress ?? this.restaurantAddress,
        category: category ?? this.category,
        up_to: up_to ?? this.up_to,
        offer: offer ?? this.offer,
        rating: rating ?? this.rating,
        image: image ?? this.image,
        status: status ?? this.status);
  }

  Map<String, dynamic> toMap() {
    return {
      'duration_lt': durationLt,
      'id': id,
      'restaurant_name': restaurantName,
      'up_to': up_to,
      'status': status,
      'restaurant_address': restaurantAddress,
      'offer': offer,
      'category': category,
      'rating': rating,
      'image': image,
    };
  }

  factory TakeAwayModel.fromMap(Map<String, dynamic> map) {
    return TakeAwayModel(
      durationLt: map['duration_lt'],
      id: map['id'],
      up_to: map['up_to'],
      offer: map['offer'],
      status: map['status'],
      restaurantName: map['restaurant_name'],
      restaurantAddress: map['restaurant_address'],
      category: map['category'],
      rating: map['rating'],
      image: map['image'],
      // image: List.generate(map['image'].length, (index) => map['image'][index]["file_name"]),
    );
  }

  String toJson() => json.encode(toMap());

  factory TakeAwayModel.fromJson(String source) =>
      TakeAwayModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TakeAwayModel(durationLt: $durationLt, id: $id,status :$status,offer : $offer,up_to :$up_to,restaurantAddress :$restaurantAddress, restaurantName: $restaurantName, category: $category, rating: $rating, image: $image)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TakeAwayModel &&
        other.durationLt == durationLt &&
        other.id == id &&
        other.status == status &&
        other.up_to == up_to &&
        other.offer == offer &&
        other.restaurantName == restaurantName &&
        other.restaurantAddress == restaurantAddress &&
        other.category == category &&
        other.rating == rating &&
        other.image == image;
  }

  @override
  int get hashCode {
    return durationLt.hashCode ^
        id.hashCode ^
        up_to.hashCode ^
        offer.hashCode ^
        restaurantName.hashCode ^
        restaurantAddress.hashCode ^
        category.hashCode ^
        rating.hashCode ^
        image.hashCode;
  }
}

class TakeAwayResponseModel {
  String? status;
  String? message;
  String? restaurantBaseurl;
  List<NewArrival>? newArrival;

  TakeAwayResponseModel(
      {this.status, this.message, this.restaurantBaseurl, this.newArrival});

  TakeAwayResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    restaurantBaseurl = json['restaurant_baseurl'];
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
    data['restaurant_baseurl'] = this.restaurantBaseurl;
    if (this.newArrival != null) {
      data['newArrival'] = this.newArrival!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NewArrival {
  String? durationLt;
  String? id;
  String? restaurantName;
  String? restaurantAddress;
  String? category;
  String? rating;
  String? offer;
  String? upTo;
  String? image;
  String? status;

  NewArrival(
      {this.durationLt,
      this.id,
      this.restaurantName,
      this.restaurantAddress,
      this.category,
      this.rating,
      this.offer,
      this.upTo,
      this.image,
      this.status});

  NewArrival.fromJson(Map<String, dynamic> json) {
    durationLt = json['duration_lt'];
    id = json['id'];
    restaurantName = json['restaurant_name'];
    restaurantAddress = json['restaurant_address'];
    category = json['category'];
    rating = json['rating'];
    offer = json['offer'];
    upTo = json['up_to'];
    image = json['image'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['duration_lt'] = this.durationLt;
    data['id'] = this.id;
    data['restaurant_name'] = this.restaurantName;
    data['restaurant_address'] = this.restaurantAddress;
    data['category'] = this.category;
    data['rating'] = this.rating;
    data['offer'] = this.offer;
    data['up_to'] = this.upTo;
    data['image'] = this.image;
    data['status'] = this.status;
    return data;
  }
}
