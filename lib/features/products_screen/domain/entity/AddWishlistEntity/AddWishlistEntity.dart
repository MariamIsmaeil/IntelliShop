/// statusMsg : ""
/// status : "success"
/// message : "Product added successfully to your wishlist"

class AddWishlistEntity {
  AddWishlistEntity({
    this.status, 
    this.message,
  });

  bool? status;
  String? message;
}
class removeFromWishlistEntity {
  removeFromWishlistEntity({
    this.status, 
    this.message,
  });

  bool? status;
  String? message;
}