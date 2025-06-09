import 'package:ecommerce_app/core/DI/DI.dart';
import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:ecommerce_app/core/resources/constants_manager.dart';
import 'package:ecommerce_app/core/resources/font_manager.dart';
import 'package:ecommerce_app/core/resources/styles_manager.dart';
import 'package:ecommerce_app/core/resources/values_manager.dart';
import 'package:ecommerce_app/features/products_screen/domain/entity/ProductEntity.dart';
import 'package:ecommerce_app/features/products_screen/presentation/widgets/custom_product_widget.dart';
import 'package:ecommerce_app/features/search/presentation/manger/search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecommendationScreen extends StatefulWidget {
  const RecommendationScreen({super.key});

  @override
  State<RecommendationScreen> createState() => _RecommendationScreenState();
}

class _RecommendationScreenState extends State<RecommendationScreen> {
  final TextEditingController _searchController = TextEditingController();
  late SearchCubit _searchCubit;

  @override
  void initState() {
    super.initState();
    // بدل BlocProvider.of هنا، اعمل create للCubit داخل الشاشة
    _searchCubit = getIt<SearchCubit>();

    _searchCubit.getRecommendations();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchCubit.close(); // مهم تغلق الـ cubit عشان ما يحصل memory leak
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchCubit>.value(
      value: _searchCubit,
      child:  Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: [
              // // Search Bar
              // TextFormField(
              //   controller: _searchController,
              //   cursorColor: ColorManager.primary,
              //   style: getRegularStyle(
              //     color: ColorManager.primary,
              //     fontSize: FontSize.s16,
              //   ),
              //   decoration: InputDecoration(
              //     contentPadding: EdgeInsets.symmetric(
              //       horizontal: AppMargin.m12.w,
              //       vertical: AppMargin.m8.h,
              //     ),
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(10000),
              //       borderSide: BorderSide(
              //         width: AppSize.s1,
              //         color: ColorManager.primary,
              //       ),
              //     ),
              //     focusedBorder: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(10000),
              //       borderSide: BorderSide(
              //         width: AppSize.s1,
              //         color: ColorManager.primary,
              //       ),
              //     ),
              //     prefixIcon: Icon(
              //       Icons.search,
              //       color: ColorManager.primary,
              //     ),
              //     hintText: AppConstants.searchHint,
              //     hintStyle: getRegularStyle(
              //       color: ColorManager.primary,
              //       fontSize: FontSize.s16,
              //     ),
              //     suffixIcon: IconButton(
              //       icon: Icon(Icons.clear, color: ColorManager.primary),
              //       onPressed: () {
              //         _searchController.clear();
              //         _searchCubit.clearSearch();
              //       },
              //     ),
              //   ),
              //   onFieldSubmitted: (query) {
              //     if (query.isNotEmpty) {
              //       _searchCubit.searchProducts(query);
              //     }
              //   },
              // ),
              // SizedBox(height: 16.h),
              // Search Results
              Expanded(
                child: BlocBuilder<SearchCubit, SearchState>(
                  builder: (context, state) {
                    if (state is SearchLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is SearchError) {
                      return Center(child: Text(state.error));
                    } else if (state is SearchSuccess) {
                      return _buildSearchResults(state.products);
                    } else if (state is RecommendationsLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is RecommendationsError) {
                      return Center(child: Text(state.error));
                    } else if (state is RecommendationsSuccess) {
                      return _buildRecommendations(state.products);
                    }
                    return _buildInitialView();
                  },
                ),
              ),
            ],
          ),
        ),
      
    );
  }

  Widget _buildInitialView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Recent Searches",
          style: getMediumStyle(
            color: ColorManager.textColor,
            fontSize: FontSize.s18,
          ),
        ),
        SizedBox(height: 8.h),
        // TODO: Add recent searches from local storage
        Expanded(
          child: Center(
            child: Text(
              "Search for products",
              style: getRegularStyle(
                color: ColorManager.grey,
                fontSize: FontSize.s16,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchResults(List<ProductEntity> products) {
    if (products.isEmpty) {
      return Center(
        child: Text(
          "No products found",
          style: getRegularStyle(
            color: ColorManager.grey,
            fontSize: FontSize.s16,
          ),
        ),
      );
    }

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 16.w,
        mainAxisSpacing: 16.h,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return CustomProductWidget(
          width: MediaQuery.of(context).size.width * 0.5,
          height: 300.h,
          product: products[index],
        );
      },
    );
  }

  Widget _buildRecommendations(List<ProductEntity> products) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Recommendations for you",
          style: getMediumStyle(
            color: ColorManager.textColor,
            fontSize: FontSize.s18,
          ),
        ),
        SizedBox(height: 16.h),
        Expanded(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              crossAxisSpacing: 16.w,
              mainAxisSpacing: 16.h,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              return CustomProductWidget(
                width: MediaQuery.of(context).size.width * 0.5,
                height: 300.h,
                product: products[index],
              );
            },
          ),
        ),
      ],
    );
  }
}
