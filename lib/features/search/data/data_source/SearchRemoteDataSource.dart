import 'package:ecommerce_app/features/search/data/model/recommendations_model.dart';
import 'package:ecommerce_app/features/search/data/model/search_model.dart';

abstract class SearchRemoteDataSource {
  Future<SearchModel> searchProducts(String query);
  Future<RecommendationsModel> getRecommendations();
}
