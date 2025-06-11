import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/cart/data/model/order_model.dart';
import 'package:ecommerce_app/features/cart/domain/repo/order_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class CheckoutUseCase {
  final OrderRepository repository;

  CheckoutUseCase(this.repository);

  Future<CheckoutResponseModel> call({
    required String firstName,
    required String lastName,
    required String email,
    required String phoneNumber,
    required String addressOne,
    required String addressTwo,
    required String postalCode,
  }) {
    return repository.checkout(
      firstName: firstName,
      lastName: lastName,
      email: email,
      phoneNumber: phoneNumber,
      addressOne: addressOne,
      addressTwo: addressTwo,
      postalCode: postalCode,
    );
  }
}