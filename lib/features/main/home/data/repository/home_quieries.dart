class HomeQueries {
   HomeQueries();
   final String homeCategories = "id,name" ;
   final String homeVendors = "id,name,image" ;
   final String productByCategory = "id,name,price,thumbnail,vendor(name,image),rating";
   final String productByFilter = "id,name,price,thumbnail,vendor(name,image),rating";
}