import 'package:easy_localization/easy_localization.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';

class AppErrorMessages {
  const AppErrorMessages._();
  static final String unexpectedError = AppStrings.unexpectedError.tr();
  static final String networkError = AppStrings.networkError.tr();
  static final String timeoutError = AppStrings.timeoutError.tr();
  static final String unauthorized = AppStrings.unauthorizedError.tr();
  static final String formatException = AppStrings.formatExceptionError.tr();
}

class DatabaseErrorMessages {
  const DatabaseErrorMessages._();

  /// DATABASE
  static final String duplicate = AppStrings.duplicateError.tr();
  static final String foreignKey = AppStrings.foreignKeyError.tr();
  static final String notNullViolation = AppStrings.notNullViolationError.tr();
  static final String checkViolation = AppStrings.checkViolationError.tr();
  static final String insufficientPrivilege = AppStrings.insufficientPrivilegeError.tr();
  static final String undefinedTable = AppStrings.undefinedTableError.tr();
  static final String undefinedColumn = AppStrings.undefinedColumnError.tr();
    static final String undefinedFunction = AppStrings.undefinedFunctionError.tr() ;
  static final String invalidInputSyntax = AppStrings.invalidInputSyntaxError.tr();
  static final String readOnlyTransaction = AppStrings.readOnlyTransactionError.tr();
  static final String connectionFailure = AppStrings.connectionFailureError.tr();
  static final String internalError = AppStrings.dbInternalError.tr();

  /// POSTGREST
  static final String noRows = AppStrings.noRowsError.tr();
  static final String parseError = AppStrings.parseError.tr() ;
  static final String invalidBody = AppStrings.invalidBodyError.tr();
  static final String invalidRange = AppStrings.invalidRangeError.tr();
  static final String invalidPath = AppStrings.invalidPathError.tr();
  static final String invalidMethod = AppStrings.invalidMethodError.tr();

  static final String connectionError = AppStrings.connectionError.tr();
  static final String timeout = AppStrings.dbTimeoutError.tr();

  static final String staleRelation = AppStrings.staleRelationError.tr();
  static final String ambiguousRelation = AppStrings.ambiguousRelationError.tr();
  static final String staleFunction = AppStrings.staleFunctionError.tr();
  static final String columnNotFound = AppStrings.columnNotFoundError.tr();
  static final String tableNotFound = AppStrings.tableNotFoundError.tr();

  static final String jwtInvalid = AppStrings.jwtInvalidError.tr();
  static final String jwtMissing = AppStrings.jwtMissingError.tr();
  static final String jwtClaimsInvalid = AppStrings.jwtClaimsInvalidError.tr();
  static final String unknown = AppStrings.unknownError.tr();
}

class AuthErrorMessages {
  const AuthErrorMessages._();

  static final String invalidEmail = AppStrings.invalidEmailError.tr();
  static final String emailExists = AppStrings.emailExistsError.tr();
  static final String emailNotConfirmed = AppStrings.emailNotConfirmedError.tr();
  static final String emailProviderDisabled = AppStrings.emailProviderDisabledError.tr();
  static final String emailConflictIdentityNotDeletable = AppStrings.emailConflictIdentityNotDeletableError.tr();
  static final String invalidCredentials = AppStrings.invalidCredentialsError.tr();
  static final String userNotFound = AppStrings.userNotFoundError.tr();
  static final String userAlreadyExists = AppStrings.userAlreadyExistsError.tr();
  static final String userBanned = AppStrings.userBannedError.tr();
  static final String weakPassword = AppStrings.weakPasswordError.tr();
  static final String samePassword = AppStrings.samePasswordError.tr();
  static final String reauthenticationNeeded = AppStrings.reauthenticationNeededError.tr();
  static final String reauthenticationNotValid = AppStrings.reauthenticationNotValidError.tr();
  static final String otpExpired = AppStrings.otpExpiredError.tr();
  static final String otpDisabled = AppStrings.otpDisabledError.tr();
  static final String mfaVerificationFailed = AppStrings.mfaVerificationFailedError.tr();
  static final String mfaChallengeExpired = AppStrings.mfaChallengeExpiredError.tr();
  static final String tooManyEnrolledMfaFactors = AppStrings.tooManyEnrolledMfaFactorsError.tr();
  static final String sessionExpired = AppStrings.sessionExpiredError.tr();
  static final String refreshTokenNotFound = AppStrings.refreshTokenNotFoundError.tr();
  static final String refreshTokenAlreadyUsed = AppStrings.refreshTokenAlreadyUsedError.tr();
  static final String noAuthorization =   AppStrings.unauthorizedError.tr();
  static final String oauthProviderNotSupported = AppStrings.oauthProviderNotSupportedError.tr();
  static final String providerDisabled = AppStrings.providerDisabledError.tr();
  static final String providerEmailNeedsVerification = AppStrings.providerEmailNeedsVerificationError.tr();
  static final String userSsoManaged = AppStrings.userSsoManagedError.tr();
  static final String overRequestRateLimit = AppStrings.overRequestRateLimitError.tr();
  static final String overEmailSendRateLimit =  AppStrings.overEmailSendRateLimitError.tr();
  static final String overSmsSendRateLimit = AppStrings.overSmsSendRateLimitError.tr();
  static final String phoneExists = AppStrings.phoneExistsError.tr();
  static final String phoneNotConfirmed = AppStrings.phoneNotConfirmedError.tr();
  static final String phoneProviderDisabled = AppStrings.phoneProviderDisabledError.tr();
  static final String smsSendFailed = AppStrings.smsSendFailedError.tr();
  static final String flowStateExpired = AppStrings.flowStateExpiredError.tr();
  static final String flowStateNotFound = AppStrings.flowStateNotFoundError.tr();
  static final String unexpectedFailure = AppStrings.unexpectedError.tr();
  static final String signInCanceled = AppStrings.signInCanceledError.tr();
  static final String interrupted = AppStrings.interruptedError.tr();
  static final String accountExistsWithDifferentCredential = AppStrings.accountExistsWithDifferentCredentialError.tr();
  static final String userConfigError = AppStrings.userConfigError.tr();
  static final String providerConfigurationError = AppStrings.providerConfigurationError.tr();
  static final String uiUnavailable = AppStrings.uiUnavailableError.tr();
  static final String unknown = AppStrings.unknownError.tr();
}

