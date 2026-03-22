import 'package:flutter/foundation.dart';
import '../errors/error_handler.dart';
import '../errors/exceptions.dart';

extension ErrorExtension on Object {
  AppException get toAppException {
    if (kDebugMode) {
      print(toString());
    }
    return ErrorHandler.handleError(this);
  }
}
