import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/network/InternetChecker.dart';
import 'package:ecommerce_app/features/products_screen/data/datasource/ProductsDao.dart';
import 'package:ecommerce_app/features/products_screen/domain/entity/AddCartEntity/AddCartEntity.dart';
import 'package:ecommerce_app/features/products_screen/domain/entity/AddWishlistEntity/AddWishlistEntity.dart';
import 'package:ecommerce_app/features/products_screen/domain/entity/ProductsResponseEntity.dart';
import 'package:ecommerce_app/features/products_screen/domain/repository/ProductsRepo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProductsRepo)
class ProductsRepoImpl extends ProductsRepo {
  ProductsDao apiDao;
  @factoryMethod
  ProductsRepoImpl(this.apiDao);
  @override
  Future<Either<ProductsResponseEntity, String>> GetProductsFromCategory(
      String categorySlug) async {
    bool isConnected = await InternetChecker.CheckNetwork();
    if (isConnected) {
      var result = await apiDao.GetProductsFromCategory(categorySlug);
      return result.fold((model) {
        return Left(model.toProductsResponseEntity());
      }, (error) {
        return Right(error);
      });
    } else {
      return Right("No Internet Connection");
    }
  }

  @override
Future<Either<AddWishlistEntity, String>> AddToWishList(String id) async {
  bool isConnected = await InternetChecker.CheckNetwork();
  if (isConnected) {
    var result = await apiDao.AddToWishList(id);
    return result.fold((model) {
      if (model.status == false) {
        return Right(model.message ?? "Failed to add to wishlist");
      } else {
        return Left(model.toWishlistEntity());
      }
    }, (error) {
      return Right(error);
    });
  } else {
    return Right("No Internet Connection");
  }
}

  @override
Future<Either<AddCartEntity, String>> AddToCart(String id) async {
  bool isConnected = await InternetChecker.CheckNetwork();
  if (isConnected) {
    var result = await apiDao.AddToCart(id);
    return result.fold(
      (model) => Left(model.toCartEntity()),
      (error) => Right(error),
    );
  } else {
    return Right("No Internet Connection");
  }
}

  @override
Future<Either<removeFromWishlistEntity, String>> RemoveFromWishList(String id) async {
  bool isConnected = await InternetChecker.CheckNetwork();
  if (isConnected) {
    var result = await apiDao.RemoveFromWishList(id);
    return result.fold((model) {
      if (model.status == false) {
        return Right(model.message ?? "Failed to remove from wishlist");
      } else {
        return Left(model.toEntity());
      }
    }, (error) {
      return Right(error);
    });
  } else {
    return Right("No Internet Connection");
  }
}
}
