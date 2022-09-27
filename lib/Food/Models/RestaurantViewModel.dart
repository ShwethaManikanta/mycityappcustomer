// import 'dart:convert';
// import 'package:foodie/Models/TopOffersModel.dart';

// class RestaurantViewModel {
//   String? status;
//   String? message;
//   String? productBaseurl;
//   String? retailerProfileurl;
//   List<ProductList>? productList;
//   List<CategoryMenuModel>? categoryMenu;
//   List<BrosweMenu>? browseMenu;
//   List<Retailerlist>? retailerlist;

//   RestaurantViewModel(
//       {this.status,
//       this.message,
//       this.productBaseurl,
//       this.retailerProfileurl,
//       this.productList,
//       this.categoryMenu,
//       this.browseMenu,
//       this.retailerlist});

//   RestaurantViewModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     productBaseurl = json['product_baseurl'];
//     retailerProfileurl = json['retailer_profileurl'];
//     if (json['product_list'] != null) {
//       productList = <ProductList>[];
//       json['product_list'].forEach((v) {
//         productList!.add(new ProductList.fromJson(v));
//       });
//     }
//     // if (json['category_menu'] != null) {
//     //   categoryMenu = <CategoryMenuModel>[];
//     //   json['category_menu'].forEach((v) {
//     //     categoryMenu!.add(new CategoryMenuModel.fromJson(v));
//     //   });
//     // }
//     // if (json['browse_menu'] != null) {
//     //   browseMenu = <BrosweMenu>[];
//     //   json['browse_menu'].forEach((v) {
//     //     browseMenu!.add(new BrosweMenu.fromJson(v));
//     //   });
//     // }
//     if (json['retailerlist'] != null) {
//       retailerlist = <Retailerlist>[];
//       json['retailerlist'].forEach((v) {
//         retailerlist!.add(Retailerlist.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['message'] = this.message;
//     data['product_baseurl'] = this.productBaseurl;
//     data['retailer_profileurl'] = this.retailerProfileurl;
//     if (this.productList != null) {
//       data['product_list'] = this.productList!.map((v) => v.toJson()).toList();
//     }
//     if (this.categoryMenu != null) {
//       data['category_menu'] =
//           this.categoryMenu!.map((v) => v.toJson()).toList();
//     }
//     if (this.browseMenu != null) {
//       data['browse_menu'] = this.browseMenu!.map((v) => v.toJson()).toList();
//     }
//     if (this.retailerlist != null) {
//       data['retailerlist'] = this.retailerlist!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// // class RestaurantViewModel {
// //   String? status;
// //   String? message;
// //   String? productBaseUrl;
// //   String? retailerProfileUrl;
// //   List<ProductList>? adonDetailsList;
// //   List<ProductList>? productList;
// //   List<ProductList>? searchMenu;

// //   List<BrosweMenu>? browseMenu;
// //   List<CategoryMenuModel>? categoryMenu;
// //   List<Retailerlist>? retailerlist;

// //   RestaurantViewModel(
// //       {this.status,
// //       this.message,
// //       this.productBaseUrl,
// //       this.retailerProfileUrl,
// //       this.productList,
// //       this.searchMenu,
// //       this.categoryMenu,
// //       this.browseMenu,
// //       this.adonDetailsList,
// //       this.retailerlist});

// //   RestaurantViewModel copyWith({
// //     String? status,
// //     String? message,
// //     String? productBaseUrl,
// //     String? searchMenu,
// //     String? retailerProfileUrl,
// //     List<ProductList>? productList,
// //     List<BrosweMenu>? browseMenu,
// //     List<ProductList>? adonDetailsList,
// //     List<CategoryMenuModel>? categoryMenu,
// //     List<Retailerlist>? retailerlist,
// //   }) {
// //     return RestaurantViewModel(
// //       status: status ?? this.status,
// //       searchMenu: searchMenu as List<ProductList>? ?? this.searchMenu,
// //       message: message ?? this.message,
// //       productBaseUrl: productBaseUrl ?? this.productBaseUrl,
// //       retailerProfileUrl: retailerProfileUrl ?? this.retailerProfileUrl,
// //       browseMenu: browseMenu ?? this.browseMenu,
// //       adonDetailsList: adonDetailsList ?? this.adonDetailsList,
// //       productList: productList ?? this.productList,
// //       categoryMenu: categoryMenu ?? this.categoryMenu,
// //       retailerlist: retailerlist ?? this.retailerlist,
// //     );
// //   }

// //   Map<String, dynamic> toMap() {
// //     return {
// //       'status': status,
// //       'message': message,
// //       'search_menu': searchMenu,
// //       'adon_details_list': adonDetailsList,
// //       'browse_menu': browseMenu,
// //       'product_baseurl': productBaseUrl,
// //       'retailer_profileurl': retailerProfileUrl,
// //       'product_list': productList,
// //       'category_menu': categoryMenu,
// //       'retailerlist': retailerlist,
// //     };
// //   }

