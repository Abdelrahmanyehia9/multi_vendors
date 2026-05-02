import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:multi_vendor/core/utils/mv_icons.dart';

enum PaymentOption {
 store, cod ;
 static Map<PaymentOption, String>_map = {
   store: 'store',
   cod: 'cod',
 } ;
 String get toDatabase => _map[this] ?? "cod";
 factory PaymentOption.fromDatabase(String option) {
   return _map.entries.firstWhereOrNull((e) => e.value == option)?.key ?? cod;
 }
 String get title => switch(this){
   store=>"Store Payment",
   cod=>"Cash on Delivery",
 };
 IconData get icon => switch(this){
   store=> MvIcons.store,
   cod=>   MvIcons.payments,
 };

}