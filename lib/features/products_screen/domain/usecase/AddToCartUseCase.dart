import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/cart/domain/repo/CartRepo.dart';
import 'package:ecommerce_app/features/products_screen/data/model/AddCart/AddCartModel.dart';
import 'package:ecommerce_app/features/products_screen/domain/repository/ProductsRepo.dart';
import 'package:injectable/injectable.dart';

import '../entity/AddCartEntity/AddCartEntity.dart';
@injectable
class AddToCartUseCase {
  final CartRepo repo;

  @factoryMethod
  AddToCartUseCase(this.repo);

  Future<Either<AddToCartResponseModel, String>> call(String productId, String quantity) => 
      repo.addToCart(productId, quantity);
}