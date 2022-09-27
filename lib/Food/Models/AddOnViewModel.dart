class AddOnViewModel {
  String? status;
  String? message;
  List<AddOnData>? adonList;

  AddOnViewModel({this.status, this.message, this.adonList});

  AddOnViewModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['adon_list'] != null) {
      adonList = <AddOnData>[];
      json['adon_list'].forEach((v) {
        adonList!.add(AddOnData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.adonList != null) {
      data['adon_list'] = this.adonList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AddOnData {
  String? id;
  String? menuName;
  String? salePrice;
  String? cartStatus;

  AddOnData({this.id, this.menuName, this.salePrice, this.cartStatus});

  AddOnData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    menuName = json['menu_name'];
    salePrice = json['sale_price'];
    cartStatus = json['cart_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['menu_name'] = this.menuName;
    data['sale_price'] = this.salePrice;
    data['cart_status'] = this.cartStatus;
    return data;
  }
}
