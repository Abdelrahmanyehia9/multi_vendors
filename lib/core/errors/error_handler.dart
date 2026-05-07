import 'dart:async';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:multi_vendor/core/errors/storage_error_handler.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:multi_vendor/core/errors/auth_error_handler.dart';
import 'package:multi_vendor/core/errors/database_error_handler.dart';
import 'package:multi_vendor/core/errors/error_messages.dart';
import 'package:multi_vendor/core/errors/exceptions.dart';

class ErrorHandler {
  const ErrorHandler._();
  static AppException handleError(Object error) {
    if (error is AuthException) {
      return AuthErrorHandler.handle(error);
    }
    // if (error is GoogleSignInException) {
    //   return GoogleAuthErrorHandler.handle(error);
    // }
    if(error is SocketException ){
      return AppSocketException(message: AppErrorMessages.networkError);
    }
    if(error is StorageException){
      return StorageErrorHandler.handle(error.statusCode);
    }
    if(error is PostgrestException){
      return DatabaseErrorHandler.handle(error.code);
    }
    if(error is TimeoutException){
      return AppTimeoutException(message: AppErrorMessages.timeoutError);
    }
    if (error is FormatException){
      return AppFormatException(message: AppErrorMessages.formatException);
    }
    if(error is ImagePickerError){
      return ImagePickerError(message: error.message,stackTrace: error.stackTrace) ;
    }
    return  UnExpectedException(
      message: AppErrorMessages.unexpectedError.tr(),
    );
  }
}
