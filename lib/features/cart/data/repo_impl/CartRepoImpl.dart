import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/network/InternetChecker.dart';
import 'package:ecommerce_app/features/cart/data/dao/CartDao.dart';
import 'package:ecommerce_app/features/cart/domain/repo/CartRepo.dart';
import 'package:ecommerce_app/features/products_screen/data/model/AddCart/AddCartModel.dart';
import 'package:ecommerce_app/features/products_screen/data/model/AddCart/CartModel.dart';
import 'package:injectable/injectable.dart';
@Injectable(as: CartRepo)
class CartRepoImpl extends CartRepo {
  final CartDao apiDao;

  @factoryMethod
  CartRepoImpl(this.apiDao);

  @override
  Future<Either<CartResponseModel, String>> getCart() async {
    bool isConnected = await InternetChecker.CheckNetwork();
    if (isConnected) {
      return await apiDao.getCart();
    } else {
      return Right("No Internet Connection");
    }
  }

  @override
  Future<Either<AddToCartResponseModel, String>> addToCart(String productId, String quantity) async {
    bool isConnected = await InternetChecker.CheckNetwork();
    if (isConnected) {
      return await apiDao.addToCart(productId, quantity);
    } else {
      return Right("No Internet Connection");
    }
  }

  @override
  Future<Either<AddToCartResponseModel, String>> removeFromCart(String productId) async {
    bool isConnected = await InternetChecker.CheckNetwork();
    if (isConnected) {
      return await apiDao.removeFromCart(productId);
    } else {
      return Right("No Internet Connection");
    }
  }

  @override
  Future<Either<AddToCartResponseModel, String>> deleteCart() async {
    bool isConnected = await InternetChecker.CheckNetwork();
    if (isConnected) {
      return await apiDao.deleteCart();
    } else {
      return Right("No Internet Connection");
    }
  }
}