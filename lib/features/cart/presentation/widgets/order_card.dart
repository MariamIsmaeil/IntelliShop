import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:ecommerce_app/core/resources/font_manager.dart';
import 'package:ecommerce_app/core/resources/styles_manager.dart';
import 'package:ecommerce_app/features/cart/data/model/order_model.dart';
import 'package:flutter/material.dart';

class OrderCard extends StatelessWidget {
  final OrderModel order;
  final VoidCallback onCancel;

  const OrderCard({super.key, required this.order, required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order #${order.number}',
                  style: getSemiBoldStyle(fontSize: FontSize.s16, color: ColorManager.appBarTitleColor),
                ),
                Chip(
                  label: Text(
                    order.status,
                    style: getRegularStyle(color: Colors.white),
                  ),
                  backgroundColor: _getStatusColor(order.status),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              'Date: ${order.createdAt}',
              style: getRegularStyle(color: ColorManager.grey),
            ),
            SizedBox(height: 10),
            Text(
              'Total: ${order.totalPrice} EGP',
              style: TextStyle(fontSize: FontSize.s16),
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${order.items.length} items',
                  style: getRegularStyle(color: ColorManager.grey),
                ),
                if (order.status.toLowerCase() == 'pending')
                  TextButton(
                    onPressed: onCancel,
                    child: Text(
                      'Cancel Order',
                      style: getMediumStyle(color: Colors.red),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.blue;
    }
  }
}