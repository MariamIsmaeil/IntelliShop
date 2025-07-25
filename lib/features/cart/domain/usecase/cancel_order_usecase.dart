import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/cart/data/model/order_model.dart';
import 'package:ecommerce_app/features/cart/domain/repo/order_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class CancelOrderUseCase {
  final OrderRepository repository;

  CancelOrderUseCase(this.repository);

  Future<OrderModel> call(String id) {
    return repository.cancelOrder(id);
  }
}