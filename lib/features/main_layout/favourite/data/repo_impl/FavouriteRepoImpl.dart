import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/network/InternetChecker.dart';
import 'package:ecommerce_app/features/main_layout/favourite/data/dao/FavouriteDao.dart';
import 'package:ecommerce_app/features/main_layout/favourite/domain/repo/FavouriteRepo.dart';
import 'package:ecommerce_app/features/products_screen/data/model/ProductModel.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: FavouriteRepo)
class FavouriteRepoImpl extends FavouriteRepo {
  FavouriteDao apiDao;
  
  @factoryMethod
  FavouriteRepoImpl(this.apiDao);

  @override
  Future<Either<List<ProductModel>, String>> GetFavourites() async {
    bool isConnected = await InternetChecker.CheckNetwork();
    if (isConnected) {
      var result = await apiDao.GetFavourites();
      return result.fold((wishlistResponse) {
        // Extract products from wishlist items
        var products = wishlistResponse.data?.map((item) => item.product!).toList() ?? [];
        return Left(products);
      }, (error) {
        return Right(error);
      });
    } else {
      return Right("No Internet Connection");
    }
  }

  @override
  Future<Either<String, String>> AddToWishList(String productId) async {
    bool isConnected = await InternetChecker.CheckNetwork();
    if (isConnected) {
      return await apiDao.AddToWishList(productId);
    } else {
      return Right("No Internet Connection");
    }
  }

  @override
  Future<Either<String, String>> RemoveFromWishList(String wishlistItemId) async {
    bool isConnected = await InternetChecker.CheckNetwork();
    if (isConnected) {
      return await apiDao.RemoveFromWishList(wishlistItemId);
    } else {
      return Right("No Internet Connection");
    }
  }
}