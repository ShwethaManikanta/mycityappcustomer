import 'dart:convert';

import 'package:flutter/foundation.dart';

class PopularCurationViewModel {
  String? duration_order;
  String? duration_lt;
  String? id;
  String? restaurant_name;
  String? category;
  String? rating;
  String? offer;
  String? image;
  String? up_to;
  String? outlet_status;

  PopularCurationViewModel(
      {this.duration_order,
        this.duration_lt,
        this.id,
        this.restaurant_name,
        this.image,
        this.category,
        this.rating,
        this.offer,
        this.up_to,
        this.outlet_status});

  PopularCurationViewModel copyWith({
    String? duration_order,
    String? id,
    String? duration_lt,
    String? restaurant_name,
    String? image,
    String? category,
    String? rating,
    String? offer,
    String? up_to,
    String? outlet_status,
  }) {
    return PopularCurationViewModel(
      duration_order: duration_order ?? this.duration_order,
      id: id ?? this.id,
      duration_lt: duration_lt ?? this.duration_lt,
      restaurant_name: restaurant_name ?? this.restaurant_name,
      category: category ?? this.category,
      rating: rating ?? this.rating,
      offer: offer ?? this.offer,
      image: image ?? this.image,
      up_to: up_to ?? this.up_to,
      outlet_status: outlet_status ?? this.outlet_status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'duration_order': duration_order,
      'id': id,
      'duration_lt': duration_lt,
      'restaurant_name': restaurant_name,
      'category': category,
      'rating': rating,
      'offer': offer,
      'image': image,
      'up_to': up_to,
      'outlet_status': outlet_status,
    };
  }

  factory PopularCurationViewModel.fromMap(Map<String, dynamic> map) {
    return PopularCurationViewModel(
      duration_order: map['duration_order'],
      id: map['id'],
      duration_lt: map['duration_lt'],
      restaurant_name: map['restaurant_name'],
      category: map['category'],
      rating: map['rating'],
      offer: map['offer'],
      image: map['image'],
      up_to: map['up_to'],
      outlet_status: map['outlet_status'],

      // image: List.generate(
      //     map['image'].length, (index) => map['image'][index]["file_name"]),
    );
  }

  String toJson() => json.encode(toMap());

  factory PopularCurationViewModel.fromJson(String source) => PopularCurationViewModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PopularCurationViewModel(duration_order: $duration_order,duration_lt: $duration_lt,restaurant_name :$restaurant_name, id: $id, category: $category, rating: $rating, offer: $offer, image: $image, up_to: $up_to, outlet_status: $outlet_status)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PopularCurationViewModel &&
        other.duration_order == duration_order &&
        other.id == id &&
        other.duration_lt == duration_lt &&
        other.restaurant_name == restaurant_name &&
        other.category == category &&
        other.rating == rating &&
        other.offer == offer &&
        other.up_to == up_to &&
        other.outlet_status == outlet_status &&
        other.image == image;
  }

  @override
  int get hashCode {
    return duration_order.hashCode ^
    id.hashCode ^
    duration_lt.hashCode ^
    restaurant_name.hashCode ^
    category.hashCode ^
    rating.hashCode ^
    offer.hashCode ^
    up_to.hashCode ^
    outlet_status.hashCode ^
    image.hashCode;
  }
}
