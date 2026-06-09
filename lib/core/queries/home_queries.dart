class HomeQueries {
  const HomeQueries._();

  /// home
  static const String homeVendors = "id,name,image, is_verified, sponsored";
  static const String productByCategory =
      "id,name,price,price_before_discount,thumbnail,vendor(id,name,image),rating,tags, in_stock";
  static const String productByFilter =
      "id,name,price,price_before_discount,thumbnail,vendor(id,name,image, sponsored,color, is_verified),rating,tags, in_stock";
}