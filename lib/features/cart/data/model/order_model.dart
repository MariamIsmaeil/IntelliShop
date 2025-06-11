class OrderModel {
  final int id;
  final String number;
  final String status;
  final String shippingCharges;
  final String tax;
  final String? discount;
  final String totalPrice;
  final String createdAt;
  final CustomerDetailsModel customerDetails;
  final List<OrderItemModel> items;

  OrderModel({
    required this.id,
    required this.number,
    required this.status,
    required this.shippingCharges,
    required this.tax,
    this.discount,
    required this.totalPrice,
    required this.createdAt,
    required this.customerDetails,
    required this.items,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      number: json['number'],
      status: json['status'],
      shippingCharges: json['shipping_charges'],
      tax: json['tax'],
      discount: json['discount'],
      totalPrice: json['total_price'],
      createdAt: json['created_at'],
      customerDetails: CustomerDetailsModel.fromJson(json['customer_details']),
      items: List<OrderItemModel>.from(
          json['items'].map((x) => OrderItemModel.fromJson(x))),
    );
  }
}

class CustomerDetailsModel {
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String addressOne;
  final String addressTwo;
  final String postalCode;

  CustomerDetailsModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.addressOne,
    required this.addressTwo,
    required this.postalCode,
  });

  factory CustomerDetailsModel.fromJson(Map<String, dynamic> json) {
    return CustomerDetailsModel(
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      phoneNumber: json['phone_number'],
      addressOne: json['address_one'],
      addressTwo: json['address_two'],
      postalCode: json['postal_code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone_number': phoneNumber,
      'address_one': addressOne,
      'address_two': addressTwo,
      'postal_code': postalCode,
    };
  }
}

class OrderItemModel {
  final int productId;
  final int brandId;
  final String productName;
  final String productPrice;
  final String productImage;
  final int quantity;
  final String totalPrice;

  OrderItemModel({
    required this.productId,
    required this.brandId,
    required this.productName,
    required this.productPrice,
    required this.productImage,
    required this.quantity,
    required this.totalPrice,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      productId: json['product_id'],
      brandId: json['brand_id'],
      productName: json['product_name'],
      productPrice: json['product_price'],
      productImage: json['product_image'],
      quantity: json['quantity'],
      totalPrice: json['total_price'],
    );
  }
}

class OrderResponseModel {
  final bool status;
  final String message;
  final OrderModel? order;
  final List<OrderModel>? orders;

  OrderResponseModel({
    required this.status,
    required this.message,
    this.order,
    this.orders,
  });

  factory OrderResponseModel.fromJson(Map<String, dynamic> json) {
    return OrderResponseModel(
      status: json['status'],
      message: json['message'],
      order: json['data'] != null && json['data'] is Map
          ? OrderModel.fromJson(json['data'])
          : null,
      orders: json['data'] != null && json['data'] is List
          ? List<OrderModel>.from(
              json['data'].map((x) => OrderModel.fromJson(x)))
          : null,
    );
  }
}

class CheckoutResponseModel {
  final bool status;
  final String message;
  final String orderNumber;

  CheckoutResponseModel({
    required this.status,
    required this.message,
    required this.orderNumber,
  });

  factory CheckoutResponseModel.fromJson(Map<String, dynamic> json) {
    return CheckoutResponseModel(
      status: json['status'],
      message: json['message'],
      orderNumber: json['order_number'],
    );
  }
}