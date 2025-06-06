import 'package:ecommerce_app/features/main_layout/home/data/models/BrandsResponse/BrandModel.dart';
import 'package:ecommerce_app/features/products_screen/data/model/ProductModel.dart';


class CartItemModel {
  final int id;
  final ProductModel? product;
  final int quantity;
  final double total;
  final BrandModel? brand;

  CartItemModel({
    required this.id,
    required this.product,
    required this.quantity,
    required this.total,
    required this.brand,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    print("CartItemModel JSON: $json");
    return CartItemModel(
      id: json['id'],
      product: json['product'] != null ? ProductModel.fromJson(json['product']) : null,
      quantity: json['quantity'],
      total: double.parse(json['total'].toString()),
      brand: json['brand'] != null ? BrandModel.fromJson(json['brand']) : null,
    );
  }
}
