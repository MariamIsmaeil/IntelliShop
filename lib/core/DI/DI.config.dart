// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/auth/sign_in_screen/data/data_sources/SignDaoImpl/SignInDaoApiImpl.dart'
    as _i1035;
import '../../features/auth/sign_in_screen/data/data_sources/SignInDao.dart'
    as _i151;
import '../../features/auth/sign_in_screen/data/repositories/SignInRepoImpl.dart'
    as _i83;
import '../../features/auth/sign_in_screen/domain/repositories/SignInRepo.dart'
    as _i752;
import '../../features/auth/sign_in_screen/domain/use_cases/SignInUseCase.dart'
    as _i382;
import '../../features/auth/sign_in_screen/presentation/manager/sign_in_view_model_cubit.dart'
    as _i410;
import '../../features/auth/sign_up_screen/data/data_sources/SignUpDao.dart'
    as _i724;
import '../../features/auth/sign_up_screen/data/data_sources/SignUpDaoImpl/SignupApiImpl.dart'
    as _i904;
import '../../features/auth/sign_up_screen/data/repositories/SignUpRepoImpl.dart'
    as _i359;
import '../../features/auth/sign_up_screen/domain/repositories/SignUpRepo.dart'
    as _i446;
import '../../features/auth/sign_up_screen/domain/use_cases/SignUpUseCase.dart'
    as _i248;
import '../../features/auth/sign_up_screen/presentation/manager/signup_cubit.dart'
    as _i901;
import '../../features/cart/data/dao/CartDao.dart' as _i836;
import '../../features/cart/data/dao/daoImpl/CartDaoApiImpl.dart' as _i461;
import '../../features/cart/data/repo_impl/CartRepoImpl.dart' as _i496;
import '../../features/cart/domain/repo/CartRepo.dart' as _i163;
import '../../features/cart/domain/usecase/GetCartUseCase.dart' as _i830;
import '../../features/cart/presentation/manager/cart_cubit.dart' as _i680;
import '../../features/main_layout/categories/data/datasource/CategoriesDao.dart'
    as _i425;
import '../../features/main_layout/categories/data/datasource/datasourceimpl/CategoriesDaoApiImpl.dart'
    as _i806;
import '../../features/main_layout/categories/data/repositoryImpl/CategoriesRepoImpl.dart'
    as _i274;
import '../../features/main_layout/categories/domain/repository/CategoriesRepo.dart'
    as _i426;
import '../../features/main_layout/categories/domain/usecase/GetSubCategoriesUseCase.dart'
    as _i450;
import '../../features/main_layout/categories/presentation/manager/categories_cubit.dart'
    as _i384;
import '../../features/main_layout/favourite/data/dao/dao_impl/FavouriteDaoApiImpl.dart'
    as _i573;
import '../../features/main_layout/favourite/data/dao/FavouriteDao.dart'
    as _i991;
import '../../features/main_layout/favourite/data/repo_impl/FavouriteRepoImpl.dart'
    as _i510;
import '../../features/main_layout/favourite/domain/repo/FavouriteRepo.dart'
    as _i839;
import '../../features/main_layout/favourite/domain/usecase/GetFavouritesUseCase.dart'
    as _i186;
import '../../features/main_layout/favourite/presentation/viewmodel/favourite_cubit.dart'
    as _i400;
import '../../features/main_layout/home/data/data_sources/HomeDao.dart'
    as _i273;
import '../../features/main_layout/home/data/data_sources/HomeDaoImpl/HomeDaoApiImpl.dart'
    as _i644;
import '../../features/main_layout/home/data/repositories/HomeRepoImpl.dart'
    as _i253;
import '../../features/main_layout/home/domain/repositories/HomeRepo.dart'
    as _i587;
import '../../features/main_layout/home/domain/use_cases/GetBrandsUseCase.dart'
    as _i89;
import '../../features/main_layout/home/domain/use_cases/GetCategoriesUseCase.dart'
    as _i899;
