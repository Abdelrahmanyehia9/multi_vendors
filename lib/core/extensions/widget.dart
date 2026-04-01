import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension PaddingExt on Widget {
  Widget paddingHr([double padding = 16]) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding.w),
      child: this,
    );
  }
  Widget paddingVr([double padding = 16]) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: padding.h),
      child: this,
    );
  }
  Widget paddingAll([double padding = 16]) {
    return Padding(padding: EdgeInsets.all(padding.sp), child: this);
  }
  Widget customPadding({
    double top = 0,
    double left = 0,
    double right = 0,
    double bottom = 0,
  }) {
    return Padding(
      padding: EdgeInsets.fromLTRB(left, top, right, bottom),
      child: this,
    );
  }

  Widget get  appPaddingHr => paddingHr() ;
  Widget get  appPaddingVr => paddingVr() ;
  Widget get  appPaddingAll => paddingAll() ;

}

extension TextControllerEXT on TextEditingController {
  String? get textOrNull => text.trim().isEmpty ? null : text.trim();

}