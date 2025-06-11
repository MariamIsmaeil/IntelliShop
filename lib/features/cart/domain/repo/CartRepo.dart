import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/products_screen/data/model/AddCart/CartModel.dart';

import '../../../products_screen/data/model/AddCart/AddCartModel.dart';

abstract class CartRepo {
  Future<Either<CartResponseModel, String>> getCart();
  Future<Either<AddToCartResponseModel, String>> addToCart(String productId, String quantity);
  Future<Either<AddToCartResponseModel, String>> removeFromCart(String productId);
  Future<Either<AddToCartResponseModel, String>> deleteCart();
}