import 'package:multi_vendor/core/utils/app_strings.dart';

class AppErrorMessages {
  const AppErrorMessages._();
  static const String unexpectedError = AppStrings.unexpectedError;
  static const String networkError = AppStrings.networkError;
  static const String timeoutError = AppStrings.timeoutError;
  static const String unauthorized = AppStrings.unauthorizedError;
  static const String formatException = AppStrings.formatExceptionError;
}

class DatabaseErrorMessages {
  const DatabaseErrorMessages._();

  /// DATABASE
  static const String duplicate = AppStrings.duplicateError;
  static const String foreignKey = AppStrings.foreignKeyError;
  static const String notNullViolation = AppStrings.notNullViolationError;
  static const String checkViolation = AppStrings.checkViolationError;
  static const String insufficientPrivilege = AppStrings.insufficientPrivilegeError;
  static const String undefinedTable = AppStrings.undefinedTableError;
  static const String undefinedColumn = AppStrings.undefinedColumnError;
  static const String undefinedFunction = AppStrings.undefinedFunctionError;
  static const String invalidInputSyntax = AppStrings.invalidInputSyntaxError;
  static const String readOnlyTransaction = AppStrings.readOnlyTransactionError;
  static const String connectionFailure = AppStrings.connectionFailureError;
  static const String internalError = AppStrings.dbInternalError;

  /// POSTGREST
  static const String noRows = AppStrings.noRowsError;
  static const String parseError = AppStrings.parseError;
  static const String invalidBody = AppStrings.invalidBodyError;
  static const String invalidRange = AppStrings.invalidRangeError;
  static const String invalidPath = AppStrings.invalidPathError;
  static const String invalidMethod = AppStrings.invalidMethodError;

  static const String connectionError = AppStrings.connectionError;
  static const String timeout = AppStrings.dbTimeoutError;

  static const String staleRelation = AppStrings.staleRelationError;
  static const String ambiguousRelation = AppStrings.ambiguousRelationError;
  static const String staleFunction = AppStrings.staleFunctionError;
  static const String columnNotFound = AppStrings.columnNotFoundError;
  static const String tableNotFound = AppStrings.tableNotFoundError;

  static const String jwtInvalid = AppStrings.jwtInvalidError;
  static const String jwtMissing = AppStrings.jwtMissingError;
  static const String jwtClaimsInvalid = AppStrings.jwtClaimsInvalidError;
  static const String unknown = AppStrings.unknownError;
}

class AuthErrorMessages {
  const AuthErrorMessages._();

  static const String invalidEmail = AppStrings.invalidEmailError;
  static const String emailExists = AppStrings.emailExistsError;
  static const String emailNotConfirmed = AppStrings.emailNotConfirmedError;
  static const String emailProviderDisabled = AppStrings.emailProviderDisabledError;
  static const String emailConflictIdentityNotDeletable = AppStrings.emailConflictIdentityNotDeletableError;
  static const String invalidCredentials = AppStrings.invalidCredentialsError;
  static const String userNotFound = AppStrings.userNotFoundError;
  static const String userAlreadyExists = AppStrings.userAlreadyExistsError;
  static const String userBanned = AppStrings.userBannedError;
  static const String weakPassword = AppStrings.weakPasswordError;
  static const String samePassword = AppStrings.samePasswordError;
  static const String reauthenticationNeeded = AppStrings.reauthenticationNeededError;
  static const String reauthenticationNotValid = AppStrings.reauthenticationNotValidError;
  static const String otpExpired = AppStrings.otpExpiredError;
  static const String otpDisabled = AppStrings.otpDisabledError;
  static const String mfaVerificationFailed = AppStrings.mfaVerificationFailedError;
  static const String mfaChallengeExpired = AppStrings.mfaChallengeExpiredError;
  static const String tooManyEnrolledMfaFactors = AppStrings.tooManyEnrolledMfaFactorsError;
  static const String sessionExpired = AppStrings.sessionExpiredError;
  static const String refreshTokenNotFound = AppStrings.refreshTokenNotFoundError;
  static const String refreshTokenAlreadyUsed = AppStrings.refreshTokenAlreadyUsedError;
  static const String noAuthorization = AppStrings.unauthorizedError;
  static const String oauthProviderNotSupported = AppStrings.oauthProviderNotSupportedError;
  static const String providerDisabled = AppStrings.providerDisabledError;
  static const String providerEmailNeedsVerification = AppStrings.providerEmailNeedsVerificationError;
  static const String userSsoManaged = AppStrings.userSsoManagedError;
  static const String overRequestRateLimit = AppStrings.overRequestRateLimitError;
  static const String overEmailSendRateLimit = AppStrings.overEmailSendRateLimitError;
  static const String overSmsSendRateLimit = AppStrings.overSmsSendRateLimitError;
  static const String phoneExists = AppStrings.phoneExistsError;
  static const String phoneNotConfirmed = AppStrings.phoneNotConfirmedError;
  static const String phoneProviderDisabled = AppStrings.phoneProviderDisabledError;
  static const String smsSendFailed = AppStrings.smsSendFailedError;
  static const String flowStateExpired = AppStrings.flowStateExpiredError;
  static const String flowStateNotFound = AppStrings.flowStateNotFoundError;
  static const String unexpectedFailure = AppStrings.unexpectedError;
  static const String signInCanceled = AppStrings.signInCanceledError;
  static const String interrupted = AppStrings.interruptedError;
  static const String accountExistsWithDifferentCredential = AppStrings.accountExistsWithDifferentCredentialError;
  static const String userConfigError = AppStrings.userConfigError;
  static const String providerConfigurationError = AppStrings.providerConfigurationError;
  static const String uiUnavailable = AppStrings.uiUnavailableError;
  static const String unknown = AppStrings.unknownError;
}

