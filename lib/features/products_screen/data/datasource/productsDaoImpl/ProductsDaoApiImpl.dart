import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce_app/core/network/api_manager.dart';
import 'package:ecommerce_app/core/network/endpoint.dart';
import 'package:ecommerce_app/core/prefrences/PrefsHandler.dart';
import 'package:ecommerce_app/features/products_screen/data/model/AddCart/AddCartModel.dart';
import 'package:ecommerce_app/features/products_screen/data/model/AddWishlistModel/AddWishlistModel.dart';
import 'package:ecommerce_app/features/products_screen/data/model/AddWishlistModel/remove_from_wishlist_model.dart';
import 'package:ecommerce_app/features/products_screen/data/model/ProductsResponseModel.dart';
import 'package:ecommerce_app/features/products_screen/domain/entity/AddWishlistEntity/AddWishlistEntity.dart';
import 'package:injectable/injectable.dart';

import '../ProductsDao.dart';

@Injectable(as: ProductsDao)
class ProductsDaoApiImpl extends ProductsDao {
  ApiManager apiManager;
  
  @factoryMethod
  ProductsDaoApiImpl(this.apiManager);

  @override
  Future<Either<ProductsResponseModel, String>> GetProductsFromCategory(String categorySlug) async {
    try {
      var response = await apiManager.GetRequest(
        Endpoint.productsByCategoryEndpoint(categorySlug)
      );
      return Left(ProductsResponseModel.fromJson(response.data));
    } catch (error) {
      return Right(error.toString());
    }
  }

  @override
Future<Either<AddWishlistModel, String>> AddToWishList(String id) async {
  try {
    var response = await apiManager.PostRequestRawData(
      Endpoint.wishlistEndpoint,
      body: {"product_id": id}, // Changed from productId to product_id
    );
    return Left(AddWishlistModel.fromJson(response.data));
  } catch (error) {
    return Right(error.toString());
  }
}

  @override
  Future<Either<AddToCartResponseModel, String>> AddToCart(String id) async {
    try {
      var response = await apiManager.PostRequestRawData(
        Endpoint.cartEndpoint,
        body: {"productId": id},
        // headers: {"token": PrefsHandler.getToken()}
      );
      return Left(AddToCartResponseModel.fromJson(response.data));
    } catch (error) {
      return Right(error.toString());
    }
  }


  @override
Future<Either<RemoveFromWishlistModel, String>> RemoveFromWishList(String id) async {
  try {
    final response = await apiManager.DeleteRequest(
      Endpoint.removeFromWishlistEndpoint(id),
    );
    return Left(RemoveFromWishlistModel.fromJson(response.data));
  } on DioException catch (e) {
    return Right(e.response?.data['message'] ?? e.message);
  } catch (e) {
    return Right(e.toString());
  }
}
}