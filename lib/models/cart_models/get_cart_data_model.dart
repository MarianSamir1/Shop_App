import '../home_models/home_model.dart';

class CartModel {
  late bool status;
  late CartDataModel data;

  CartModel.fromJason(Map<String, dynamic> json) {
    status = json['status'];
    data = CartDataModel.fromJson(json['data']) ;
  }
}

class CartDataModel {
  List<CartItems> cartItem = [];
  late dynamic subTotale;
  late dynamic total;

  CartDataModel.fromJson(Map<String, dynamic> json) {
    json['cart_items'].forEach((element) {
      cartItem.add(CartItems.fromJson(element));
    });
    subTotale = json['sub_total'];
    total = json['total'];
  }
}

class CartItems {
  late int id;
  late int quantity;
  late ProductsModel productCartData;

  CartItems.fromJson(Map<String, dynamic> json) {
    id =json['id'];
    quantity = json['quantity'];
    productCartData = ProductsModel.fromJson(json['product']);
  }
}

