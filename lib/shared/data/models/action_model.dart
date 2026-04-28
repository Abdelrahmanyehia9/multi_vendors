import 'package:flutter/material.dart';

class ActionModel{
  final String text;
  final void Function(BuildContext context)? action;
 const  ActionModel({required this.text,  this.action});


}