// //   // factory RestaurantViewModel.fromMap(Map<String, dynamic> map) {
// //   //   return RestaurantViewModel(
// //   //     status: map['status'],
// //   //     message: map['message'],
// //   //     searchMenu: map['search_menu'],
// //   //     // search_menu: List.generate(map['search_menu'].length, (index) => ProductList(
// //   //     //   id: map['browse_menu'][index]['id'],mrp: map['browse_menu'][index]['mrp'],description:map['browse_menu'][index]['description'],
// //   //     //     category_name: map['browse_menu'][index]['category_name'],category_id :map['browse_menu'][index]['category_id'],
// //   //     //     menu_name:  map['browse_menu'][index]['menu_name'],food_type : map['browse_menu'][index]['food_type'],sale_price: map['browse_menu'][index]['sale_price'],
// //   //     // )),
// //   //     browseMenu: map['browse_menu'],
// //   //     productBaseUrl: map['product_baseurl'],
// //   //     adonDetailsList:
// //   //         map['adon_details_list'] != null ? map['adon_details_list'] : null,
// //   //     retailerProfileUrl: map['retailer_profileurl'] != null
// //   //         ? map['retailer_profileurl']
// //   //         : null,
// //   //     productList: map['product_list'] != null ? map['product_list'] : null,
// //   //     categoryMenu: map['category_menu'] != null ? map['category_ment'] : null,
// //   //     retailerlist: map['retailerlist'] != null ? map['retailerlist'] : null,
// //   //     // if(map['retailerlist'] != null){

// //   //     // }
// //   //   );
// //   // }

// //   String toJson() => json.encode(toMap());

// //   factory RestaurantViewModel.fromJson(String source) =>
// //       RestaurantViewModel.fromMap(json.decode(source));

// //   // @override
// //   // String toString() {
// //   //   return 'RestaurantViewModel(status: $status,search_menu :$search_menu,browse_menu:$browse_menu, message: $message,category_menu: $category_menu,adon_details_list :$adon_details_list'
// //   //       ' product_baseurl: $product_baseurl, retailer_profileurl: $retailer_profileurl, product_list: $product_list, retailerlist: $retailerlist)';
// //   // }

// //   // @override
// //   // bool operator ==(Object other) {
// //   //   if (identical(this, other)) return true;

// //   //   return other is RestaurantViewModel &&
// //   //       other.status == status &&
// //   //       other.search_menu == search_menu &&
// //   //       other.message == message &&
// //   //       other.browse_menu == browse_menu &&
// //   //       other.adon_details_list == adon_details_list &&
// //   //       other.product_baseurl == product_baseurl &&
// //   //       other.retailer_profileurl == retailer_profileurl &&
// //   //       other.product_list == product_list &&
// //   //       other.category_menu == category_menu &&
// //   //       other.retailerlist == retailerlist;
// //   // }

// //   // @override
// //   // int get hashCode {
// //   //   return status.hashCode ^
// //   //       message.hashCode ^
// //   //       search_menu.hashCode ^
// //   //       browse_menu.hashCode ^
// //   //       product_baseurl.hashCode ^
// //   //       adon_details_list.hashCode ^
// //   //       retailer_profileurl.hashCode ^
// //   //       product_list.hashCode ^
// //   //       category_menu.hashCode ^
// //   //       retailerlist.hashCode;
// //   // }
// // }

// // // class ProductList {
// // //   String? id;
// // //   String? menu_name;
// // //   String? food_type;
// // //   String? image;
// // //   String? cartDetails;

// // //   List<dynamic>? menu_image;
// // //   String? category_id;
// // //   String? category_name;
// // //   dynamic mrp;
// // //   String? sale_price;
// // //   String? description;
// // //   String? rating;
// // //   String? no_review;
// // //   int? status;
// // //   ProductList(
// // //       {this.id,
// // //       this.description,
// // //       this.category_name,
// // //       this.category_id,
// // //       this.menu_image,
// // //       this.menu_name,
// // //       this.mrp,
// // //       this.image,
// // //       this.food_type,
// // //       this.no_review,
// // //       this.rating,
// // //       this.sale_price,
// // //       this.status,
// // //       this.cartDetails});

// // //   ProductList copyWith(
// // //       {String? id,
// // //       String? image,
// // //       String? description,
// // //       String? category_name,
// // //       String? category_id,
// // //       String? food_type,
// // //       List<dynamic>? menu_image,
// // //       String? menu_name,
// // //       dynamic mrp,
// // //       String? no_review,
// // //       String? rating,
// // //       String? sale_price,
// // //       int? status,
// // //       String? cartDetails}) {
// // //     return ProductList(
// // //         id: id ?? this.id,
// // //         image: image ?? this.image,
// // //         description: description ?? this.description,
// // //         category_name: category_name ?? this.category_name,
// // //         category_id: category_id ?? this.category_id,
// // //         menu_image: menu_image ?? this.menu_image,
// // //         menu_name: menu_name ?? this.menu_name,
// // //         mrp: mrp ?? this.mrp,
// // //         food_type: food_type ?? this.food_type,
// // //         no_review: no_review ?? this.no_review,
// // //         rating: rating ?? this.rating,
// // //         sale_price: sale_price ?? this.sale_price,
// // //         status: status ?? this.status,
// // //         cartDetails: cartDetails ?? this.cartDetails);
// // //   }

