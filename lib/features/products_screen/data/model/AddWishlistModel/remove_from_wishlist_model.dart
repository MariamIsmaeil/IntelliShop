// في ملف data/model/remove_from_wishlist_model.dart
import 'package:ecommerce_app/features/products_screen/domain/entity/AddWishlistEntity/AddWishlistEntity.dart';

class RemoveFromWishlistModel {
  final bool status;
  final String? message;

  RemoveFromWishlistModel({required this.status, this.message});

  factory RemoveFromWishlistModel.fromJson(Map<String, dynamic> json) {
    return RemoveFromWishlistModel(
      status: json['status'],
      message: json['message'],
    );
  }

  removeFromWishlistEntity toEntity() {
    return removeFromWishlistEntity(
      status: status,
      message: message,
    );
  }
}