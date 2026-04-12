class ShopQueries {
 const ShopQueries._();

 static const String productItemDetails = """
  id, name, description, created_at,
  vendor:vendor_id(id, name, image),
  price, stock_availability,
  variants:product_variant(id, sku, price, stock, image_url, attributes),
  category:category_id(id, name),
  images, thumbnail, tags, rating
""";




}