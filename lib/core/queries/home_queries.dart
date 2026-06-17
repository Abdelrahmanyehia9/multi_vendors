class HomeQueries {
  const HomeQueries._();

  /// home
  static const String homeVendors = "id,name,image, is_verified, sponsored";
  static const String productByCategory =
      "id,name,price,price_before_discount,thumbnail,vendor(id,name,image),rating, sale_interval";
  static const String productByFilter =
      "id,name,price,price_before_discount,description,thumbnail,vendor(id,name,image, sponsored,color, is_verified, bio),rating,sale_interval";
}