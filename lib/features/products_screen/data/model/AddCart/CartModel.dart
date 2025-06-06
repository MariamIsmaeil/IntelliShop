import 'CartitemModel.dart';

/// _id : "67115aeca373b6e0b79d1c33"
/// cartOwner : "67113cf3a373b6e0b79cf2d7"
/// products : [{"count":3,"_id":"67115aeca373b6e0b79d1c34","product":"6428ebc6dc1175abc65ca0b9","price":170}]
/// createdAt : "2024-10-17T18:43:56.425Z"
/// updatedAt : "2024-10-17T18:51:26.259Z"
/// __v : 0
/// totalCartPrice : 510

class CartResponseModel {
  final bool status;
  final String message;
  final List<CartItemModel>? items;

  CartResponseModel({
    required this.status,
    required this.message,
    this.items,
  });

  factory CartResponseModel.fromJson(Map<String, dynamic> json) {
  return CartResponseModel(
    status: json['status'],
    message: json['message'],
    items: json['data'] != null && json['data']['items'] != null
        ? List<CartItemModel>.from(
            json['data']['items'].map((x) => CartItemModel.fromJson(x)))
        : null,
  );
}

}
