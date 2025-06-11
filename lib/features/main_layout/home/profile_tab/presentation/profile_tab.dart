import 'package:ecommerce_app/core/prefrences/PrefsHandler.dart';
import 'package:ecommerce_app/core/resources/assets_manager.dart';
import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:ecommerce_app/core/resources/font_manager.dart';
import 'package:ecommerce_app/core/resources/styles_manager.dart';
import 'package:ecommerce_app/core/resources/values_manager.dart';
import 'package:ecommerce_app/features/cart/data/model/order_model.dart';
import 'package:ecommerce_app/features/cart/presentation/manager/order_cubit.dart';
import 'package:ecommerce_app/features/cart/presentation/widgets/order_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/widget/main_text_field.dart';
import '../../../../../core/widget/validators.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  ProfileTabState createState() => ProfileTabState();
}

class ProfileTabState extends State<ProfileTab> {
  bool isFullNameReadOnly = true;
  bool isEmailReadOnly = true;
  String name = PrefsHandler.getName();
  String email = PrefsHandler.getEmail();
  List<OrderModel> orders = []; // قائمة لتخزين الطلبات
  bool isLoading = false;
  
  @override
  void initState() {
    super.initState();
    _loadOrders();
  }

  Future<void> _loadOrders() async {
    setState(() => isLoading = true);
    try {
      final orderCubit = BlocProvider.of<OrderCubit>(context);
      await orderCubit.getOrders();
      if (!mounted) return; // ✅ مهم لتفادي استخدام context بعد async
      if (orderCubit.state is OrdersLoaded) {
        setState(() => orders = (orderCubit.state as OrdersLoaded).orders);
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load orders: ${e.toString()}')),
      );
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  Future<void> _cancelOrder(String orderId) async {
    try {
      final orderCubit = BlocProvider.of<OrderCubit>(context);
      await orderCubit.cancelOrder(orderId);
      if (!mounted) return;
      if (orderCubit.state is OrderCancelled) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Order cancelled successfully')),
        );
        _loadOrders(); // إعادة تحميل القائمة بعد الإلغاء
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to cancel order: ${e.toString()}')),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p20),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome, to Intellige Shop',
                style: getSemiBoldStyle(
                    color: ColorManager.appBarTitleColor, fontSize: FontSize.s18),
              ),
            const SizedBox(height: 15),
            Divider(thickness: 1,color: ColorManager.appBarTitleColor,),
            const SizedBox(height: 15),
            Text(
              'About Intellige Shop',
              style:getSemiBoldStyle(
                    color: ColorManager.appBarTitleColor, fontSize: FontSize.s18),
              ),
            const SizedBox(height: 10),
            Text(
              'Intellige Shop is the first e-commerce platform specialized in local products. '
              'We connect you with the best local artisans and manufacturers to bring you '
              'authentic and high-quality products.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: ColorManager.primary, fontSize: FontSize.s16,
              ),
            ),
             const SizedBox(height: 15),
            Divider(thickness: 1,color: ColorManager.appBarTitleColor,),
            const SizedBox(height: 15),
              Text(
              'Personal Information ',
              style:getSemiBoldStyle(
                    color: ColorManager.appBarTitleColor, fontSize: FontSize.s18),
              ),
            const SizedBox(height: 10),
              BuildTextField(
                borderBackgroundColor: ColorManager.primary.withOpacity(.5),
                readOnly: isFullNameReadOnly,
                backgroundColor: ColorManager.white,
                label: 'Your full name',
                hint: 'Mariam Ismaeil',
                controller:
                    TextEditingController(text: name),
                labelTextStyle: getMediumStyle(
                    color: ColorManager.primary, fontSize: FontSize.s18),
                suffixIcon: IconButton(
                  icon: SvgPicture.asset(SvgAssets.edit),
                  onPressed: () {
                    setState(() {
                      isFullNameReadOnly = false;
                    });
                  },
                ),
                textInputType: TextInputType.text,
                validation: AppValidators.validateFullName,
                hintTextStyle: getRegularStyle(color: ColorManager.primary)
                    .copyWith(fontSize: 18.sp),
              ),
              SizedBox(height: AppSize.s18.h),
              BuildTextField(
                borderBackgroundColor: ColorManager.primary.withOpacity(.5),
                readOnly: isEmailReadOnly,
                backgroundColor: ColorManager.white,
                label: 'Your email address',
                hint: 'MariamIsmaeil@gmail.com',
                controller: TextEditingController(text: email),
                labelTextStyle: getMediumStyle(
                    color: ColorManager.primary, fontSize: FontSize.s18),
                suffixIcon: IconButton(
                  icon: SvgPicture.asset(SvgAssets.edit),
                  onPressed: () {
                    setState(() {
                      isEmailReadOnly = false;
                    });
                  },
                ),
                textInputType: TextInputType.emailAddress,
                validation: AppValidators.validateEmail,
                hintTextStyle: getRegularStyle(color: ColorManager.primary)
                    .copyWith(fontSize: 18.sp),
              ),
              // SizedBox(height: AppSize.s50.h),
              // Text(
              //   'My Orders',
              //   style: getSemiBoldStyle(
              //       color: ColorManager.appBarTitleColor, fontSize: FontSize.s18),
              // ),
              // const SizedBox(height: 15),
              // Divider(thickness: 1, color: ColorManager.appBarTitleColor),
              // const SizedBox(height: 10),
              // if (isLoading)
              //   Center(child: CircularProgressIndicator())
              // else if (orders.isEmpty)
              //   Text(
              //     'No orders yet',
              //     style: getRegularStyle(color: ColorManager.primary),
              //   )
              // else
              //   ListView.builder(
              //     shrinkWrap: true,
              //     physics: NeverScrollableScrollPhysics(),
              //     itemCount: orders.length,
              //     itemBuilder: (context, index) {
              //       final order = orders[index];
              //       return OrderCard(
              //         order: order,
              //         onCancel: () => _cancelOrder(order.id.toString()),
              //       );
              //     },
              //   ),
            ],
          ),
        ),
      ),
    );
  }
}

