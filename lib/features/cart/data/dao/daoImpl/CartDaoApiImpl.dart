import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
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
      );

      // تحقق من حالة الـ response
      if (result.statusCode == 200 || result.statusCode == 201) {
        return Left(AddToCartResponseModel.fromJson(result.data));
      } else {
        return Right('Failed to add to cart: ${result.data}');
      }
    } on DioError catch (e) {
      // طباعة تفاصيل الخطأ من Dio
      print('Dio Error: ${e.response?.data}');
      return Right('Dio Error: ${e.message}');
    } catch (e) {
      return Right('Unknown Error: $e');
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
      );
      return Left(AddToCartResponseModel.fromJson(result.data));
    } catch (e) {
      return Right(e.toString());
    }
  }
}
