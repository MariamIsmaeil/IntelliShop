part of 'products_cubit.dart';

@immutable
abstract class ProductsState {}

class ProductsInitial extends ProductsState {}
class ProductsLoadingState extends ProductsState{}
class ProductsErrorState extends ProductsState{
  String error;
  ProductsErrorState(this.error);
}
// Make sure your ProductsSuccessState has the products getter:
class ProductsSuccessState extends ProductsState {
  final ProductsResponseEntity productsResponseEntity;
  
  ProductsSuccessState(this.productsResponseEntity);

  List<ProductEntity> get products => productsResponseEntity.data ?? [];
}

class AddWishListLoadingState extends ProductsState{
  String productId;
  AddWishListLoadingState(this.productId);
}
// In your products_state.dart
class AddWishListSuccessState extends ProductsState {
  final String message;
  final String productId;
  AddWishListSuccessState(this.message, this.productId);
}
class AddWishListErrorState extends ProductsState{
  String error;
  AddWishListErrorState(this.error);
}
final class RemoveWishListLoadingState extends ProductsState {
  final String productId;
  RemoveWishListLoadingState(this.productId);
}

final class RemoveWishListSuccessState extends ProductsState {
  final String message;
  final String productId;
  RemoveWishListSuccessState(this.message, this.productId);
}
final class RemoveWishListErrorState extends ProductsState {
  final String error;
  final String productId;
  RemoveWishListErrorState(this.error, this.productId);
}

class AddCartLoadingState extends ProductsState{
  String id;
  AddCartLoadingState(this.id);
}
class AddCartSuccessState extends ProductsState{
  AddCartEntity entity;
  String productId;
  AddCartSuccessState(this.entity,this.productId);
}
class AddCartErrorState extends ProductsState{
  String error;
  String productId;
  AddCartErrorState(this.error,this.productId);
}
class AlreadyInWishlistState extends ProductsState {
  final String message;
  AlreadyInWishlistState(this.message);
}