// // //   Map<String, dynamic> toMap() {
// // //     return {
// // //       'id': id,
// // //       'image': image,
// // //       'description': description,
// // //       'category_name': category_name,
// // //       'category_id': category_id,
// // //       'menu_image': menu_image,
// // //       'menu_name': menu_name,
// // //       'mrp': mrp,
// // //       'food_type': food_type,
// // //       'no_review': no_review,
// // //       'rating': rating,
// // //       'sale_price': sale_price,
// // //       'status': status,
// // //       'cartDetails': cartDetails
// // //     };
// // //   }

// // //   factory ProductList.fromMap(Map<String, dynamic> map) {
// // //     return ProductList(
// // //         id: map['id'],
// // //         image: map['image'],
// // //         description: map['description'],
// // //         category_name: map['category_name'],
// // //         category_id: map['category_id'],
// // //         food_type: map['food_type'],
// // //         // menu_image: map['menu_image'],

// // //         menu_image: List.generate(
// // //             map['menu_image'].length, (index) => map['menu_image'][index]),
// // //         menu_name: map['menu_name'],
// // //         mrp: map['mrp'],
// // //         no_review: map['no_review'],
// // //         rating: map['rating'],
// // //         sale_price: map['sale_price'],
// // //         status: map['status'],
// // //         cartDetails: map['cart_details'] ?? '0');
// // //   }

// // //   String toJson() => json.encode(toMap());

// // //   factory ProductList.fromJson(String source) =>
// // //       ProductList.fromMap(json.decode(source));

// // //   @override
// // //   String toString() {
// // //     return 'ProductList(id: $id, status: $status,image :$image,description: $description, category_name: $category_name, category_id: $category_id, food_type : $food_type,menu_name: $menu_name,menu_image: $menu_image, mrp: $mrp, no_review: $no_review, rating: $rating, sale_price: $sale_price)';
// // //   }

// // //   @override
// // //   bool operator ==(Object other) {
// // //     if (identical(this, other)) return true;

// // //     return other is ProductList &&
// // //         other.id == id &&
// // //         other.image == image &&
// // //         other.status == status &&
// // //         other.description == description &&
// // //         other.no_review == no_review &&
// // //         other.sale_price == sale_price &&
// // //         other.category_name == category_name &&
// // //         other.food_type == food_type &&
// // //         other.category_id == category_id &&
// // //         listEquals(other.menu_image, menu_image) &&
// // //         other.menu_name == menu_name &&
// // //         other.rating == rating &&
// // //         other.mrp == mrp;
// // //   }

// // //   @override
// // //   int get hashCode {
// // //     return id.hashCode ^
// // //         description.hashCode ^
// // //         no_review.hashCode ^
// // //         image.hashCode ^
// // //         status.hashCode ^
// // //         sale_price.hashCode ^
// // //         category_id.hashCode ^
// // //         category_name.hashCode ^
// // //         food_type.hashCode ^
// // //         menu_name.hashCode ^
// // //         menu_image.hashCode ^
// // //         rating.hashCode ^
// // //         mrp.hashCode;
// // //   }
// // // }

// class ProductList {
//   String? id;
//   String? menuName;
//   List<String>? menuImage;
//   String? categoryId;
//   String? categoryName;
//   String? foodType;
//   String? mrp;
//   String? salePrice;
//   String? description;
//   String? rating;
//   String? noReview;
//   int? status;
//   String? cartDetails;

//   ProductList(
//       {this.id,
//       this.menuName,
//       this.menuImage,
//       this.categoryId,
//       this.categoryName,
//       this.foodType,
//       this.mrp,
//       this.salePrice,
//       this.description,
//       this.rating,
//       this.noReview,
//       this.status,
//       this.cartDetails});

//   ProductList.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     menuName = json['menu_name'];
//     menuImage = json['menu_image'].cast<String>();
//     categoryId = json['category_id'];
//     categoryName = json['category_name'];
//     foodType = json['food_type'];
//     mrp = json['mrp'];
//     salePrice = json['sale_price'];
//     description = json['description'];
//     rating = json['rating'];
//     noReview = json['no_review'];
//     status = json['status'];
//     cartDetails = json['cart_details'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['menu_name'] = this.menuName;
//     data['menu_image'] = this.menuImage;
//     data['category_id'] = this.categoryId;
//     data['category_name'] = this.categoryName;
//     data['food_type'] = this.foodType;
//     data['mrp'] = this.mrp;
//     data['sale_price'] = this.salePrice;
//     data['description'] = this.description;
//     data['rating'] = this.rating;
//     data['no_review'] = this.noReview;
//     data['status'] = this.status;
//     data['cart_details'] = this.cartDetails;
//     return data;
//   }
// }

