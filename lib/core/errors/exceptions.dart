import 'package:multi_vendor/core/errors/error_messages.dart';

abstract class AppException {
  final String message;
  final String? code;
  final String? stackTrace;

  const AppException({required this.message, this.code, this.stackTrace});
}

class AuthenticateException extends AppException {
  const AuthenticateException({
    required super.message,
    super.code,
    super.stackTrace,
  });
}

class DatabaseException extends AppException{
  DatabaseException({required super.message, super.code});
}
class AppSocketException extends AppException{
  AppSocketException({required super.message});
}
class UnExpectedException extends AppException {
  const UnExpectedException({
    super.message = AppErrorMessages.unexpectedError,
    super.code,
    super.stackTrace,
  });
}
class AppStorageException extends AppException{
  AppStorageException({required super.message ,super.code});
}
class AppNetworkException extends AppException{
  AppNetworkException({required super.message});
}
class AppTimeoutException extends AppException{
  AppTimeoutException({required super.message});
}
class AppFormatException extends AppException{
  AppFormatException({required super.message});
}
