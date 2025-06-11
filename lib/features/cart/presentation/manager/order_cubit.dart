import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/features/cart/data/model/order_model.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import 'package:ecommerce_app/features/cart/domain/usecase/cancel_order_usecase.dart';
import 'package:ecommerce_app/features/cart/domain/usecase/checkout_usecase.dart';
import 'package:ecommerce_app/features/cart/domain/usecase/get_order_by_id_usecase.dart';
import 'package:ecommerce_app/features/cart/domain/usecase/get_orders_usecase.dart';

part 'order_state.dart';

@injectable
class OrderCubit extends Cubit<OrderState> {
  final CheckoutUseCase checkoutUseCase;
  final GetOrdersUseCase getOrdersUseCase;
  final GetOrderByIdUseCase getOrderByIdUseCase;
  final CancelOrderUseCase cancelOrderUseCase;

  OrderCubit({
    required this.checkoutUseCase,
    required this.getOrdersUseCase,
    required this.getOrderByIdUseCase,
    required this.cancelOrderUseCase,
  }) : super(OrderInitial());

  Future<void> checkout({
    required String firstName,
    required String lastName,
    required String email,
    required String phoneNumber,
    required String addressOne,
    required String addressTwo,
    required String postalCode,
  }) async {
    emit(OrderLoading());
    try {
      final response = await checkoutUseCase.call(
        firstName: firstName,
        lastName: lastName,
        email: email,
        phoneNumber: phoneNumber,
        addressOne: addressOne,
        addressTwo: addressTwo,
        postalCode: postalCode,
      );
      emit(OrderCheckoutSuccess(response));
    } catch (e) {
      emit(OrderError(_mapExceptionToMessage(e)));
    }
  }

  Future<void> getOrders() async {
    emit(OrderLoading());
    try {
      final orders = await getOrdersUseCase.call();
      emit(OrdersLoaded(orders));
    } catch (e) {
      emit(OrderError(_mapExceptionToMessage(e)));
    }
  }

  Future<void> getOrderById(String id) async {
    emit(OrderLoading());
    try {
      final order = await getOrderByIdUseCase.call(id);
      emit(OrderLoaded(order));
    } catch (e) {
      emit(OrderError(_mapExceptionToMessage(e)));
    }
  }

  Future<void> cancelOrder(String id) async {
    emit(OrderLoading());
    try {
      final order = await cancelOrderUseCase.call(id);
      emit(OrderCancelled(order));
    } catch (e) {
      emit(OrderError(_mapExceptionToMessage(e)));
    }
  }

  String _mapExceptionToMessage(Object e) {
    final errorMessage = e.toString();
    if (errorMessage.contains('SocketException')) {
      return 'No internet connection';
    } else if (errorMessage.contains('Exception')) {
      return 'Server error';
    } else {
      return 'Unexpected error';
    }
  }
}
