part of 'search_cubit.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final List<ProductEntity> products;

  SearchSuccess(this.products);
}

class SearchError extends SearchState {
  final String error;

  SearchError(this.error);
}

class RecommendationsLoading extends SearchState {}

class RecommendationsSuccess extends SearchState {
  final List<ProductEntity> products;

  RecommendationsSuccess(this.products);
}

class RecommendationsError extends SearchState {
  final String error;

  RecommendationsError(this.error);
}