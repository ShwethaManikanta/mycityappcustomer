import 'dart:convert';

class PopularDishModel {
  String? category_id;
  String? category_name;
  List<ProductPopularDishModel>? productList;
  PopularDishModel({
    this.category_id,
    this.category_name,
    this.productList,
  });

  PopularDishModel copyWith({
    String? category_id,
    String? category_name,
    List<ProductPopularDishModel>? productList,
  }) {
    return PopularDishModel(
      category_id: category_id ?? this.category_id,
      category_name: category_name ?? this.category_name,
      productList: productList ?? this.productList,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'category_id': category_id,
      'category_name': category_name,
      'productList': productList,
    };
  }

  factory PopularDishModel.fromMap(Map<String, dynamic> map) {
    return PopularDishModel(
      category_id: map['category_id'],
      category_name: map['category_name'],
      productList: List.generate(map['productList'].length, (index) => ProductPopularDishModel(
        duration_lt: map['productList'][index]['duration_lt'],image: map['productList'][index]['image'],id: map['productList'][index]['id'],
          dishes_name: map['productList'][index]['dishes_name'],price: map['productList'][index]['price'],pieces: map['productList'][index]['pieces'],
        discount_amount: map['productList'][index]['discount_amount'],weight:  map['productList'][index]['weight'],
      )),
    );
  }

  String toJson() => json.encode(toMap());

  factory PopularDishModel.fromJson(String source) =>
      PopularDishModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PopularDishModel(category_id: $category_id, category_name: $category_name,'
        ' productList: $productList,)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PopularDishModel &&
        other.category_id == category_id &&
        other.category_name == category_name &&
        other.productList == productList ;
  }

  @override
  int get hashCode {
    return category_id.hashCode ^
    category_name.hashCode ^
    productList.hashCode ;
  }
}

class ProductPopularDishModel {
  String? duration_lt;
  String? id;
  String? dishes_name;
  String? image;
  String? pieces;
  dynamic price;
  String? discount_amount;
  String? weight;
  ProductPopularDishModel({
    this.duration_lt,
    this.id,
    this.dishes_name,
    this.image,
    this.price,
    this.discount_amount,this.pieces,this.weight
  });

  ProductPopularDishModel copyWith({
    String? duration_lt,
    String? id,
    String? dishes_name,
    String? image,
    String? pieces,
    dynamic price,
    String? discount_amount,
    String? weight,
  }) {
    return ProductPopularDishModel(
      duration_lt: duration_lt ?? this.duration_lt,
      id: id ?? this.id,
      dishes_name: dishes_name ?? this.dishes_name,
      image: image ?? this.image,
      price: price ?? this.price,
      pieces: pieces ?? this.pieces,
      discount_amount: discount_amount ?? this.discount_amount,
      weight: weight ?? this.weight
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'duration_lt': duration_lt,
      'id': id,
      'dishes_name': dishes_name,
      'image': image,
      'price' :price,
      'pieces':pieces,
      'discount_amount':discount_amount,
      'weight':weight
    };
  }

  factory ProductPopularDishModel.fromMap(Map<String, dynamic> map) {
    return ProductPopularDishModel(
      duration_lt: map['duration_lt'],
      id: map['id'],
      dishes_name: map['dishes_name'],
      image: map['image'],
      pieces: map['pieces'],
      price: map['price'],
      discount_amount: map['discount_amount'],
      weight: map['weight'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductPopularDishModel.fromJson(String source) =>
      ProductPopularDishModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProductPopularDishModel(duration_lt: $duration_lt, id: $id, dishes_name: $dishes_name, image: $image,pieces : $pieces,price :$price,discount_amount: $discount_amount,weight :$weight)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductPopularDishModel &&
        other.duration_lt == duration_lt &&
        other.id == id &&
        other.dishes_name == dishes_name &&
        other.pieces == pieces &&
        other.price == price &&
        other.discount_amount == discount_amount &&
        other.weight == weight &&
        other.image == image;
  }

  @override
  int get hashCode {
    return duration_lt.hashCode ^
    id.hashCode ^
    dishes_name.hashCode ^
    image.hashCode ^
    pieces.hashCode ^
    price.hashCode ^
    discount_amount.hashCode ^
    weight.hashCode;
  }
}