// class BrosweMenu {
//   String? categoryId;
//   String? categoryName;
//   int? count;

//   BrosweMenu({
//     this.categoryName,
//     this.categoryId,
//     this.count,
//   });

//   BrosweMenu copyWith({
//     String? categoryId,
//     String? categoryName,
//     int? count,
//   }) {
//     return BrosweMenu(
//         categoryName: categoryName ?? this.categoryName,
//         categoryId: categoryId ?? this.categoryId,
//         count: count ?? this.count);
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'category_name': categoryName,
//       'category_id': categoryId,
//       'count': count
//     };
//   }

//   factory BrosweMenu.fromMap(Map<String, dynamic> map) {
//     return BrosweMenu(
//         categoryName: map['category_name'],
//         categoryId: map['category_id'],
//         count: map['count']);
//   }

//   String toJson() => json.encode(toMap());

//   factory BrosweMenu.fromJson(String source) =>
//       BrosweMenu.fromMap(json.decode(source));

//   // @override
//   // String toString() {
//   //   return 'BrosweMenu( category_name: $category_name, category_id: $category_id,  count: $count,)';
//   // }

//   // @override
//   // bool operator ==(Object other) {
//   //   if (identical(this, other)) return true;

//   //   return other is BrosweMenu &&
//   //       other.category_name == category_name &&
//   //       other.category_id == category_id &&
//   //       other.count == count;
//   // }

//   // @override
//   // int get hashCode {
//   //   return category_id.hashCode ^ category_name.hashCode ^ count.hashCode;
//   // }
// }

import 'TopOffersModel.dart';

class Retailerlist {
  String? id;
  String? outletName;
  String? outletImage;
  String? outletAddress;
  String? rating;
  String? noReview;
  String? lat;
  String? long;
  List<OffersModel>? offer;
  String? foodType;
  String? duration;
  String? distance;
  String? status;

  Retailerlist(
      {this.id,
      this.outletName,
      this.outletImage,
      this.outletAddress,
      this.rating,
      this.noReview,
      this.lat,
      this.long,
      this.offer,
      this.foodType,
      this.duration,
      this.distance,
      this.status});

  Retailerlist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    outletName = json['outlet_name'];
    outletImage = json['outlet_image'];
    outletAddress = json['outlet_address'];
    rating = json['rating'];
    noReview = json['no_review'];
    lat = json['lat'];
    long = json['long'];
    if (json['offer'] != null) {
      offer = <OffersModel>[];
      json['offer'].forEach((v) {
        offer!.add(OffersModel.fromJson(v));
      });
    }
    foodType = json['food_type'];
    duration = json['duration'];
    distance = json['distance'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['outlet_name'] = this.outletName;
    data['outlet_image'] = this.outletImage;
    data['outlet_address'] = this.outletAddress;
    data['rating'] = this.rating;
    data['no_review'] = this.noReview;
    data['lat'] = this.lat;
    data['long'] = this.long;
    if (this.offer != null) {
      data['offer'] = this.offer!.map((v) => v.toJson()).toList();
    }
    data['food_type'] = this.foodType;
    data['duration'] = this.duration;
    data['distance'] = this.distance;
    data['status'] = this.status;
    return data;
  }
}

// class CategoryMenuModel {
//   String? categoryId;
//   String? categoryName;
//   String? status;
//   List<ProductList>? productList;

//   CategoryMenuModel({
//     this.categoryId,
//     this.categoryName,
//     this.status,
//     this.productList,
//   });

//   // CategoryMenuModel copyWith({
//   //   String? category_id,
//   //   String? category_name,
//   //   String? status,
//   //   List<ProductList>? productList,
//   // }) {
//   //   return CategoryMenuModel(
//   //     category_id: category_id ?? this.category_id,
//   //     status: status ?? this.status,
//   //     category_name: category_name ?? this.category_name,
//   //     productList: productList ?? this.productList,
//   //   );
//   // }

//   Map<String, dynamic> toMap() {
//     return {
//       'category_id': categoryId,
//       'category_name': categoryName,
//       'productList': productList,
//       'status': status
//     };
//   }

