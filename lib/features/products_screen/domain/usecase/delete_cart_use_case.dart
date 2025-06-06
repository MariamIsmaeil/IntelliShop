import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/cart/domain/repo/CartRepo.dart';
import 'package:ecommerce_app/features/products_screen/data/model/AddCart/AddCartModel.dart';
import 'package:injectable/injectable.dart';
@injectable
class DeleteCartUseCase {
  final CartRepo repo;

  @factoryMethod
  DeleteCartUseCase(this.repo);

  Future<Either<AddToCartResponseModel, String>> call() => repo.deleteCart();
}
