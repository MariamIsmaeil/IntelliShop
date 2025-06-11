import 'package:ecommerce_app/features/products_screen/domain/entity/AddWishlistEntity/AddWishlistEntity.dart';

class AddWishlistModel {
  AddWishlistModel({
    this.status, 
    this.message, 
  });

  AddWishlistModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
  }

  bool? status;
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    return map;
  }

  AddWishlistEntity toWishlistEntity() {
    return AddWishlistEntity(
      status: status,
      message: message,
    );
  }
}