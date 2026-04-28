import 'package:flutter/foundation.dart';
import 'package:multi_vendor/core/errors/error_handler.dart';
import 'package:multi_vendor/core/errors/exceptions.dart';

extension ErrorExtension on Object {
  AppException get toAppException {
    if (kDebugMode) {
      print(toString());
    }
    return ErrorHandler.handleError(this);
  }
}
