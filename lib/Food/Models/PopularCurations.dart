class PopularCurationsResponseModel {
  String? status;
  String? message;
  String? menuBaseurl;
  List<CategoryList>? categoryList;

  PopularCurationsResponseModel(
      {this.status, this.message, this.menuBaseurl, this.categoryList});

  PopularCurationsResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    menuBaseurl = json['menu_baseurl'];
    if (json['category_list'] != null) {
      categoryList = <CategoryList>[];
      json['category_list'].forEach((v) {
        categoryList!.add(new CategoryList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['menu_baseurl'] = this.menuBaseurl;
    if (this.categoryList != null) {
      data['category_list'] =
          this.categoryList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryList {
  String? id;
  String? typeCategory;
  String? typeId;
  String? formType;
  String? outletId;
  String? name;
  String? description;
  String? image;
  String? status;
  String? createdAt;
  Null? updatedAt;

  CategoryList(
      {this.id,
      this.typeCategory,
      this.typeId,
      this.formType,
      this.outletId,
      this.name,
      this.description,
      this.image,
      this.status,
      this.createdAt,
      this.updatedAt});

  CategoryList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    typeCategory = json['type_category'];
    typeId = json['type_id'];
    formType = json['form_type'];
    outletId = json['outlet_id'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type_category'] = this.typeCategory;
    data['type_id'] = this.typeId;
    data['form_type'] = this.formType;
    data['outlet_id'] = this.outletId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['image'] = this.image;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