class StorageErrorMessage {
  const StorageErrorMessage._();

  static const String noSuchBucket = AppStrings.noSuchBucketError;
  static const String noSuchKey = AppStrings.noSuchKeyError;
  static const String noSuchUpload = AppStrings.noSuchUploadError;
  static const String invalidJWT = AppStrings.storageInvalidJwtError;
  static const String invalidRequest = AppStrings.storageInvalidRequestError;
  static const String tenantNotFound = AppStrings.tenantNotFoundError;
  static const String entityTooLarge = AppStrings.entityTooLargeError;
  static const String internalError = AppStrings.storageInternalError;
  static const String resourceAlreadyExists = AppStrings.resourceAlreadyExistsError;
  static const String invalidBucketName = AppStrings.invalidBucketNameError;
  static const String invalidKey = AppStrings.invalidKeyError;
  static const String invalidRange = AppStrings.invalidRangeError;
  static const String invalidMimeType = AppStrings.invalidMimeTypeError;
  static const String invalidUploadId = AppStrings.invalidUploadIdError;
  static const String keyAlreadyExists = AppStrings.keyAlreadyExistsError;
  static const String bucketAlreadyExists = AppStrings.bucketAlreadyExistsError;
  static const String databaseTimeout = AppStrings.storageDatabaseError;
  static const String invalidSignature = AppStrings.invalidSignatureError;
  static const String signatureDoesNotMatch = AppStrings.signatureDoesNotMatchError;
  static const String accessDenied = AppStrings.accessDeniedError;
  static const String resourceLocked = AppStrings.resourceLockedError;
  static const String databaseError = AppStrings.storageDatabaseError;
  static const String missingContentLength = AppStrings.missingContentLengthError;
  static const String missingParameter = AppStrings.missingParameterError;
  static const String invalidUploadSignature = AppStrings.invalidUploadSignatureError;
  static const String lockTimeout = AppStrings.lockTimeoutError;
  static const String s3Error = AppStrings.s3Error;
  static const String s3InvalidAccessKeyId = AppStrings.s3InvalidAccessKeyIdError;
  static const String s3MaximumCredentialsLimit = AppStrings.s3MaximumCredentialsLimitError;
  static const String invalidChecksum = AppStrings.invalidChecksumError;
  static const String missingPart = AppStrings.missingPartError;
  static const String slowDown = AppStrings.slowDownError;
  static const String unknown = AppStrings.unexpectedError;
}

class ImagePickerErrorMessage {
  const ImagePickerErrorMessage._();
  static const String unknown = AppStrings.imagePickerUnknownError;
  static const String sizeExceeded = AppStrings.imageSizeExceededError;
  static const String errorCropping = AppStrings.errorCroppingError;
  static const String errorPick = AppStrings.errorPickError;
}