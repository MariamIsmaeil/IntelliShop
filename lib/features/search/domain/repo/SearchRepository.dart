import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/search/domain/entity/recommendations_entity.dart';
import 'package:ecommerce_app/features/search/domain/entity/search_entity.dart';

abstract class SearchRepository {
  Future<Either<SearchEntity, String>> searchProducts(String query);
  Future<Either<RecommendationsEntity, String>> getRecommendations();
}
