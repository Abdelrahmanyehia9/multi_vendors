class HomeQueries {
  const HomeQueries._();

  /// home
  static const String homeVendors = "id,name,image";
  static const String productByCategory =
      "id,name,price,thumbnail,vendor(id,name,image),rating,tags, in_stock";
  static const String productByFilter =
      "id,name,price,thumbnail,vendor(id,name,image),rating,tags, in_stock";
}