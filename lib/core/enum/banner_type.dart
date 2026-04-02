import 'package:collection/collection.dart';

enum BannerType {
 v1 , v2 ;
 static const Map<BannerType,String> _map={
   v1:"v1",
   v2:"v2"
 };
 String toDataBase()=>_map[this] ??"v1";
 static BannerType fromDataBase(String value)=>_map.entries.firstWhereOrNull((element) => element.value == value)?.key??v1;

}