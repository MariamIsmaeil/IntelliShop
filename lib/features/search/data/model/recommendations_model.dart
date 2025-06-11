import 'package:ecommerce_app/features/products_screen/data/model/ProductModel.dart';
import 'package:ecommerce_app/features/search/domain/entity/recommendations_entity.dart';

class RecommendationsModel extends RecommendationsEntity {
  RecommendationsModel({
    required super.status,
    required super.message,
    required super.products,
  });

  factory RecommendationsModel.fromJson(Map<String, dynamic> json) {
    return RecommendationsModel(
      status: json['status'],
      message: json['message'],
      products: (json['data'] as List)
          .map((product) => ProductModel.fromJson(product).toProductEntity())
          .toList(),
    );
  }
}
