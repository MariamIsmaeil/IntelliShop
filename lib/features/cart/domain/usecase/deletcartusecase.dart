import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/cart/domain/repo/CartRepo.dart';
import 'package:ecommerce_app/features/products_screen/data/model/AddCart/AddCartModel.dart';

class DeleteCartUseCase {
  final CartRepo repo;

  DeleteCartUseCase(this.repo);

  Future<Either<AddToCartResponseModel, String>> call() async {
    return await repo.deleteCart();
  }
}
