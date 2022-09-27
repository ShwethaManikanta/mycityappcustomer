//Front Banner List Response Model
class FrontBannerListResponseModel {
  String? status;
  String? message;
  String? imageBaseurl;
  List<FrontBanner>? topBanner;

  FrontBannerListResponseModel(
      {this.status, this.message, this.imageBaseurl, this.topBanner});

  FrontBannerListResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    imageBaseurl = json['image_baseurl'];
    if (json['topBanner'] != null) {
      topBanner = <FrontBanner>[];
      json['topBanner'].forEach((v) {
        topBanner!.add(new FrontBanner.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['image_baseurl'] = this.imageBaseurl;
    if (this.topBanner != null) {
      data['topBanner'] = this.topBanner!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FrontBanner {
  String? id;
  String? title;
  String? description;
  String? image;
  String? status;
  String? createdAt;

  FrontBanner(
      {this.id,
      this.title,
      this.description,
      this.image,
      this.status,
      this.createdAt});

  FrontBanner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    image = json['image'];
    status = json['status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['image'] = this.image;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    return data;
  }
}

//Banner List Response Model

class BannerListResponseModel {
  String? status;
  String? message;
  String? imageBaseurl;
  List<TopBanner>? topBanner;

  BannerListResponseModel(
      {this.status, this.message, this.imageBaseurl, this.topBanner});

  BannerListResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    imageBaseurl = json['image_baseurl'];
    if (json['topBanner'] != null) {
      topBanner = <TopBanner>[];
      json['topBanner'].forEach((v) {
        topBanner!.add(new TopBanner.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['image_baseurl'] = this.imageBaseurl;
    if (this.topBanner != null) {
      data['topBanner'] = this.topBanner!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TopBanner {
  String? bannerImage;

  TopBanner({this.bannerImage});

  TopBanner.fromJson(Map<String, dynamic> json) {
    bannerImage = json['banner_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['banner_image'] = this.bannerImage;
    return data;
  }
}

//Bottom Banner Response Model
class BottomBannerResponseModel {
  String? status;
  String? message;
  String? imageBaseurl;
  List<BottomBanner>? bottomBanner;

  BottomBannerResponseModel(
      {this.status, this.message, this.imageBaseurl, this.bottomBanner});

  BottomBannerResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    imageBaseurl = json['image_baseurl'];
    if (json['bottomBanner'] != null) {
      bottomBanner = <BottomBanner>[];
      json['bottomBanner'].forEach((v) {
        bottomBanner!.add(new BottomBanner.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['image_baseurl'] = this.imageBaseurl;
    if (this.bottomBanner != null) {
      data['bottomBanner'] = this.bottomBanner!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

// class BottomBanner {
//   String? bannerImage;

//   BottomBanner({this.bannerImage});

//   BottomBanner.fromJson(Map<String, dynamic> json) {
//     bannerImage = json['banner_image'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['banner_image'] = this.bannerImage;
//     return data;
//   }
// }

//Offer Banner Response Model

class OfferBannerResponseModel {
  String? status;
  String? message;
  String? imageBaseurl;
  List<OfferBanner>? offerBanner;

  OfferBannerResponseModel(
      {this.status, this.message, this.imageBaseurl, this.offerBanner});

  OfferBannerResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    imageBaseurl = json['image_baseurl'];
    if (json['offerBanner'] != null) {
      offerBanner = <OfferBanner>[];
      json['offerBanner'].forEach((v) {
        offerBanner!.add(new OfferBanner.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['image_baseurl'] = this.imageBaseurl;
    if (this.offerBanner != null) {
      data['offerBanner'] = this.offerBanner!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OfferBanner {
  String? id;
  String? title;
  String? promocode;
  String? color;
  String? offer;
  String? offerInt;
  String? bannerImage;
  String? outletId;
  String? description;
  String? status;
  String? createdAt;

  OfferBanner(
      {this.id,
      this.title,
      this.promocode,
      this.color,
      this.offer,
      this.offerInt,
      this.bannerImage,
      this.outletId,
      this.description,
      this.status,
      this.createdAt});

  OfferBanner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    promocode = json['promocode'];
    color = json['color'];
    offer = json['offer'];
    offerInt = json['offer_int'];
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
    data['offer_int'] = this.offerInt;
    data['banner_image'] = this.bannerImage;
    data['outlet_id'] = this.outletId;
    data['description'] = this.description;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    return data;
  }
}

//Meat Banner Response Model

class MeatBannerResponseModel {
  String? status;
  String? message;
  String? imageBaseurl;
  List<MeatBanner>? meatBanner;

  MeatBannerResponseModel(
      {this.status, this.message, this.imageBaseurl, this.meatBanner});

  MeatBannerResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    imageBaseurl = json['image_baseurl'];
    if (json['meatBanner'] != null) {
      meatBanner = <MeatBanner>[];
      json['meatBanner'].forEach((v) {
        meatBanner!.add(new MeatBanner.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['image_baseurl'] = this.imageBaseurl;
    if (this.meatBanner != null) {
      data['meatBanner'] = this.meatBanner!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MeatBanner {
  String? id;
  String? outletId;
  String? title;
  String? bannerImage;
  String? description;
  String? category;
  String? offer;
  String? status;
  String? createdAt;

  MeatBanner(
      {this.id,
      this.outletId,
      this.title,
      this.bannerImage,
      this.description,
      this.category,
      this.offer,
      this.status,
      this.createdAt});

  MeatBanner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    outletId = json['outlet_id'];
    title = json['title'];
    bannerImage = json['banner_image'];
    description = json['description'];
    category = json['category'];
    offer = json['offer'];
    status = json['status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['outlet_id'] = this.outletId;
    data['title'] = this.title;
    data['banner_image'] = this.bannerImage;
    data['description'] = this.description;
    data['category'] = this.category;
    data['offer'] = this.offer;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class BakeryBannerResponseModel {
  String? status;
  String? message;
  String? imageBaseurl;
  List<BottomBanner>? bottomBanner;

  BakeryBannerResponseModel(
      {this.status, this.message, this.imageBaseurl, this.bottomBanner});

  BakeryBannerResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    imageBaseurl = json['image_baseurl'];
    if (json['bottomBanner'] != null) {
      bottomBanner = <BottomBanner>[];
      json['bottomBanner'].forEach((v) {
        bottomBanner!.add(new BottomBanner.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['image_baseurl'] = this.imageBaseurl;
    if (this.bottomBanner != null) {
      data['bottomBanner'] = this.bottomBanner!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BottomBanner {
  String? id;
  String? outletId;
  String? title;
  String? bannerImage;
  String? description;
  String? category;
  String? offer;
  String? status;
  String? createdAt;

  BottomBanner(
      {this.id,
      this.outletId,
      this.title,
      this.bannerImage,
      this.description,
      this.category,
      this.offer,
      this.status,
      this.createdAt});

  BottomBanner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    outletId = json['outlet_id'];
    title = json['title'];
    bannerImage = json['banner_image'];
    description = json['description'];
    category = json['category'];
    offer = json['offer'];
    status = json['status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['outlet_id'] = this.outletId;
    data['title'] = this.title;
    data['banner_image'] = this.bannerImage;
    data['description'] = this.description;
    data['category'] = this.category;
    data['offer'] = this.offer;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    return data;
  }
}