import '../../features/main_layout/home/presentation/manager/home_cubit.dart'
    as _i404;
import '../../features/products_screen/data/datasource/ProductsDao.dart'
    as _i167;
import '../../features/products_screen/data/datasource/productsDaoImpl/ProductsDaoApiImpl.dart'
    as _i753;
import '../../features/products_screen/data/repositoryimpl/ProductsRepoImpl.dart'
    as _i732;
import '../../features/products_screen/domain/repository/ProductsRepo.dart'
    as _i892;
import '../../features/products_screen/domain/usecase/AddToCartUseCase.dart'
    as _i453;
import '../../features/products_screen/domain/usecase/AddToWishlistUseCase.dart'
    as _i1030;
import '../../features/products_screen/domain/usecase/delete_cart_use_case.dart'
    as _i551;
import '../../features/products_screen/domain/usecase/GetProductsOfCategoryUseCase.dart'
    as _i30;
import '../../features/products_screen/domain/usecase/remove_from_cart_use_case.dart'
    as _i232;
import '../../features/products_screen/presentation/manager/products_cubit.dart'
    as _i605;
import '../../features/search/data/data_source/search_dao.dart' as _i57;
import '../../features/search/data/data_source/SearchRemoteDataSource.dart'
    as _i744;
import '../../features/search/data/repo_impl/SearchRepositoryImpl.dart'
    as _i605;
