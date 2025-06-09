import 'package:dio/dio.dart';
import 'package:ecommerce_app/core/network/api_manager.dart';
import 'package:ecommerce_app/core/network/endpoint.dart';
import 'package:ecommerce_app/features/search/data/data_source/SearchRemoteDataSource.dart';
import 'package:ecommerce_app/features/search/data/model/recommendations_model.dart';
import 'package:ecommerce_app/features/search/data/model/search_model.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: SearchRemoteDataSource)
class SearchRemoteDataSourceImpl implements SearchRemoteDataSource {
  final ApiManager apiManager;

  @factoryMethod
  SearchRemoteDataSourceImpl(this.apiManager);

  @override
  Future<SearchModel> searchProducts(String query) async {
    try {
      final response = await apiManager.GetRequest(
        Endpoint.searchEndpoint,
        parameters: {'search': query},
      );
      if (query.isEmpty) {
        throw Exception('Search query cannot be empty');
      }

      return SearchModel.fromJson(response.data);
    } catch (error) {
      // هنا ممكن تعملي رمي استثناء أو ترجع null أو خطأ حسب التصميم عندك
      rethrow;
    }
  }

  @override
  Future<RecommendationsModel> getRecommendations() async {
    try {
      final response = await apiManager.GetRequest(
        Endpoint.recommendationsEndpoint,
      );
      return RecommendationsModel.fromJson(response.data);
    } catch (error) {
      rethrow;
    }
  }
}