//   factory CategoryMenuModel.fromMap(Map<String, dynamic> map) {
//     return CategoryMenuModel(
//       categoryId: map['category_id'],
//       categoryName: map['category_name'],
//       status: map['status'],
//       productList: List.generate(
//           map['productList'].length,
//           (index) => ProductList(
//                 id: map['productList'][index]['id'],
//                 menuName: map['productList'][index]['menu_name'],
//                 description: map['productList'][index]['description'],
//                 categoryName: map['productList'][index]['category_name'],
//                 categoryId: map['productList'][index]['category_id'],
//                 status: map['productList'][index]['status'],
//                 menuImage: map['productList'][index]['menu_image'],
//                 mrp: map['productList'][index]['mrp'],
//                 foodType: map['productList'][index]['food_type'],
//                 noReview: map['productList'][index]['no_review'],
//                 salePrice: map['productList'][index]['sale_price'],
//                 cartDetails: map['productList'][index]['cart_details'],
//               )),
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory CategoryMenuModel.fromJson(String source) =>
//       CategoryMenuModel.fromMap(json.decode(source));

//   @override
//   String toString() {
//     return 'CategoryMenuModel(category_id: $categoryId,status:$status, category_name: $categoryName,'
//         ' productList: $productList,)';
//   }

//   // @override
//   // bool operator ==(Object other) {
//   //   if (identical(this, other)) return true;

//   //   return other is CategoryMenuModel &&
//   //       other.category_id == category_id &&
//   //       other.status == status &&
//   //       other.category_name == category_name &&
//   //       other.productList == productList;
//   // }

//   // @override
//   // int get hashCode {
//   //   return category_id.hashCode ^
//   //       status.hashCode ^
//   //       category_name.hashCode ^
//   //       productList.hashCode;
//   // }
// }

// // class RestaurantDetailsResponseModel {
// //   String? status;
// //   String? message;
// //   String? productBaseurl;
// //   String? retailerProfileurl;
// //   List<ProductList>? productList;
// //   List<CategoryMenuModel>? categoryMenu;
// //   List<BrosweMenu>? browseMenu;
// //   List<Null>? retailerlist;

// //   RestaurantDetailsResponseModel(
// //       {this.status,
// //       this.message,
// //       this.productBaseurl,
// //       this.retailerProfileurl,
// //       this.productList,
// //       this.categoryMenu,
// //       this.browseMenu,
// //       this.retailerlist});

// //   RestaurantDetailsResponseModel.fromJson(Map<String, dynamic> json) {
// //     status = json['status'];
// //     message = json['message'];
// //     productBaseurl = json['product_baseurl'];
// //     retailerProfileurl = json['retailer_profileurl'];
// //     if (json['product_list'] != null) {
// //       productList = <ProductList>[];
// //       json['product_list'].forEach((v) {
// //         productList!.add(new ProductList.fromJson(v));
// //       });
// //     }
// //     if (json['category_menu'] != null) {
// //       categoryMenu = <CategoryMenuModel>[];
// //       json['category_menu'].forEach((v) {
// //         categoryMenu!.add(new CategoryMenuModel.fromJson(v));
// //       });
// //     }
// //     if (json['browse_menu'] != null) {
// //       browseMenu = <BrowseMenu>[];
// //       json['browse_menu'].forEach((v) {
// //         browseMenu!.add(new BrowseMenu.fromJson(v));
// //       });
// //     }
// //     if (json['retailerlist'] != null) {
// //       retailerlist = <Null>[];
// //       json['retailerlist'].forEach((v) {
// //         retailerlist!.add(new Null.fromJson(v));
// //       });
// //     }
// //   }

// //   Map<String, dynamic> toJson() {
// //     final Map<String, dynamic> data = new Map<String, dynamic>();
// //     data['status'] = this.status;
// //     data['message'] = this.message;
// //     data['product_baseurl'] = this.productBaseurl;
// //     data['retailer_profileurl'] = this.retailerProfileurl;
// //     if (this.productList != null) {
// //       data['product_list'] = this.productList!.map((v) => v.toJson()).toList();
// //     }
// //     if (this.categoryMenu != null) {
// //       data['category_menu'] =
// //           this.categoryMenu!.map((v) => v.toJson()).toList();
// //     }
// //     if (this.browseMenu != null) {
// //       data['browse_menu'] = this.browseMenu!.map((v) => v.toJson()).toList();
// //     }
// //     if (this.retailerlist != null) {
// //       data['retailerlist'] = this.retailerlist!.map((v) => v.toJson()).toList();
// //     }
// //     return data;
// //   }
// // }

// class RestaurantViewModel {
//   String? status;
//   String? message;
//   String? productBaseurl;
//   String? retailerProfileurl;
//   List<ProductList>? productList;
//   List<CategoryMenuModel>? categoryMenu;
//   List<BrowseMenu>? browseMenu;
//   List<Retailerlist>? retailerlist;

//   RestaurantViewModel(
//       {this.status,
//       this.message,
//       this.productBaseurl,
//       this.retailerProfileurl,
//       this.productList,
//       this.categoryMenu,
//       this.browseMenu,
//       this.retailerlist});

