class ShopQueries {
  const ShopQueries._();

  static const String productItemDetails = """
  id, name, description, created_at,
  vendor:vendor_id(id, name, image),
  price,price_before_discount ,in_stock,
  category:category_id(id, name),
  images, thumbnail, tags, rating
""";

  static const String orderDetails = '''
  *,
  payments(*),
  items:order_items(
    quantity,
    is_rated,
    order_item_id:id, 
    product(
      id,
      name,
      thumbnail,
      in_stock,
      price,
      price_before_discount,
      sale_interval
    )
  )
''';
  static const String orderHistory = ''' 
 created_at, id, payments(*), estimated_delivery,status,items:order_items(
     order_item_id:id, 
     quantity, 
 product(id, thumbnail,name, price)
 )
 ''';

  static const String orderTracking = ''' 
 created_at, id, status, captain:profiles(full_name, profile_pic,phone_number)
 ''';

  static const String vendorsByCategory = '''
 id, name, image, is_verified , delivery_option, rating,sponsored
''';
  static const String productRating = '''
 rating
''';

  static const String userReviews = '''
*,
user:public_profiles(id, full_name, profile_pic)
''';
}
