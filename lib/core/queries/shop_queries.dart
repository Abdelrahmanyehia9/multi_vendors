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



}