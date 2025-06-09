import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/search/data/data_source/SearchRemoteDataSource.dart';
import 'package:ecommerce_app/features/search/data/data_source/search_dao.dart';
import 'package:ecommerce_app/features/search/domain/entity/recommendations_entity.dart';
import 'package:ecommerce_app/features/search/domain/entity/search_entity.dart';
import 'package:injectable/injectable.dart';

abstract class SearchRepository {
  Future<Either<SearchEntity, String>> searchProducts(String query);
  Future<Either<RecommendationsEntity, String>> getRecommendations();
}

@Injectable(as: SearchRepository)
class SearchRepositoryImpl implements SearchRepository {
  final SearchRemoteDataSource _searchRemoteDataSource;

  SearchRepositoryImpl(this._searchRemoteDataSource);

  @override
  Future<Either<SearchEntity, String>> searchProducts(String query) async {
    try {
      final response = await _searchRemoteDataSource.searchProducts(query);
      // هنا بنحول SearchModel لـ Left<Either>
      return Left(response);
    } catch (e) {
      return Right(e.toString());
    }
  }

  @override
  Future<Either<RecommendationsEntity, String>> getRecommendations() async {
    try {
      final response = await _searchRemoteDataSource.getRecommendations();
      return Left(response);
    } catch (e) {
      return Right(e.toString());
    }
  }
}
