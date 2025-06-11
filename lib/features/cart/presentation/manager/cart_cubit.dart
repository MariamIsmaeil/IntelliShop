import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/features/cart/domain/usecase/GetCartUseCase.dart';
import 'package:ecommerce_app/features/products_screen/data/model/AddCart/AddCartModel.dart';
import 'package:ecommerce_app/features/products_screen/data/model/AddCart/CartModel.dart';
import 'package:ecommerce_app/features/products_screen/domain/usecase/AddToCartUseCase.dart';
import 'package:ecommerce_app/features/products_screen/domain/usecase/delete_cart_use_case.dart';
import 'package:ecommerce_app/features/products_screen/domain/usecase/remove_from_cart_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'cart_state.dart';
@injectable
class CartCubit extends Cubit<CartState> {
  final GetCartUseCase getCartUseCase;
  final AddToCartUseCase addToCartUseCase;
  final RemoveFromCartUseCase removeFromCartUseCase;
  final DeleteCartUseCase deleteCartUseCase;

  @factoryMethod
  CartCubit(
    this.getCartUseCase,
    this.addToCartUseCase,
    this.removeFromCartUseCase,
    this.deleteCartUseCase,
  ) : super(CartInitial());

  static CartCubit get(context) => BlocProvider.of(context);

  CartResponseModel? cart;

  Future<void> getCart() async {
    emit(CartLoadingState());
    var result = await getCartUseCase.call();
    result.fold(
      (cartResponse) {
        cart = cartResponse;
        emit(CartSuccessState(cartResponse));
      },
      (error) => emit(CartErrorState(error)),
    );
  }

  Future<void> addToCart(String productId, String quantity) async {
    emit(CartLoadingState());
    var result = await addToCartUseCase.call(productId, quantity);
    result.fold(
      (response) => getCart(), // Refresh cart after adding
      (error) => emit(CartErrorState(error)),
    );
  }

  Future<void> removeFromCart(String productId) async {
    emit(CartLoadingState());
    var result = await removeFromCartUseCase.call(productId);
    result.fold(
      (response) => getCart(), // Refresh cart after removing
      (error) => emit(CartErrorState(error)),
    );
  }

  Future<void> deleteCart() async {
    emit(CartLoadingState());
    var result = await deleteCartUseCase.call();
    result.fold(
      (response) => getCart(), // Refresh cart after deleting
      (error) => emit(CartErrorState(error)),
    );
  }
}
