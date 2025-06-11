import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/network/api_manager.dart';
import 'package:ecommerce_app/core/network/endpoint.dart';
import 'package:ecommerce_app/core/network/InternetChecker.dart';
import 'package:ecommerce_app/features/cart/data/model/order_model.dart';
import 'package:ecommerce_app/features/cart/domain/repo/order_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: OrderRepository)

class OrderRepositoryImpl implements OrderRepository {
  final ApiManager apiManager;

  OrderRepositoryImpl(this.apiManager);

  @override
  Future<CheckoutResponseModel> checkout({
    required String firstName,
    required String lastName,
    required String email,
    required String phoneNumber,
    required String addressOne,
    required String addressTwo,
    required String postalCode,
  }) async {
    try {
      final response = await apiManager.PostRequestRawData(
        Endpoint.checkoutEndpoint,
        body: {
          'first_name': firstName,
          'last_name': lastName,
          'email': email,
          'phone_number': phoneNumber,
          'address_one': addressOne,
          'address_two': addressTwo,
          'postal_code': postalCode,
        },
      );
      return CheckoutResponseModel.fromJson(response.data);
    } catch (e) {
      // You can log or rethrow with a custom exception
      throw Exception('Checkout failed: $e');
    }
  }

  @override
  Future<List<OrderModel>> getOrders() async {
    try {
      final response = await apiManager.GetRequest(Endpoint.ordersEndpoint);
      final orderResponse = OrderResponseModel.fromJson(response.data);
      return orderResponse.orders ?? [];
    } catch (e) {
      throw Exception('Fetching orders failed: $e');
    }
  }

  @override
  Future<OrderModel> getOrderById(String id) async {
    try {
      final response = await apiManager.GetRequest(
        Endpoint.orderByIdEndpoint(id),
      );
      final orderResponse = OrderResponseModel.fromJson(response.data);
      return orderResponse.order!;
    } catch (e) {
      throw Exception('Fetching order by ID failed: $e');
    }
  }

  @override
  Future<OrderModel> cancelOrder(String id) async {
    try {
      final response = await apiManager.PostRequestRawData(
        Endpoint.cancelOrderEndpoint(id),
      );
      final orderResponse = OrderResponseModel.fromJson(response.data);
      return orderResponse.order!;
    } catch (e) {
      throw Exception('Cancel order failed: $e');
    }
  }
}
