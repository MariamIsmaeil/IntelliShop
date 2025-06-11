import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:ecommerce_app/core/resources/styles_manager.dart';
import 'package:ecommerce_app/core/resources/values_manager.dart';
import 'package:ecommerce_app/core/widget/custom_elevated_button.dart';
import 'package:ecommerce_app/features/products_screen/domain/entity/ProductEntity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TotalPriceAndCheckoutBotton extends StatelessWidget {
  const TotalPriceAndCheckoutBotton({
    super.key,
    required this.cartProducts,
    required this.checkoutButtonOnTap,
  });

  final List<ProductEntity> cartProducts;
  final void Function() checkoutButtonOnTap;

  double _calculateTotalPrice() {
  double total = 0.0;

  for (var product in cartProducts) {
    final price = product.price ?? 0.0;
    final discount =
        double.tryParse(product.discountInPercentage ?? "0") ?? 0.0;
    final discountedPrice = price * (1 - discount / 100);
    total += discountedPrice; // نضيفه مرة واحدة بس
  }

  return total;
}


  @override
  Widget build(BuildContext context) {
    final totalPrice = _calculateTotalPrice();

    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Total price',
              style: getMediumStyle(
                color: ColorManager.textColor.withOpacity(0.6),
                fontSize: AppSize.s18.sp,
              ),
            ),
            SizedBox(height: 4.h),
            SizedBox(
              width: 90.w,
              child: Text(
                'EGP ${totalPrice.toStringAsFixed(2)}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: getMediumStyle(
                  color: ColorManager.textColor,
                  fontSize: AppSize.s18.sp,
                ),
              ),
            ),
          ],
        ),
        SizedBox(width: 18.h),
        Expanded(
          child: CustomElevatedButton(
            label: 'Check Out',
            onTap: checkoutButtonOnTap,
            suffixIcon: Icon(
              Icons.arrow_forward,
              color: ColorManager.white,
            ),
          ),
        )
      ],
    );
  }
}