class StorageErrorMessage {
  const StorageErrorMessage._();

  static final String noSuchBucket = AppStrings.noSuchBucketError.tr();
  static final String noSuchKey = AppStrings.noSuchKeyError.tr();
  static final String noSuchUpload = AppStrings.noSuchUploadError.tr();
  static final String invalidJWT = AppStrings.storageInvalidJwtError.tr();
  static final String invalidRequest = AppStrings.storageInvalidRequestError.tr();
  static final String tenantNotFound = AppStrings.tenantNotFoundError.tr();
  static final String entityTooLarge = AppStrings.entityTooLargeError.tr();
  static final String internalError = AppStrings.storageInternalError.tr();
  static final String resourceAlreadyExists = AppStrings.resourceAlreadyExistsError.tr();
  static final String invalidBucketName = AppStrings.invalidBucketNameError.tr();
  static final String invalidKey =  AppStrings.invalidKeyError.tr();
  static final String invalidRange = AppStrings.invalidRangeError.tr();
  static final String invalidMimeType = AppStrings.invalidMimeTypeError.tr();
  static final String invalidUploadId = AppStrings.invalidUploadIdError.tr();
  static final String keyAlreadyExists = AppStrings.keyAlreadyExistsError.tr();
  static final String bucketAlreadyExists = AppStrings.bucketAlreadyExistsError.tr();
  static final String databaseTimeout = AppStrings.storageDatabaseError.tr();
  static final String invalidSignature = AppStrings.invalidSignatureError.tr();
  static final String signatureDoesNotMatch = AppStrings.signatureDoesNotMatchError.tr();
  static final String accessDenied = AppStrings.accessDeniedError.tr();
  static final String resourceLocked = AppStrings.resourceLockedError.tr();
  static final String databaseError = AppStrings.storageDatabaseError.tr();
  static final String missingContentLength = AppStrings.missingContentLengthError.tr();
  static final String missingParameter = AppStrings.missingParameterError.tr();
  static final String invalidUploadSignature = AppStrings.invalidUploadSignatureError.tr();
  static final String lockTimeout = AppStrings.lockTimeoutError.tr();
  static final String s3Error = AppStrings.s3Error.tr();
  static final String s3InvalidAccessKeyId =  AppStrings.s3InvalidAccessKeyIdError.tr()  ;
  static final String s3MaximumCredentialsLimit = AppStrings.s3MaximumCredentialsLimitError.tr();
  static final String invalidChecksum = AppStrings.invalidChecksumError.tr();
  static final String missingPart = AppStrings.missingPartError.tr();
  static final String slowDown = AppStrings.slowDownError.tr();
  static final String unknown = AppStrings.unexpectedError.tr();
}

class ImagePickerErrorMessage {
  const ImagePickerErrorMessage._();
  static final String unknown = AppStrings.imagePickerUnknownError.tr();
  static final String sizeExceeded = AppStrings.imageSizeExceededError.tr();
  static final String errorCropping = AppStrings.errorCroppingError.tr();
  static final String errorPick = AppStrings.errorPickError.tr();
}