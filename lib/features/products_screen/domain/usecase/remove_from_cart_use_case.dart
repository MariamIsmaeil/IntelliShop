import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/cart/domain/repo/CartRepo.dart';
import 'package:ecommerce_app/features/products_screen/data/model/AddCart/AddCartModel.dart';
import 'package:injectable/injectable.dart';

@injectable
class RemoveFromCartUseCase {
  final CartRepo repo;

  @factoryMethod
  RemoveFromCartUseCase(this.repo);

  Future<Either<AddToCartResponseModel, String>> call(String productId) => 
      repo.removeFromCart(productId);
}