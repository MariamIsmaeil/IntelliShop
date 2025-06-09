
import 'package:ecommerce_app/features/search/domain/entity/recommendations_entity.dart';
import 'package:ecommerce_app/features/search/domain/entity/search_entity.dart';
import 'package:ecommerce_app/features/search/data/repo_impl/SearchRepositoryImpl.dart';
import 'package:injectable/injectable.dart';

import 'package:dartz/dartz.dart';

@injectable
class SearchProductsUseCase {
  final SearchRepository _searchRepository;

  @factoryMethod
  SearchProductsUseCase(this._searchRepository);

  Future<Either<SearchEntity, String>> call(String query) {
    return _searchRepository.searchProducts(query);
  }
}

@injectable
class GetRecommendationsUseCase {
  final SearchRepository _searchRepository;

  @factoryMethod
  GetRecommendationsUseCase(this._searchRepository);

  Future<Either<RecommendationsEntity, String>> call() {
    return _searchRepository.getRecommendations();
  }
}
