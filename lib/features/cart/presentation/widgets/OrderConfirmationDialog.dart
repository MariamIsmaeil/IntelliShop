import 'package:ecommerce_app/core/routes_manager/routes.dart';
import 'package:ecommerce_app/features/products_screen/data/model/AddCart/CartitemModel.dart';
import 'package:flutter/material.dart';

class OrderConfirmationDialog extends StatelessWidget {
  final List<CartItemModel> cartItems;
  final double subtotal;
  final double shipping;

  const OrderConfirmationDialog({
    super.key,
    required this.cartItems,
    required this.subtotal,
    this.shipping = 50,
  });

  @override
  Widget build(BuildContext context) {
    final total = subtotal + shipping;

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Row(
        children: const [
          Icon(Icons.check_circle, color: Colors.green),
          SizedBox(width: 8),
          Text("Order Confirmed"),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Your order has been placed successfully!"),
            const SizedBox(height: 12),
            const Text("Products:", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),

            ...cartItems.map((item) {
              final product = item.product;
              if (product == null) return const SizedBox(); // تجاهل العناصر اللي مفيهاش منتج

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    SizedBox(
                      width: 40,
                      height: 40,
                      child: Image.network(
                        product.image!,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        "${product.name} x${item.quantity}",
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                    Text("${(product.price ?? 0).toInt()} EGP", style: const TextStyle(fontSize: 14)),

                  ],
                ),
              );
            }),

            const Divider(),
            Text("Subtotal: ${subtotal.toInt()} EGP"),
            Text("Shipping: ${shipping.toInt()} EGP"),
            Text("Total: ${total.toInt()} EGP", style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            const Text("Expected delivery: 5–7 business days"),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
              Routes.mainRoute,
              (route) => false,
            );
          },
          child: const Text("Back to Home"),
        ),
      ],
    );
  }
}
