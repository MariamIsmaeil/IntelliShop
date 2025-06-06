
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:ecommerce_app/core/resources/styles_manager.dart';
import 'package:ecommerce_app/core/routes_manager/routes.dart';
import 'package:ecommerce_app/features/products_screen/data/model/AddCart/CartitemModel.dart';
import 'package:flutter/material.dart';

class CartItemWidget extends StatelessWidget {
  final CartItemModel cartItem;
  final Function() onDeleteTap;
  final Function(int) onDecrementTap;
  final Function(int) onIncrementTap;

  const CartItemWidget({
    super.key,
    required this.cartItem,
    required this.onDeleteTap,
    required this.onDecrementTap,
    required this.onIncrementTap,
  });

  @override
  Widget build(BuildContext context) {
    final product = cartItem.product;

    if (product == null) return SizedBox();

    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.productDetails,
          arguments: product.toProductEntity(), // تأكد أن عندك method toEntity() في ProductModel
        );
      },
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Product Image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: product.image ?? '',
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) =>
                    Icon(Icons.image_not_supported),
              ),
            ),

            SizedBox(width: 12),

            // Product Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name ?? 'No title',
                    style: getMediumStyle(fontSize: 14, color: Colors.black),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Text(
                    'EGP ${cartItem.total}',
                    style: getBoldStyle(fontSize: 14, color: ColorManager.primary),
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => onDecrementTap(cartItem.quantity),
                        icon: Icon(Icons.remove),
                      ),
                      Text(
                        cartItem.quantity.toString(),
                        style: getRegularStyle(fontSize: 14, color: Colors.white),
                      ),
                      IconButton(
                        onPressed: () => onIncrementTap(cartItem.quantity),
                        icon: Icon(Icons.add),
                      ),
                      IconButton(
                        onPressed: onDeleteTap,
                        icon: Icon(Icons.delete, color: Colors.red),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
