import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/features/products_screen/domain/entity/AddCartEntity/AddCartEntity.dart';
import 'package:ecommerce_app/features/products_screen/domain/entity/AddWishlistEntity/AddWishlistEntity.dart';
import 'package:ecommerce_app/features/products_screen/domain/entity/ProductEntity.dart';
import 'package:ecommerce_app/features/products_screen/domain/entity/ProductsResponseEntity.dart';
import 'package:ecommerce_app/features/products_screen/domain/usecase/AddToCartUseCase.dart';
import 'package:ecommerce_app/features/products_screen/domain/usecase/AddToWishlistUseCase.dart';
import 'package:ecommerce_app/features/products_screen/domain/usecase/GetProductsOfCategoryUseCase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'products_state.dart';

@injectable
class ProductsCubit extends Cubit<ProductsState> {
  @factoryMethod
  ProductsCubit(this.addToCartUseCase, this.getProductsOfCategoryUseCase,
      this.addToWishlistUseCase,this.removeFromWishlistUseCase)
      : super(ProductsInitial());
  static ProductsCubit get(context) => BlocProvider.of(context);
  GetProductsOfCategoryUseCase getProductsOfCategoryUseCase;
  AddToWishlistUseCase addToWishlistUseCase;
  AddToCartUseCase addToCartUseCase;
  RemoveFromWishlistUseCase removeFromWishlistUseCase;
  GetProductsFromCategory(String categorySlug) async {
    emit(ProductsLoadingState());
    var result = await getProductsOfCategoryUseCase.call(categorySlug);
    result.fold((response) {
      emit(ProductsSuccessState(response));
    }, (error) {
      emit(ProductsErrorState(error));
    });
  }
  Future<void> removeProductFromWishlist(String id) async {
    emit(RemoveWishListLoadingState(id));
    
    final result = await removeFromWishlistUseCase.call(id);
    
    result.fold(
      (response) {
        emit(RemoveWishListSuccessState(
          "تمت الإزالة من المفضلة بنجاح", 
          id
        ));
      },
      (error) {
        emit(RemoveWishListErrorState(
          error.toString(),
          id
        ));
      },
    );
  }
  Future<void> AddProductWish(String id) async {
    emit(AddWishListLoadingState(id));
    var result = await addToWishlistUseCase.call(id);
    result.fold((addWishlistEntity) {
      if (addWishlistEntity.status == true) {
        emit(AddWishListSuccessState(
            addWishlistEntity.message ?? "Added to wishlist", id));
      } else if (addWishlistEntity.message ==
          "The product is already in your wishlist.") {
        emit(AlreadyInWishlistState(
            addWishlistEntity.message ?? "Product already in wishlist"));
      } else {
        emit(ProductsErrorState(
            addWishlistEntity.message ?? "Failed to add to wishlist"));
      }
    }, (error) {
      emit(ProductsErrorState(error));
    });
  }

  AddProductToCart(String id, String quantity) async {
    emit(AddCartLoadingState(id));

    var result = await addToCartUseCase.call(id, quantity);

    result.fold((responseModel) {
      final entity = responseModel.toCartEntity();
      emit(AddCartSuccessState(entity, id));
    }, (error) {
      emit(AddCartErrorState(error, id));
    });
  }
  Future<void> toggleWishlistProduct(String id, bool isCurrentlyFavorite) async {
    if (isCurrentlyFavorite) {
      await removeProductFromWishlist(id);
    } else {
      await AddProductWish(id);
    }
  }
}
