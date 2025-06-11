import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/cart/data/model/order_model.dart';
import 'package:ecommerce_app/features/products_screen/data/model/AddCart/CartitemModel.dart';
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
    required List<CartItemModel> cartItems,
  });

  Future<List<OrderModel>> getOrders();
  Future<OrderModel> getOrderById(String id);
  Future<OrderModel> cancelOrder(String id);
}