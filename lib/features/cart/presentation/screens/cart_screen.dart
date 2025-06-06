import 'package:ecommerce_app/core/DI/DI.dart';
import 'package:ecommerce_app/core/resources/assets_manager.dart';
import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:ecommerce_app/core/resources/styles_manager.dart';
import 'package:ecommerce_app/core/resources/values_manager.dart';
import 'package:ecommerce_app/features/cart/presentation/manager/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/cart_item_widget.dart';
import '../widgets/total_price_and_checkout_botton.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CartCubit>()..getCart(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Cart',
            style: getMediumStyle(fontSize: 20, color: ColorManager.textColor),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {},
              icon: ImageIcon(
                AssetImage(IconsAssets.icSearch),
                color: ColorManager.primary,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: ImageIcon(
                AssetImage(IconsAssets.icCart),
                color: ColorManager.primary,
              ),
            ),
          ],
        ),
        body: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            if (state is CartSuccessState) {
              final cartItems = state.cart.items ?? [];
              final total = cartItems.fold(0.0, (sum, item) => sum + item.total);
              
              return Padding(
                padding: const EdgeInsets.all(AppPadding.p14),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) => CartItemWidget(
                          onDeleteTap: () => CartCubit.get(context)
                            .removeFromCart(cartItems[index].product!.id.toString()),
                          onDecrementTap: (value) => CartCubit.get(context)
                            .addToCart(cartItems[index].product!.id.toString(), (cartItems[index].quantity - 1).toString()),
                          onIncrementTap: (value) => CartCubit.get(context)
                            .addToCart(cartItems[index].product!.id.toString(), (cartItems[index].quantity + 1).toString()),
                          cartItem: cartItems[index],
                        ),
                        separatorBuilder: (context, index) => SizedBox(height: AppSize.s12.h),
                        itemCount: cartItems.length,
                      ),
                    ),
                    TotalPriceAndCheckoutBotton(
                      totalPrice: total.toInt(),
                      checkoutButtonOnTap: () {},
                    ),
                    SizedBox(height: 10.h),
                  ],
                ),
              );
            }
            if (state is CartErrorState) {
              return Center(child: Text(state.error));
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}