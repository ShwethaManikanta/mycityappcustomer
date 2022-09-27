import 'dart:convert';

import 'package:flutter/foundation.dart';

class PopularRestaurantModel {
  String? durationLt;
  String? id;
  String? restaurantName;
  String? category;
  String? rating;
  String? offer;
  String? image;
  String? up_to;

  PopularRestaurantModel({
    this.durationLt,
    this.id,
    this.restaurantName,
    this.category,
    this.rating,
    this.offer,
    this.up_to,
    this.image,
  });

  PopularRestaurantModel copyWith({
    String? durationLt,
    String? id,
    String? up_to,
    String? restaurantName,
    String? category,
    String? rating,
    String? offer,
    String? image,
  }) {
    return PopularRestaurantModel(
      durationLt: durationLt ?? this.durationLt,
      id: id ?? this.id,
      restaurantName: restaurantName ?? this.restaurantName,
      category: category ?? this.category,
      rating: rating ?? this.rating,
      offer: offer ?? this.offer,
      up_to: up_to ?? this.up_to,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'duration_lt': durationLt,
      'id': id,
      'restaurant_name': restaurantName,
      'category': category,
      'rating': rating,
      'up_to': up_to,
      'image': image,
      'offer': offer
    };
  }

  factory PopularRestaurantModel.fromMap(Map<String, dynamic> map) {
    return PopularRestaurantModel(
      durationLt: map['duration_lt'],
      id: map['id'],
      up_to: map['up_to'],
      restaurantName: map['restaurant_name'],
      category: map['category'],
      offer: map['offer'],
      rating: map['rating'],
      image: map['image'],
      // image: List.generate(
      //     map['image'].length, (index) => map['image'][index]["file_name"]),
    );
  }

  String toJson() => json.encode(toMap());

  factory PopularRestaurantModel.fromJson(String source) =>
      PopularRestaurantModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PopularRestaurantModel(durationLt: $durationLt,up_to: $up_to,offer :$offer, id: $id, restaurantName: $restaurantName, category: $category, rating: $rating, image: $image)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PopularRestaurantModel &&
        other.durationLt == durationLt &&
        other.id == id &&
        other.up_to == up_to &&
        other.offer == offer &&
        other.restaurantName == restaurantName &&
        other.category == category &&
        other.rating == rating &&
        other.image == image;
  }

  @override
  int get hashCode {
    return durationLt.hashCode ^
        id.hashCode ^
        offer.hashCode ^
        up_to.hashCode ^
        restaurantName.hashCode ^
        category.hashCode ^
        rating.hashCode ^
        image.hashCode;
  }
}

class PopularRestaurantResponseModel {
  String? status;
  String? message;
  String? restaurantBaseurl;
  List<NewArrival>? newArrival;

  PopularRestaurantResponseModel(
      {this.status, this.message, this.restaurantBaseurl, this.newArrival});

  PopularRestaurantResponseModel.fromJson(Map<String, dynamic> json) {
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
  String? durationOrder;
  String? durationLt;
  String? distance;
  String? id;
  String? restaurantName;
  String? category;
  String? rating;
  String? offer;
  String? description;
  String? image;
  String? upTo;
  String? outletStatus;

  NewArrival(
      {this.durationOrder,
      this.description,
      this.durationLt,
      this.distance,
      this.id,
      this.restaurantName,
      this.category,
      this.rating,
      this.offer,
      this.image,
      this.upTo,
      this.outletStatus});

  NewArrival.fromJson(Map<String, dynamic> json) {
    durationOrder = json['duration_order'];
    durationLt = json['duration_lt'];
    distance = json['distance'];
    id = json['id'];
    restaurantName = json['restaurant_name'];
    category = json['category'];
    rating = json['rating'];
    description = json['description'];
    offer = json['offer'];
    image = json['image'];
    upTo = json['up_to'];
    outletStatus = json['outlet_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['duration_order'] = this.durationOrder;
    data['duration_lt'] = this.durationLt;
    data['distance'] = this.distance;
    data['id'] = this.id;
    data['restaurant_name'] = this.restaurantName;
    data['category'] = this.category;
    data['rating'] = this.rating;
    data['offer'] = this.offer;
    data['image'] = this.image;
    data['up_to'] = this.upTo;
    data['outlet_status'] = this.outletStatus;
    return data;
  }
}

class PopularMeatResponseModel {
  String? status;
  String? message;
  String? restaurantBaseurl;
  List<NewArrival>? newArrival;

  PopularMeatResponseModel(
      {this.status, this.message, this.restaurantBaseurl, this.newArrival});

  PopularMeatResponseModel.fromJson(Map<String, dynamic> json) {
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

class PopularBakeryResponseModel {
  String? status;
  String? message;
  String? restaurantBaseurl;
  List<NewArrival>? newArrival;

  PopularBakeryResponseModel(
      {this.status, this.message, this.restaurantBaseurl, this.newArrival});

  PopularBakeryResponseModel.fromJson(Map<String, dynamic> json) {
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

class FoodCourtResponseModel {
  String? status;
  String? message;
  String? restaurantBaseurl;
  List<MallItem>? newArrival;

  FoodCourtResponseModel(
      {this.status, this.message, this.restaurantBaseurl, this.newArrival});

  FoodCourtResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    restaurantBaseurl = json['restaurant_baseurl'];
    if (json['newArrival'] != null) {
      newArrival = <MallItem>[];
      json['newArrival'].forEach((v) {
        newArrival!.add(new MallItem.fromJson(v));
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

class MallItem {
  String? durationOrder;
  String? durationLt;
  String? distance;
  String? id;
  String? restaurantName;
  MallDetails? mallDetails;
  String? category;
  String? rating;
  String? offer;
  String? description;
  String? image;
  String? upTo;
  String? outletStatus;

  MallItem(
      {this.durationOrder,
      this.durationLt,
      this.distance,
      this.id,
      this.restaurantName,
      this.mallDetails,
      this.category,
      this.rating,
      this.offer,
      this.description,
      this.image,
      this.upTo,
      this.outletStatus});

  MallItem.fromJson(Map<String, dynamic> json) {
    durationOrder = json['duration_order'];
    durationLt = json['duration_lt'];
    distance = json['distance'];
    id = json['id'];
    restaurantName = json['restaurant_name'];
    mallDetails = json['mall_details'] != null
        ? new MallDetails.fromJson(json['mall_details'])
        : null;
    category = json['category'];
    rating = json['rating'];
    offer = json['offer'];
    description = json['description'];
    image = json['image'];
    upTo = json['up_to'];
    outletStatus = json['outlet_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['duration_order'] = this.durationOrder;
    data['duration_lt'] = this.durationLt;
    data['distance'] = this.distance;
    data['id'] = this.id;
    data['restaurant_name'] = this.restaurantName;
    if (this.mallDetails != null) {
      data['mall_details'] = this.mallDetails!.toJson();
    }
    data['category'] = this.category;
    data['rating'] = this.rating;
    data['offer'] = this.offer;
    data['description'] = this.description;
    data['image'] = this.image;
    data['up_to'] = this.upTo;
    data['outlet_status'] = this.outletStatus;
    return data;
  }
}

class MallDetails {
  String? id;
  String? mallName;

  MallDetails({this.id, this.mallName});

  MallDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mallName = json['mall_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['mall_name'] = this.mallName;
    return data;
  }
}
