class OfferRestaurantBannerResponseModel {
  String? status;
  String? message;
  String? offerBaseurl;
  String? restaurantBaseurl;
  OfferBannerList? offerBannerList;
  List<NewArrival>? newArrival;

  OfferRestaurantBannerResponseModel(
      {this.status,
      this.message,
      this.offerBaseurl,
      this.restaurantBaseurl,
      this.offerBannerList,
      this.newArrival});

  OfferRestaurantBannerResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    offerBaseurl = json['offer_baseurl'];
    restaurantBaseurl = json['restaurant_baseurl'];
    offerBannerList = json['offer_banner_list'] != null
        ? new OfferBannerList.fromJson(json['offer_banner_list'])
        : null;
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
    data['offer_baseurl'] = this.offerBaseurl;
    data['restaurant_baseurl'] = this.restaurantBaseurl;
    if (this.offerBannerList != null) {
      data['offer_banner_list'] = this.offerBannerList!.toJson();
    }
    if (this.newArrival != null) {
      data['newArrival'] = this.newArrival!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OfferBannerList {
  String? id;
  String? title;
  String? promocode;
  String? color;
  String? offer;
  String? bannerImage;
  String? outletId;
  String? description;
  String? status;
  String? createdAt;

  OfferBannerList(
      {this.id,
      this.title,
      this.promocode,
      this.color,
      this.offer,
      this.bannerImage,
      this.outletId,
      this.description,
      this.status,
      this.createdAt});

  OfferBannerList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    promocode = json['promocode'];
    color = json['color'];
    offer = json['offer'];
    bannerImage = json['banner_image'];
    outletId = json['outlet_id'];
    description = json['description'];
    status = json['status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['promocode'] = this.promocode;
    data['color'] = this.color;
    data['offer'] = this.offer;
    data['banner_image'] = this.bannerImage;
    data['outlet_id'] = this.outletId;
    data['description'] = this.description;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class NewArrival {
  int? durationOrder;
  String? durationLt;
  String? id;
  String? restaurantName;
  String? category;
  String? rating;
  String? offer;
  String? image;
  String? upTo;
  String? outletStatus;

  NewArrival(
      {this.durationOrder,
      this.durationLt,
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
    id = json['id'];
    restaurantName = json['restaurant_name'];
    category = json['category'];
    rating = json['rating'];
    offer = json['offer'];
    image = json['image'];
    upTo = json['up_to'];
    outletStatus = json['outlet_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['duration_order'] = this.durationOrder;
    data['duration_lt'] = this.durationLt;
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
