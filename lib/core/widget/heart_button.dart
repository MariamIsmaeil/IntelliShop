import 'package:ecommerce_app/core/resources/assets_manager.dart';
import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:ecommerce_app/features/products_screen/presentation/manager/products_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HeartButton extends StatelessWidget {
  final String productId;
  final bool isInitiallyFavorite;
  
  const HeartButton({
    super.key,
    required this.productId,
    this.isInitiallyFavorite = false, void Function()? onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductsCubit, ProductsState>(
      listenWhen: (previous, current) {
        return current is AddWishListSuccessState || 
               current is RemoveWishListSuccessState ||
               current is AlreadyInWishlistState ||
               current is AddWishListErrorState ||
               current is RemoveWishListErrorState;
      },
      listener: (context, state) {
        if (state is AddWishListSuccessState && state.productId == productId) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.green,
            ),
          );
        }
        else if (state is RemoveWishListSuccessState && state.productId == productId) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.blue,
            ),
          );
        }
        // معالجة حالات الأخطاء...
      },
      builder: (context, state) {
        final isLoadingAdd = state is AddWishListLoadingState && state.productId == productId;
        final isLoadingRemove = state is RemoveWishListLoadingState && state.productId == productId;
        final isLoading = isLoadingAdd || isLoadingRemove;

        final isFavorite = state is AddWishListSuccessState && state.productId == productId 
                          || (isInitiallyFavorite && 
                              !(state is RemoveWishListSuccessState && state.productId == productId));

        return Stack(
        alignment: Alignment.center,
        children: [
          // الدائرة البيضا الخلفية
          Container(
            width: 40,   // حجم الدائرة
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),  // لون الدائرة وخفيفة شوية شفافية
              shape: BoxShape.circle,
            ),
          ),
          // زرار القلب مع أيقونة التحميل لو فيه تحميل
          IconButton(
            iconSize: 24,
            icon: isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : Colors.grey,
                  ),
            onPressed: () {
              if (!isLoading) {
                context.read<ProductsCubit>().toggleWishlistProduct(
                  productId, 
                  isFavorite
                );
              }
            },
          ),
        ],
      );
    },
  );
}
}