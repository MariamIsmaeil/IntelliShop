import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:ecommerce_app/core/resources/font_manager.dart';
import 'package:ecommerce_app/core/resources/styles_manager.dart';
import 'package:ecommerce_app/core/resources/values_manager.dart';
import 'package:ecommerce_app/features/products_screen/domain/entity/ProductEntity.dart';
import 'package:ecommerce_app/features/products_screen/presentation/widgets/custom_product_widget.dart';
import 'package:ecommerce_app/features/search/presentation/manger/search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchScreen extends StatefulWidget {
   final String? initialQuery;
  const SearchScreen({super.key,this.initialQuery});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
   late final SearchCubit _searchCubit;
  final TextEditingController _searchController = TextEditingController();

   @override
  void initState() {
    super.initState();
    _searchCubit = BlocProvider.of<SearchCubit>(context);

    if (widget.initialQuery != null && widget.initialQuery!.isNotEmpty) {
      _searchCubit.searchProducts(widget.initialQuery!);
      _searchController.text = widget.initialQuery!;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Search Products",
          style: TextStyle(color: ColorManager.primary),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            // Search Bar
            TextFormField(
              controller: _searchController,
              cursorColor: ColorManager.primary,
              style: getRegularStyle(
                color: ColorManager.primary,
                fontSize: FontSize.s16,
              ),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: AppMargin.m12.w,
                  vertical: AppMargin.m8.h,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10000),
                  borderSide: BorderSide(
                    width: AppSize.s1,
                    color: ColorManager.primary,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10000),
                  borderSide: BorderSide(
                    width: AppSize.s1,
                    color: ColorManager.primary,
                  ),
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: ColorManager.primary,
                ),
                hintText: "Search for products...",
                hintStyle: getRegularStyle(
                  color: ColorManager.primary,
                  fontSize: FontSize.s16,
                ),
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear, color: ColorManager.primary),
                  onPressed: () {
                    _searchController.clear();
                    _searchCubit.clearSearch();
                  },
                ),
              ),
              onFieldSubmitted: (query) {
                if (query.isNotEmpty) {
                  _searchCubit.searchProducts(query);
                }
              },
            ),
            SizedBox(height: 16.h),
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
                  }
                  return Center(
                    child: Text(
                      "Enter a search term to find products",
                      style: getRegularStyle(
                        color: ColorManager.grey,
                        fontSize: FontSize.s16,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
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
        childAspectRatio: 0.6,
        crossAxisSpacing: 16.w,
        mainAxisSpacing: 16.h,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return CustomProductWidget(
          width: 200,
          height: 350.h,
          product: products[index],
        );
      },
    );
  }
}