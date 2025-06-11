import 'package:ecommerce_app/features/products_screen/data/model/AddCart/CartitemModel.dart';
import 'package:ecommerce_app/features/products_screen/domain/entity/AddCartEntity/AddCartEntity.dart';



class AddToCartResponseModel {
  final bool? status;
  final String? message;
  final CartDataModel? data;

  AddToCartResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory AddToCartResponseModel.fromJson(Map<String, dynamic> json) {
    return AddToCartResponseModel(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null ? CartDataModel.fromJson(json['data']) : null,
    );
  }

  AddCartEntity toCartEntity() {
    return AddCartEntity(
      status: status.toString(),
      message: message,
      data: data,  // ممكن تعدل هنا لتحويل بيانات data بشكل مناسب
    );
  }
}

class CartDataModel {
  final int id;
  final int userId;
  final String createdAt;
  final String updatedAt;
  final List<CartItemModel> items;

  CartDataModel({
    required this.id,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.items,
  });

  factory CartDataModel.fromJson(Map<String, dynamic> json) {
    return CartDataModel(
      id: json['id'],
      userId: json['user_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      items: (json['items'] as List)
          .map((item) => CartItemModel.fromJson(item))
          .toList(),
    );
  }
}
