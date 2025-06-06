class Endpoint {
  // Auth Endpoints
  static const String signUpEndpoint = "/auth/register";
  static const String signInEndpoint = "/auth/login";
  static const String logoutEndpoint = "/auth/logout";
  // static const String forgotPasswordEndpoint = "/auth/forgot-password";
  // static const String verifyResetCodeEndpoint = "/auth/verify-reset-code";
  // static const String resetPasswordEndpoint = "/auth/reset-password";
  
  // Products Endpoints
  static const String productsEndpoint = "/products";
  static const String brandsEndpoint = "/brands";
   static String productByIdEndpoint(String id) => "/products/product/$id";
   static String productsByCategoryEndpoint(String categorySlug) => "/products/category/$categorySlug";
  static String productsBySubCategoryEndpoint(String categorySlug, String subCategorySlug) => 
       "/products/category/$categorySlug/$subCategorySlug";
  static String productsByBrandEndpoint(String brandSlug) => "/products/brand/$brandSlug";
  
  // Categories Endpoints
  static const String categoriesEndpoint = "/categories/get-categories";
  //static String categoryByIdEndpoint(String id) => "/categories/categories/$id";
  static String subCategoriesEndPoint(String categoryId) => "/categories/categories/$categoryId";
  static const String wishlistEndpoint = "/wishlist";
  static const String cartEndpoint = "/cart";

  

}