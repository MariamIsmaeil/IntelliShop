import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/products_screen/data/model/ProductModel.dart';

abstract class FavouriteRepo {
  Future<Either<List<ProductModel>, String>> GetFavourites();
  Future<Either<String, String>> AddToWishList(String productId);
  Future<Either<String, String>> RemoveFromWishList(String wishlistItemId);
}