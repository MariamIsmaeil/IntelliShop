import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/cart/data/model/order_model.dart';
import 'package:injectable/injectable.dart';

abstract class OrderRepository {
  Future<CheckoutResponseModel> checkout({
    required String firstName,
    required String lastName,
    required String email,
    required String phoneNumber,
    required String addressOne,
    required String addressTwo,
    required String postalCode,
  });

  Future<List<OrderModel>> getOrders();
  Future<OrderModel> getOrderById(String id);
  Future<OrderModel> cancelOrder(String id);
}