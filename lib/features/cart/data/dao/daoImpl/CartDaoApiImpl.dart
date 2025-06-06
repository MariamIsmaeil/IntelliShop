import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/network/api_manager.dart';
import 'package:ecommerce_app/core/network/endpoint.dart';
import 'package:ecommerce_app/core/prefrences/PrefsHandler.dart';
import 'package:ecommerce_app/features/cart/data/dao/CartDao.dart';
import 'package:ecommerce_app/features/products_screen/data/model/AddCart/AddCartModel.dart';
import 'package:ecommerce_app/features/products_screen/data/model/AddCart/CartModel.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CartDao)
class CartDaoApiImpl extends CartDao {
  final ApiManager apiManager;

  @factoryMethod
  CartDaoApiImpl(this.apiManager);

  @override
  Future<Either<CartResponseModel, String>> getCart() async {
    try {
      var result = await apiManager.GetRequest(
        Endpoint.cartEndpoint,
        // headers: {
        //   'Authorization': 'Bearer ${PrefsHandler.getToken()}',
        //   'Accept': 'application/json',
        // },
      );
      return Left(CartResponseModel.fromJson(result.data));
    } catch (e) {
      return Right(e.toString());
    }
  }

  @override
  Future<Either<AddToCartResponseModel, String>> addToCart(
      String productId, String quantity) async {
    try {
      var result = await apiManager.PostRequestRawData(
        "${Endpoint.cartEndpoint}/add",
        body: {
          "product_id": productId,
          "quantity": quantity,
        },
        // headers: {
        //   'Authorization': 'Bearer ${PrefsHandler.getToken()}',
        //   'Accept': 'application/json',
        // },
      );
      return Left(AddToCartResponseModel.fromJson(result.data));
    } catch (e) {
      return Right(e.toString());
    }
  }

  @override
  Future<Either<AddToCartResponseModel, String>> removeFromCart(
      String productId) async {
    try {
      var result = await apiManager.PostRequestRawData(
        "${Endpoint.cartEndpoint}/remove",
        body: {
          "product_id": productId,
        },
        // headers: {
        //   'Authorization': 'Bearer ${PrefsHandler.getToken()}',
        //   'Accept': 'application/json',
        // },
      );
      return Left(AddToCartResponseModel.fromJson(result.data));
    } catch (e) {
      return Right(e.toString());
    }
  }

  @override
  Future<Either<AddToCartResponseModel, String>> deleteCart() async {
    try {
      var result = await apiManager.PostRequestRawData(
        "${Endpoint.cartEndpoint}/delete",
        // headers: {
        //   'Authorization': 'Bearer ${PrefsHandler.getToken()}',
        //   'Accept': 'application/json',
        // },
      );
      return Left(AddToCartResponseModel.fromJson(result.data));
    } catch (e) {
      return Right(e.toString());
    }
  }
}