//   RestaurantViewModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     productBaseurl = json['product_baseurl'];
//     retailerProfileurl = json['retailer_profileurl'];
//     if (json['product_list'] != null) {
//       productList = <ProductList>[];
//       json['product_list'].forEach((v) {
//         productList!.add(new ProductList.fromJson(v));
//       });
//     }
//     if (json['category_menu'] != null) {
//       categoryMenu = <CategoryMenuModel>[];
//       json['category_menu'].forEach((v) {
//         categoryMenu!.add(new CategoryMenuModel.fromJson(v));
//       });
//     }
//     if (json['browse_menu'] != null) {
//       browseMenu = <BrowseMenu>[];
//       json['browse_menu'].forEach((v) {
//         browseMenu!.add(new BrowseMenu.fromJson(v));
//       });
//     }
//     if (json['retailerlist'] != null) {
//       retailerlist = <Retailerlist>[];
//       json['retailerlist'].forEach((v) {
//         retailerlist!.add(new Retailerlist.fromMap(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['message'] = this.message;
//     data['product_baseurl'] = this.productBaseurl;
//     data['retailer_profileurl'] = this.retailerProfileurl;
//     if (this.productList != null) {
//       data['product_list'] = this.productList!.map((v) => v.toJson()).toList();
//     }
//     if (this.categoryMenu != null) {
//       data['category_menu'] =
//           this.categoryMenu!.map((v) => v.toJson()).toList();
//     }
//     if (this.browseMenu != null) {
//       data['browse_menu'] = this.browseMenu!.map((v) => v.toJson()).toList();
//     }
//     // if (this.retailerlist != null) {
//     //   data['retailerlist'] = this.retailerlist!.map((v) => v.toJson()).toList();
//     // }
//     return data;
//   }
// }

// class ProductList {
//   String? id;
//   String? menuName;
//   List<String>? menuImage;
//   String? categoryId;
//   String? categoryName;
//   String? foodType;
//   String? mrp;
//   String? salePrice;
//   String? description;
//   String? rating;
//   String? noReview;
//   int? status;
//   String? cartDetails;

//   ProductList(
//       {this.id,
//       this.menuName,
//       this.menuImage,
//       this.categoryId,
//       this.categoryName,
//       this.foodType,
//       this.mrp,
//       this.salePrice,
//       this.description,
//       this.rating,
//       this.noReview,
//       this.status,
//       this.cartDetails});

//   ProductList.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     menuName = json['menu_name'];
//     menuImage = json['menu_image'].cast<String>();
//     categoryId = json['category_id'];
//     categoryName = json['category_name'];
//     foodType = json['food_type'];
//     mrp = json['mrp'];
//     salePrice = json['sale_price'];
//     description = json['description'];
//     rating = json['rating'];
//     noReview = json['no_review'];
//     status = json['status'];
//     cartDetails = json['cart_details'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['menu_name'] = this.menuName;
//     data['menu_image'] = this.menuImage;
//     data['category_id'] = this.categoryId;
//     data['category_name'] = this.categoryName;
//     data['food_type'] = this.foodType;
//     data['mrp'] = this.mrp;
//     data['sale_price'] = this.salePrice;
//     data['description'] = this.description;
//     data['rating'] = this.rating;
//     data['no_review'] = this.noReview;
//     data['status'] = this.status;
//     data['cart_details'] = this.cartDetails;
//     return data;
//   }
// }

// class CategoryMenuModel {
//   String? categoryId;
//   String? categoryName;
//   List<ProductList>? productList;

//   CategoryMenuModel({this.categoryId, this.categoryName, this.productList});

//   CategoryMenuModel.fromJson(Map<String, dynamic> json) {
//     categoryId = json['category_id'];
//     categoryName = json['category_name'];
//     if (json['productList'] != null) {
//       productList = <ProductList>[];
//       json['productList'].forEach((v) {
//         productList!.add(new ProductList.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['category_id'] = this.categoryId;
//     data['category_name'] = this.categoryName;
//     if (this.productList != null) {
//       data['productList'] = this.productList!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class BrowseMenu {
//   String? categoryId;
//   String? categoryName;
//   int? count;

//   BrowseMenu({this.categoryId, this.categoryName, this.count});

//   BrowseMenu.fromJson(Map<String, dynamic> json) {
//     categoryId = json['category_id'];
//     categoryName = json['category_name'];
//     count = json['count'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['category_id'] = this.categoryId;
//     data['category_name'] = this.categoryName;
//     data['count'] = this.count;
//     return data;
//   }
// }

class RestaurantViewModel {
  String? status;
  String? message;
  String? productBaseurl;
  String? retailerProfileurl;
  List<ProductList>? productList;
  List<CategoryMenuModel>? categoryMenu;
  List<BrowseMenu>? browseMenu;
  Retailerlist? retailerlist;
  List<SubRetailerlist>? subRetailerlist;

  RestaurantViewModel(
      {this.status,
      this.message,
      this.productBaseurl,
      this.retailerProfileurl,
      this.productList,
      this.categoryMenu,
      this.browseMenu,
      this.retailerlist,
      this.subRetailerlist});

  RestaurantViewModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    productBaseurl = json['product_baseurl'];
    retailerProfileurl = json['retailer_profileurl'];
    if (json['product_list'] != null) {
      productList = <ProductList>[];
      json['product_list'].forEach((v) {
        productList!.add(new ProductList.fromJson(v));
      });
    }
    if (json['category_menu'] != null) {
      categoryMenu = <CategoryMenuModel>[];
      json['category_menu'].forEach((v) {
        categoryMenu!.add(new CategoryMenuModel.fromJson(v));
      });
    }
    if (json['browse_menu'] != null) {
      browseMenu = <BrowseMenu>[];
      json['browse_menu'].forEach((v) {
        browseMenu!.add(new BrowseMenu.fromJson(v));
      });
    }
    retailerlist = json['retailerlist'] != null
        ? new Retailerlist.fromJson(json['retailerlist'])
        : null;
    if (json['Sub_retailerlist'] != null) {
      subRetailerlist = <SubRetailerlist>[];
      json['Sub_retailerlist'].forEach((v) {
        subRetailerlist!.add(new SubRetailerlist.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['product_baseurl'] = this.productBaseurl;
    data['retailer_profileurl'] = this.retailerProfileurl;
    if (this.productList != null) {
      data['product_list'] = this.productList!.map((v) => v.toJson()).toList();
    }
    if (this.categoryMenu != null) {
      data['category_menu'] =
          this.categoryMenu!.map((v) => v.toJson()).toList();
    }
    if (this.browseMenu != null) {
      data['browse_menu'] = this.browseMenu!.map((v) => v.toJson()).toList();
    }
    if (this.retailerlist != null) {
      data['retailerlist'] = this.retailerlist!.toJson();
    }
    if (this.subRetailerlist != null) {
      data['Sub_retailerlist'] =
          this.subRetailerlist!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

// class ProductList {
//   String? id;
//   String? menuName;
//   List<String>? menuImage;
//   String? categoryId;
//   String? categoryName;
//   String? foodType;
//   String? mrp;
//   String? salePrice;
//   String? description;
//   String? rating;
//   String? noReview;
//   int? status;
//   String? cartDetails;

//   ProductList(
//       {this.id,
//       this.menuName,
//       this.menuImage,
//       this.categoryId,
//       this.categoryName,
//       this.foodType,
//       this.mrp,
//       this.salePrice,
//       this.description,
//       this.rating,
//       this.noReview,
//       this.status,
//       this.cartDetails});

//   ProductList.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     menuName = json['menu_name'];
//     menuImage = json['menu_image'].cast<String>();
//     categoryId = json['category_id'];
//     categoryName = json['category_name'];
//     foodType = json['food_type'];
//     mrp = json['mrp'];
//     salePrice = json['sale_price'];
//     description = json['description'];
//     rating = json['rating'];
//     noReview = json['no_review'];
//     status = json['status'];
//     cartDetails = json['cart_details'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['menu_name'] = this.menuName;
//     data['menu_image'] = this.menuImage;
//     data['category_id'] = this.categoryId;
//     data['category_name'] = this.categoryName;
//     data['food_type'] = this.foodType;
//     data['mrp'] = this.mrp;
//     data['sale_price'] = this.salePrice;
//     data['description'] = this.description;
//     data['rating'] = this.rating;
//     data['no_review'] = this.noReview;
//     data['status'] = this.status;
//     data['cart_details'] = this.cartDetails;
//     return data;
//   }
// }

class CategoryMenuModel {
  String? categoryId;
  String? categoryName;
  List<ProductList>? productList;

  CategoryMenuModel({this.categoryId, this.categoryName, this.productList});

  CategoryMenuModel.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    if (json['productList'] != null) {
      productList = <ProductList>[];
      json['productList'].forEach((v) {
        productList!.add(ProductList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.categoryId;
    data['category_name'] = this.categoryName;
    if (this.productList != null) {
      data['productList'] = this.productList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductList {
  String? id;
  String? menuName;
  List<String>? menuImage;
  String? categoryId;
  String? categoryName;
  String? foodType;
  String? mrp;
  String? salePrice;
  String? discount;
  String? description;
  String? rating;
  String? noReview;
  int? status;
  String? cartDetails;
  String? adonStatus;

  ProductList(
      {this.id,
      this.menuName,
      this.menuImage,
      this.categoryId,
      this.categoryName,
      this.foodType,
      this.mrp,
      this.salePrice,
      this.discount,
      this.description,
      this.rating,
      this.noReview,
      this.status,
      this.cartDetails,
      this.adonStatus});

  ProductList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    menuName = json['menu_name'];
    menuImage = json['menu_image'].cast<String>();
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    foodType = json['food_type'];
    mrp = json['mrp'];
    salePrice = json['sale_price'];
    discount = json['discount'];
    description = json['description'];
    rating = json['rating'];
    noReview = json['no_review'];
    status = json['status'];
    cartDetails = json['cart_details'];
    adonStatus = json['adon_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['menu_name'] = this.menuName;
    data['menu_image'] = this.menuImage;
    data['category_id'] = this.categoryId;
    data['category_name'] = this.categoryName;
    data['food_type'] = this.foodType;
    data['mrp'] = this.mrp;
    data['sale_price'] = this.salePrice;
    data['discount'] = this.discount;
    data['description'] = this.description;
    data['rating'] = this.rating;
    data['no_review'] = this.noReview;
    data['status'] = this.status;
    data['cart_details'] = this.cartDetails;
    data['adon_status'] = this.adonStatus;
    return data;
  }
}

class BrowseMenu {
  String? categoryId;
  String? categoryName;
  int? count;

  BrowseMenu({this.categoryId, this.categoryName, this.count});

  BrowseMenu.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.categoryId;
    data['category_name'] = this.categoryName;
    data['count'] = this.count;
    return data;
  }
}

// class Retailerlist {
//   String? id;
//   String? outletName;
//   String? outletImage;
//   String? outletAddress;
//   String? rating;
//   String? noReview;
//   String? lat;
//   String? long;
//   List<Offer>? offer;
//   String? foodType;
//   String? duration;
//   String? distance;
//   String? status;

//   Retailerlist(
//       {this.id,
//       this.outletName,
//       this.outletImage,
//       this.outletAddress,
//       this.rating,
//       this.noReview,
//       this.lat,
//       this.long,
//       this.offer,
//       this.foodType,
//       this.duration,
//       this.distance,
//       this.status});

//   Retailerlist.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     outletName = json['outlet_name'];
//     outletImage = json['outlet_image'];
//     outletAddress = json['outlet_address'];
//     rating = json['rating'];
//     noReview = json['no_review'];
//     lat = json['lat'];
//     long = json['long'];
//     if (json['offer'] != null) {
//       offer = <Offer>[];
//       json['offer'].forEach((v) {
//         offer!.add(new Offer.fromJson(v));
//       });
//     }
//     foodType = json['food_type'];
//     duration = json['duration'];
//     distance = json['distance'];
//     status = json['status'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['outlet_name'] = this.outletName;
//     data['outlet_image'] = this.outletImage;
//     data['outlet_address'] = this.outletAddress;
//     data['rating'] = this.rating;
//     data['no_review'] = this.noReview;
//     data['lat'] = this.lat;
//     data['long'] = this.long;
//     // if (this.offer != null) {
//     //   data['offer'] = this.offer!.map((v) => v.toJson()).toList();
//     // }
//     data['food_type'] = this.foodType;
//     data['duration'] = this.duration;
//     data['distance'] = this.distance;
//     data['status'] = this.status;
//     return data;
//   }
// }

class Offer {
  String? couponName;
  String? percentageAmount;
  String? upTo;

  Offer({this.couponName, this.percentageAmount, this.upTo});

  Offer.fromJson(Map<String, dynamic> json) {
    couponName = json['coupon_name'];
    percentageAmount = json['percentage_amount'];
    upTo = json['up_to'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['coupon_name'] = this.couponName;
    data['percentage_amount'] = this.percentageAmount;
    data['up_to'] = this.upTo;
    return data;
  }
}

class SubRetailerlist {
  String? id;
  String? outletName;
  String? outletImage;
  String? outletAddress;
  String? rating;
  String? noReview;
  String? lat;
  String? long;
  List<Null>? offer;
  String? foodType;
  String? duration;
  String? distance;
  String? status;

  SubRetailerlist(
      {this.id,
      this.outletName,
      this.outletImage,
      this.outletAddress,
      this.rating,
      this.noReview,
      this.lat,
      this.long,
      this.offer,
      this.foodType,
      this.duration,
      this.distance,
      this.status});

  SubRetailerlist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    outletName = json['outlet_name'];
    outletImage = json['outlet_image'];
    outletAddress = json['outlet_address'];
    rating = json['rating'];
    noReview = json['no_review'];
    lat = json['lat'];
    long = json['long'];
    if (json['offer'] != null) {
      // offer = <Null>[];
      // json['offer'].forEach((v) {
      //   offer!.add(new Null.fromJson(v));
      // });
    }
    foodType = json['food_type'];
    duration = json['duration'];
    distance = json['distance'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['outlet_name'] = this.outletName;
    data['outlet_image'] = this.outletImage;
    data['outlet_address'] = this.outletAddress;
    data['rating'] = this.rating;
    data['no_review'] = this.noReview;
    data['lat'] = this.lat;
    data['long'] = this.long;
    // if (this.offer != null) {
    //   data['offer'] = this.offer!.map((v) => v.toJson()).toList();
    // }
    data['food_type'] = this.foodType;
    data['duration'] = this.duration;
    data['distance'] = this.distance;
    data['status'] = this.status;
    return data;
  }
}
