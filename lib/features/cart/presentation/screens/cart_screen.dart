import 'package:ecommerce_app/core/DI/DI.dart';
import 'package:ecommerce_app/core/resources/assets_manager.dart';
import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:ecommerce_app/core/resources/styles_manager.dart';
import 'package:ecommerce_app/core/resources/values_manager.dart';
import 'package:ecommerce_app/core/routes_manager/routes.dart';
import 'package:ecommerce_app/features/cart/presentation/manager/cart_cubit.dart';
import 'package:ecommerce_app/features/cart/presentation/manager/order_cubit.dart';
import 'package:ecommerce_app/features/cart/presentation/screens/check_outScreen.dart';
import 'package:ecommerce_app/features/products_screen/domain/entity/ProductEntity.dart';
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

              final cartProducts = cartItems
                  .where((item) => item.product != null)
                  .map((item) => item.product!.toProductEntity())
                  .toList();

              return Padding(
                padding: const EdgeInsets.all(AppPadding.p14),
                child: Column(
                  children: [
                    // الجزء المتغير حسب وجود عناصر في السلة
                    Expanded(
                      child: cartItems.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Your cart is empty!\nLet’s fill it with something awesome.",
                                    textAlign: TextAlign.center,
                                    style: getMediumStyle(
                                      fontSize: 18,
                                      color:ColorManager.primary,
                                    ),
                                  ),
                                  SizedBox(height: 20.h),
                                  InkWell(
                                    onTap: (){
                                      Navigator.of(context)
                                          .pushNamedAndRemoveUntil(
                                        Routes.mainRoute,
                                        (route) => false,
                                      );
                                    },
                                    child: Text("Go to Main Store",style:TextStyle(
                                      color: ColorManager.primary,
                                      decoration: TextDecoration.underline,
                                    ) ,)),
                                ],
                              ),
                            )
                          : ListView.separated(
                              itemBuilder: (context, index) => CartItemWidget(
                                onDeleteTap: () => CartCubit.get(context)
                                    .removeFromCart(cartItems[index]
                                        .product!
                                        .id
                                        .toString()),
                                onDecrementTap: (value) =>
                                    CartCubit.get(context).addToCart(
                                        cartItems[index].product!.id.toString(),
                                        "1"),
                                onIncrementTap: (value) =>
                                    CartCubit.get(context).addToCart(
                                        cartItems[index].product!.id.toString(),
                                        "1"),
                                cartItem: cartItems[index],
                              ),
                              separatorBuilder: (context, index) =>
                                  SizedBox(height: AppSize.s12.h),
                              itemCount: cartItems.length,
                            ),
                    ),

                    // يظهر دائمًا سواء السلة فاضية أو لا
                    TotalPriceAndCheckoutBotton(
                      cartItems: cartItems,
                      checkoutButtonOnTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => MultiBlocProvider(
                              providers: [
                                BlocProvider.value(
                                    value: BlocProvider.of<CartCubit>(context)),
                                BlocProvider(
                                    create: (_) => getIt<OrderCubit>()),
                              ],
                              child: CheckoutScreen(
                                total: cartProducts.fold(0.0, (sum, product) {
                                  final price = product.price ?? 0.0;
                                  final discount = double.tryParse(
                                          product.discountInPercentage ??
                                              "0") ??
                                      0.0;
                                  final discountedPrice =
                                      price * (1 - discount / 100);
                                  return sum + discountedPrice;
                                }),
                                cartItems: [],
                              ),
                            ),
                          ),
                        );
                      },
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
