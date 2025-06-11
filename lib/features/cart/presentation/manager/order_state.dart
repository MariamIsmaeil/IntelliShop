part of 'order_cubit.dart';

@immutable
abstract class OrderState {}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrderCheckoutSuccess extends OrderState {
  final CheckoutResponseModel response;
  OrderCheckoutSuccess(this.response);
}

class OrdersLoaded extends OrderState {
  final List<OrderModel> orders;
  OrdersLoaded(this.orders);
}

class OrderLoaded extends OrderState {
  final OrderModel order;
  OrderLoaded(this.order);
}

class OrderCancelled extends OrderState {
  final OrderModel order;
  OrderCancelled(this.order);
}

class OrderError extends OrderState {
  final String message;
  OrderError(this.message);
}
