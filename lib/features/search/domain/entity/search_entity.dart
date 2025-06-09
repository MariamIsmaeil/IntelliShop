import 'package:ecommerce_app/features/products_screen/domain/entity/ProductEntity.dart';

class SearchEntity {
  final String status;
  final String message;
  final List<ProductEntity> products;

  SearchEntity({
    required this.status,
    required this.message,
    required this.products,
  });
}