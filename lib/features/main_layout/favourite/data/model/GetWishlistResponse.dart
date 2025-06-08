import 'package:ecommerce_app/features/products_screen/data/model/ProductModel.dart';

import 'package:ecommerce_app/features/products_screen/data/model/ProductModel.dart';

class GetWishlistResponse {
  GetWishlistResponse({
    this.data,
  });

  GetWishlistResponse.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(WishlistItem.fromJson(v));
      });
    }
  }

  List<WishlistItem>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class WishlistItem {
  WishlistItem({
    this.id,
    this.productId,
    this.product,
  });

  WishlistItem.fromJson(dynamic json) {
    id = json['id'];
    productId = json['product_id'];
    product = json['product'] != null ? ProductModel.fromJson(json['product']) : null;
  }

  int? id;
  int? productId;
  ProductModel? product;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['product_id'] = productId;
    if (product != null) {
      map['product'] = product?.toJson();
    }
    return map;
  }
} 