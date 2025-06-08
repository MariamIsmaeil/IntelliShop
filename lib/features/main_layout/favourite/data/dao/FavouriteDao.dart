import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/main_layout/favourite/data/model/GetWishlistResponse.dart';

abstract class FavouriteDao {
  Future<Either<GetWishlistResponse, String>> GetFavourites();
  Future<Either<String, String>> AddToWishList(String productId);
  Future<Either<String, String>> RemoveFromWishList(String wishlistItemId);
}