import '../../features/search/domain/usecase/search_usecase.dart' as _i996;
import '../../features/search/presentation/manger/search_cubit.dart' as _i1019;
import '../network/api_manager.dart' as _i119;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i119.ApiManager>(() => _i119.ApiManager());
    gh.factory<_i836.CartDao>(
        () => _i461.CartDaoApiImpl(gh<_i119.ApiManager>()));
    gh.factory<_i425.CategoriesDao>(
        () => _i806.CategoriesDaoApiImpl(gh<_i119.ApiManager>()));
    gh.factory<_i151.SignInDao>(
        () => _i1035.SignInDaoApiImpl(gh<_i119.ApiManager>()));
    gh.factory<_i744.SearchRemoteDataSource>(
        () => _i57.SearchRemoteDataSourceImpl(gh<_i119.ApiManager>()));
    gh.factory<_i163.CartRepo>(() => _i496.CartRepoImpl(gh<_i836.CartDao>()));
    gh.factory<_i605.SearchRepository>(
        () => _i605.SearchRepositoryImpl(gh<_i744.SearchRemoteDataSource>()));
    gh.factory<_i426.CategoriesRepo>(
        () => _i274.CategoriesRepoImpl(gh<_i425.CategoriesDao>()));
    gh.factory<_i724.SignUpDao>(
        () => _i904.SignupApiImpl(gh<_i119.ApiManager>()));
    gh.factory<_i273.HomeDao>(
        () => _i644.HomeDaoApiImpl(gh<_i119.ApiManager>()));
    gh.factory<_i991.FavouriteDao>(
        () => _i573.FavouriteDaoApiImpl(gh<_i119.ApiManager>()));
    gh.factory<_i167.ProductsDao>(
        () => _i753.ProductsDaoApiImpl(gh<_i119.ApiManager>()));
    gh.factory<_i587.HomeRepo>(() => _i253.HomeRepoImpl(gh<_i273.HomeDao>()));
    gh.factory<_i830.GetCartUseCase>(
        () => _i830.GetCartUseCase(gh<_i163.CartRepo>()));
    gh.factory<_i453.AddToCartUseCase>(
        () => _i453.AddToCartUseCase(gh<_i163.CartRepo>()));
    gh.factory<_i551.DeleteCartUseCase>(
        () => _i551.DeleteCartUseCase(gh<_i163.CartRepo>()));
    gh.factory<_i232.RemoveFromCartUseCase>(
        () => _i232.RemoveFromCartUseCase(gh<_i163.CartRepo>()));
    gh.factory<_i680.CartCubit>(() => _i680.CartCubit(
          gh<_i830.GetCartUseCase>(),
          gh<_i453.AddToCartUseCase>(),
          gh<_i232.RemoveFromCartUseCase>(),
          gh<_i551.DeleteCartUseCase>(),
        ));
    gh.factory<_i446.SignUpRepo>(
        () => _i359.SignUpRepoImpl(gh<_i724.SignUpDao>()));
    gh.factory<_i752.SignInRepo>(
        () => _i83.SignInRepoImpl(gh<_i151.SignInDao>()));
    gh.factory<_i996.SearchProductsUseCase>(
        () => _i996.SearchProductsUseCase(gh<_i605.SearchRepository>()));
    gh.factory<_i996.GetRecommendationsUseCase>(
        () => _i996.GetRecommendationsUseCase(gh<_i605.SearchRepository>()));
    gh.factory<_i450.GetSubCategoriesUseCase>(
        () => _i450.GetSubCategoriesUseCase(gh<_i426.CategoriesRepo>()));
    gh.factory<_i839.FavouriteRepo>(
        () => _i510.FavouriteRepoImpl(gh<_i991.FavouriteDao>()));
    gh.factory<_i892.ProductsRepo>(
        () => _i732.ProductsRepoImpl(gh<_i167.ProductsDao>()));
    gh.factory<_i89.GetBrandsUseCase>(
        () => _i89.GetBrandsUseCase(gh<_i587.HomeRepo>()));
    gh.factory<_i899.GetCategoriesUseCase>(
        () => _i899.GetCategoriesUseCase(gh<_i587.HomeRepo>()));
    gh.factory<_i1019.SearchCubit>(() => _i1019.SearchCubit(
          gh<_i996.SearchProductsUseCase>(),
          gh<_i996.GetRecommendationsUseCase>(),
        ));
    gh.factory<_i186.GetFavouritesUseCase>(
        () => _i186.GetFavouritesUseCase(gh<_i839.FavouriteRepo>()));
    gh.factory<_i382.SignInUseCase>(
        () => _i382.SignInUseCase(gh<_i752.SignInRepo>()));
    gh.factory<_i400.FavouriteCubit>(
        () => _i400.FavouriteCubit(gh<_i186.GetFavouritesUseCase>()));
    gh.factory<_i248.SignUpUseCase>(
        () => _i248.SignUpUseCase(gh<_i446.SignUpRepo>()));
    gh.factory<_i410.SignInViewModelCubit>(
        () => _i410.SignInViewModelCubit(gh<_i382.SignInUseCase>()));
    gh.factory<_i404.HomeCubit>(() => _i404.HomeCubit(
          gh<_i899.GetCategoriesUseCase>(),
          gh<_i89.GetBrandsUseCase>(),
        ));
    gh.factory<_i1030.AddToWishlistUseCase>(
        () => _i1030.AddToWishlistUseCase(gh<_i892.ProductsRepo>()));
    gh.factory<_i1030.RemoveFromWishlistUseCase>(
        () => _i1030.RemoveFromWishlistUseCase(gh<_i892.ProductsRepo>()));
    gh.factory<_i30.GetProductsOfCategoryUseCase>(
        () => _i30.GetProductsOfCategoryUseCase(gh<_i892.ProductsRepo>()));
    gh.factory<_i384.CategoriesCubit>(() => _i384.CategoriesCubit(
          gh<_i899.GetCategoriesUseCase>(),
          gh<_i450.GetSubCategoriesUseCase>(),
        ));
    gh.factory<_i901.SignupCubit>(
        () => _i901.SignupCubit(gh<_i248.SignUpUseCase>()));
    gh.factory<_i605.ProductsCubit>(() => _i605.ProductsCubit(
          gh<_i453.AddToCartUseCase>(),
          gh<_i30.GetProductsOfCategoryUseCase>(),
          gh<_i1030.AddToWishlistUseCase>(),
          gh<_i1030.RemoveFromWishlistUseCase>(),
        ));
    return this;
  }
}
