import 'package:ecommerce_app/features/products_screen/domain/entity/ProductEntity.dart';

class RecommendationsEntity {
  final String status;
  final String message;
  final List<ProductEntity> products;

  RecommendationsEntity({
    required this.status,
    required this.message,
    required this.products,
  });
}