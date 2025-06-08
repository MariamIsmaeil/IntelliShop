import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/network/api_manager.dart';
import 'package:ecommerce_app/core/network/endpoint.dart';
import 'package:ecommerce_app/features/main_layout/favourite/data/dao/FavouriteDao.dart';
import 'package:ecommerce_app/features/main_layout/favourite/data/model/GetWishlistResponse.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: FavouriteDao)
class FavouriteDaoApiImpl extends FavouriteDao {
  ApiManager apiManager;
  
  @factoryMethod
  FavouriteDaoApiImpl(this.apiManager);

  @override
  Future<Either<GetWishlistResponse, String>> GetFavourites() async {
    try {
      var response = await apiManager.GetRequest(Endpoint.wishlistEndpoint);
      return Left(GetWishlistResponse.fromJson(response.data));
    } catch (e) {
      return Right(e.toString());
    }
  }

  @override
  Future<Either<String, String>> AddToWishList(String productId) async {
    try {
      var response = await apiManager.PostRequestRawData(
        Endpoint.wishlistEndpoint,
        body: {"product_id": productId},
      );
      return Left(response.data['message']);
    } catch (e) {
      return Right(e.toString());
    }
  }

  @override
  Future<Either<String, String>> RemoveFromWishList(String wishlistItemId) async {
    try {
      var response = await apiManager.DeleteRequest(
        "${Endpoint.wishlistEndpoint}/$wishlistItemId",
      );
      return Left(response.data['message']);
    } catch (e) {
      return Right(e.toString());
    }
  }
}