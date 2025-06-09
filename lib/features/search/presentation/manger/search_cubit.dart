import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/features/products_screen/domain/entity/ProductEntity.dart';
import 'package:ecommerce_app/features/search/domain/usecase/search_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'search_state.dart';

@injectable
class SearchCubit extends Cubit<SearchState> {
  final SearchProductsUseCase _searchProductsUseCase;
  final GetRecommendationsUseCase _getRecommendationsUseCase;

  @factoryMethod
  SearchCubit(
    this._searchProductsUseCase,
    this._getRecommendationsUseCase,
  ) : super(SearchInitial());

  Future<void> searchProducts(String query) async {
    emit(SearchLoading());
    final response = await _searchProductsUseCase.call(query);

    response.fold(
      (searchEntity) {
        emit(SearchSuccess(searchEntity.products));
      },
      (error) {
        emit(SearchError(error));
      },
    );
  }

  Future<void> getRecommendations() async {
    emit(RecommendationsLoading());
    final response = await _getRecommendationsUseCase.call();

    response.fold(
      (recommendationsEntity) {
        emit(RecommendationsSuccess(recommendationsEntity.products));
      },
      (error) {
        emit(RecommendationsError(error));
      },
    );
  }

  void clearSearch() {
    emit(SearchInitial());
  }
}
