import 'package:multi_vendor/core/errors/error_messages.dart';
import 'package:multi_vendor/core/errors/exceptions.dart';

class StorageErrorCode {
  const StorageErrorCode._();

  static const noSuchBucket = 'NoSuchBucket';
  static const noSuchKey = 'NoSuchKey';
  static const noSuchUpload = 'NoSuchUpload';
  static const invalidJWT = 'InvalidJWT';
  static const invalidRequest = 'InvalidRequest';
  static const tenantNotFound = 'TenantNotFound';
  static const entityTooLarge = 'EntityTooLarge';
  static const internalError = 'InternalError';
  static const resourceAlreadyExists = 'ResourceAlreadyExists';
  static const invalidBucketName = 'InvalidBucketName';
  static const invalidKey = 'InvalidKey';
  static const invalidRange = 'InvalidRange';
  static const invalidMimeType = 'InvalidMimeType';
  static const invalidUploadId = 'InvalidUploadId';
  static const keyAlreadyExists = 'KeyAlreadyExists';
  static const bucketAlreadyExists = 'BucketAlreadyExists';
  static const databaseTimeout = 'DatabaseTimeout';
  static const invalidSignature = 'InvalidSignature';
  static const signatureDoesNotMatch = 'SignatureDoesNotMatch';
  static const accessDenied = 'AccessDenied';

  static const resourceLocked = 'ResourceLocked';
  static const databaseError = 'DatabaseError';

  static const missingContentLength = 'MissingContentLength';
  static const missingParameter = 'MissingParameter';
  static const invalidUploadSignature = 'InvalidUploadSignature';

  static const lockTimeout = 'LockTimeout';

  static const s3Error = 'S3Error';
  static const s3InvalidAccessKeyId = 'S3InvalidAccessKeyId';
  static const s3MaximumCredentialsLimit = 'S3MaximumCredentialsLimit';

  static const invalidChecksum = 'InvalidChecksum';
  static const missingPart = 'MissingPart';
  static const slowDown = 'SlowDown';

  static const unknown = 'unknown';
}

class StorageErrorHandler {
  const StorageErrorHandler._();

  static final Map<String, String> _map = {
    StorageErrorCode.noSuchBucket: StorageErrorMessage.noSuchBucket,
    StorageErrorCode.noSuchKey: StorageErrorMessage.noSuchKey,
    StorageErrorCode.noSuchUpload: StorageErrorMessage.noSuchUpload,
    StorageErrorCode.invalidJWT: StorageErrorMessage.invalidJWT,
    StorageErrorCode.invalidRequest: StorageErrorMessage.invalidRequest,
    StorageErrorCode.tenantNotFound: StorageErrorMessage.tenantNotFound,
    StorageErrorCode.entityTooLarge: StorageErrorMessage.entityTooLarge,
    StorageErrorCode.internalError: StorageErrorMessage.internalError,
    StorageErrorCode.resourceAlreadyExists:
    StorageErrorMessage.resourceAlreadyExists,
    StorageErrorCode.invalidBucketName:
    StorageErrorMessage.invalidBucketName,
    StorageErrorCode.invalidKey: StorageErrorMessage.invalidKey,
    StorageErrorCode.invalidRange: StorageErrorMessage.invalidRange,
    StorageErrorCode.invalidMimeType:
    StorageErrorMessage.invalidMimeType,
    StorageErrorCode.invalidUploadId:
    StorageErrorMessage.invalidUploadId,
    StorageErrorCode.keyAlreadyExists:
    StorageErrorMessage.keyAlreadyExists,
    StorageErrorCode.bucketAlreadyExists:
    StorageErrorMessage.bucketAlreadyExists,
    StorageErrorCode.databaseTimeout:
    StorageErrorMessage.databaseTimeout,
    StorageErrorCode.invalidSignature:
    StorageErrorMessage.invalidSignature,
    StorageErrorCode.signatureDoesNotMatch:
    StorageErrorMessage.signatureDoesNotMatch,
    StorageErrorCode.accessDenied: StorageErrorMessage.accessDenied,
    StorageErrorCode.resourceLocked:
    StorageErrorMessage.resourceLocked,
    StorageErrorCode.databaseError: StorageErrorMessage.databaseError,
    StorageErrorCode.missingContentLength:
    StorageErrorMessage.missingContentLength,
    StorageErrorCode.missingParameter:
    StorageErrorMessage.missingParameter,
    StorageErrorCode.invalidUploadSignature:
    StorageErrorMessage.invalidUploadSignature,
    StorageErrorCode.lockTimeout: StorageErrorMessage.lockTimeout,
    StorageErrorCode.s3Error: StorageErrorMessage.s3Error,
    StorageErrorCode.s3InvalidAccessKeyId:
    StorageErrorMessage.s3InvalidAccessKeyId,
    StorageErrorCode.s3MaximumCredentialsLimit:
    StorageErrorMessage.s3MaximumCredentialsLimit,
    StorageErrorCode.invalidChecksum:
    StorageErrorMessage.invalidChecksum,
    StorageErrorCode.missingPart: StorageErrorMessage.missingPart,
    StorageErrorCode.slowDown: StorageErrorMessage.slowDown,
  };

  static AppException handle(String? code) {
    final c = code ?? StorageErrorCode.unknown;
    final message = _map[c] ?? StorageErrorMessage.unknown;
    return AppStorageException(code: c, message: message);
  }
}
