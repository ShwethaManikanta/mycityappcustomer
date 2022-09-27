import 'dart:convert';

class OnboardingBannerModel {
  String? id;
  String? title;
  String? description;
  String? offer;

  String? banner_image;
  String? image;
  String? status;
  String? offer_int;
  dynamic color;
  String? promocode;
  String? outlet_id;

  String? createdAt;

  OnboardingBannerModel(
      {this.id,
      this.title,
        this.offer,
      this.description,
      this.image,
        this.offer_int,
      this.color,
      this.promocode,
      this.banner_image,
      this.status,
      this.createdAt,
      this.outlet_id});

  OnboardingBannerModel copyWith({
    String? id,
    String? title,
    String? description,
    String? image,
    String? offer,
    String? offer_int,
    String? status,
    dynamic color,
    String? promocode,
    String? banner_image,
    String? createdAt,
    String? outlet_id,
  }) {
    return OnboardingBannerModel(
        id: id ?? this.id,offer: offer ?? this.offer,
        promocode: promocode ?? this.promocode,
        color: color ?? this.color,
        title: title ?? this.title,
        offer_int: offer_int ?? this.offer_int,
        description: description ?? this.description,
        image: image ?? this.image,
        status: status ?? this.status,
        banner_image: banner_image ?? this.banner_image,
        createdAt: createdAt ?? this.createdAt,
        outlet_id: outlet_id ?? this.outlet_id);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'offer':offer,
      'offer_int':offer_int,
      'promocode': promocode,
      'color': color,
      'description': description,
      'image': image,
      'status': status,
      'banner_image': banner_image,
      'outlet_id': outlet_id,
      'created_at': createdAt,
    };
  }

  factory OnboardingBannerModel.fromMap(Map<String, dynamic> map) {
    return OnboardingBannerModel(
      id: map['id'],
      offer_int:map['offer_int'],
      offer:map['offer'],
      promocode: map['promocode'],
      color: map['color'],
      title: map['title'],
      outlet_id: map['outlet_id'],
      description: map['description'],
      image: map['image'],
      status: map['status'],
      banner_image: map['banner_image'],
      createdAt: map['created_at'],
    );
  }

  String toJson() => json.encode(toMap());

  factory OnboardingBannerModel.fromJson(String source) => OnboardingBannerModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OnboardingBannerModel(id: $id,offer_int :$offer_int,offer :$offer,promocode: $promocode,color : $color, title: $title,outlet_id :$outlet_id, description: $description, image: $image, status: $status,banner_image :$banner_image, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OnboardingBannerModel &&
        other.id == id &&
        other.offer == offer &&
        other.title == title &&
        other.offer_int == offer_int &&
        other.promocode == promocode &&
        other.color == color &&
        other.outlet_id == outlet_id &&
        other.description == description &&
        other.image == image &&
        other.banner_image == banner_image &&
        other.status == status &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        color.hashCode ^
    offer.hashCode ^
    promocode.hashCode ^
        description.hashCode ^
        image.hashCode ^
        banner_image.hashCode ^
        status.hashCode ^
        createdAt.hashCode;
  }
}
