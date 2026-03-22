enum UserRole{
 customer,admin, vendor, superAdmin ;

 static const Map<String, UserRole> _map = {
   "customer" :customer,
   "admin" :admin,
   "vendor" :vendor,
   "super_admin" :superAdmin
 };
 static UserRole fromQuery(String role){
   return _map[role]!;
 }
 String toQuery(){
   return _map.entries.firstWhere((element) => element.value == this).key;
 }

}