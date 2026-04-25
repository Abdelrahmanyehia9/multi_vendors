class ShopQueries {
 const ShopQueries._();

 static const String productItemDetails = """
  id, name, description, created_at,
  vendor:vendor_id(id, name, image),
  price, in_stock,
  category:category_id(id, name),
  images, thumbnail, tags, rating
""";


 static const String orderDetails = ''' 
 *, payments(*)
 ''' ;
 static const String orderHistory = ''' 
 created_at, id, payments(*), estimated_delivery,status
 ''' ;

 static const String orderTracking = ''' 
 created_at, id, status, captain:profiles(full_name, profile_pic,phone_number)
 ''' ;
static const String vendorsByCategory = '''
 id, name, image, is_verified , delivery_option, rating
''';


}