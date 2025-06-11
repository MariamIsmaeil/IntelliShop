import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/cart/domain/repo/CartRepo.dart';
import 'package:ecommerce_app/features/products_screen/data/model/AddCart/CartModel.dart';
import 'package:injectable/injectable.dart';

import '../../../products_screen/data/model/AddCart/AddCartModel.dart';
@injectable
class GetCartUseCase {
  final CartRepo repo;

  @factoryMethod
  GetCartUseCase(this.repo);

  Future<Either<CartResponseModel, String>> call() => repo.getCart();
}