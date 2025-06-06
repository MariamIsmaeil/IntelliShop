import 'package:ecommerce_app/features/products_screen/data/model/AddCart/AddCartModel.dart';
import 'package:ecommerce_app/features/products_screen/data/model/AddCart/CartitemModel.dart';

/// status : "success"
/// message : "Product added successfully to your cart"
/// statusMsg : ""

class AddCartEntity {
  final String? status;
  final String? message;
  final CartDataModel? data;

  AddCartEntity({
    this.status,
    this.message,
    this.data,
  });
}
