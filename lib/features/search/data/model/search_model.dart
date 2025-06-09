
import 'package:ecommerce_app/features/products_screen/data/model/ProductModel.dart';
import 'package:ecommerce_app/features/products_screen/data/model/ProductsResponseModel.dart';
import 'package:ecommerce_app/features/search/domain/entity/search_entity.dart';

class SearchModel extends SearchEntity {
  SearchModel({
    required super.status,
    required super.message,
    required super.products,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) {
  return SearchModel(
    status: json['status'],
    message: json['message'],
    products: (json['data'] as List)
        .map((product) => ProductModel.fromJson(product).toProductEntity())
        .toList(),
  );
}

}