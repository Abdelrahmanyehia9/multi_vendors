class AppErrorMessages {
  const AppErrorMessages._();
  static const unexpectedError = 'An unexpected error occurred, please try again';
  static const networkError = 'Internet connection error, check your network and try again';
  static const timeoutError = 'Request timed out, please try again';
  static const unauthorized = 'You are not authorized to perform this action';
  static const formatException = 'A data format error occurred';
}

class DatabaseErrorMessages {
  const DatabaseErrorMessages._();

  /// DATABASE
  static const duplicate = 'Data already exists';
  static const foreignKey = 'Cannot delete or add due to related data';
  static const notNullViolation = 'All required fields must be filled';
  static const checkViolation = 'The entered value is not allowed';
  static const insufficientPrivilege = 'You do not have permission to perform this action';
  static const undefinedTable = 'The requested data was not found';
  static const undefinedColumn = 'A data structure error occurred';
  static const undefinedFunction = 'Operation is not currently supported';
  static const invalidInputSyntax = 'The entered data is invalid';
  static const readOnlyTransaction = 'Modification is not allowed at this time';
  static const connectionFailure = 'Failed to connect to the database';
  static const internalError = 'An internal server error occurred';

  /// POSTGREST
  static const noRows = 'No data found';
  static const parseError = 'Request format error';
  static const invalidBody = 'The sent data is invalid';
  static const invalidRange = 'The requested range is invalid';
  static const invalidPath = 'The path is invalid';
  static const invalidMethod = 'This operation is not allowed';

  static const connectionError = 'Unable to connect to the server';
  static const timeout = 'Connection timed out';

  static const staleRelation = 'Data is out of sync, please try again';
  static const ambiguousRelation = 'The request is ambiguous';
  static const staleFunction = 'Function not found';
  static const columnNotFound = 'Column not found';
  static const tableNotFound = 'Table not found';

  static const jwtInvalid = 'Session is invalid';
  static const jwtMissing = 'You must log in first';
  static const jwtClaimsInvalid = 'Session has expired';

  static const unknown = 'An unexpected error occurred';
}

class AuthErrorMessages {
  const AuthErrorMessages._();

  static const invalidEmail = 'The email address is invalid';
  static const emailExists = 'This email is already in use';
  static const emailNotConfirmed = 'Please confirm your email before logging in';
  static const emailProviderDisabled = 'Email registration is currently unavailable';
  static const emailConflictIdentityNotDeletable = 'There is an email conflict and the identity cannot be deleted';
  static const invalidCredentials = 'Invalid login credentials';
  static const userNotFound = 'This user does not exist';
  static const userAlreadyExists = 'This user is already registered';
  static const userBanned = 'This account has been temporarily banned';
  static const weakPassword = 'The password is too weak';
  static const samePassword = 'The new password must be different from the current one';
  static const reauthenticationNeeded = 'You must log in again to perform this action';
  static const reauthenticationNotValid = 'Re-authentication credentials are invalid';

  static const otpExpired = 'The verification code has expired, please request a new one';
  static const otpDisabled = 'OTP login is not available for this number, try creating a new account';
  static const mfaVerificationFailed = 'Two-factor verification failed';
  static const mfaChallengeExpired = 'Two-factor verification expired, please try again';
  static const tooManyEnrolledMfaFactors = 'Too many verification methods enrolled, please remove one';

  static const sessionExpired = 'Session expired, please log in again';
  static const refreshTokenNotFound = 'Session has expired, please log in again';
  static const refreshTokenAlreadyUsed = 'Session was already used, please log in again';
  static const noAuthorization = 'You are not authorized to access this data';

  static const oauthProviderNotSupported = 'This login method is not supported';
  static const providerDisabled = 'This login method is currently unavailable';
  static const providerEmailNeedsVerification = 'Email must be verified first';
  static const userSsoManaged = 'This account is managed by an external login system and some data cannot be modified';

  static const overRequestRateLimit = 'Too many attempts, please try again later';
  static const overEmailSendRateLimit = 'Too many messages sent, please try again later';
  static const overSmsSendRateLimit = 'Too many verification messages sent, please wait a moment';

  static const phoneExists = 'This phone number is already in use';
  static const phoneNotConfirmed = 'Phone number is not activated';
  static const phoneProviderDisabled = 'Phone number registration is currently unavailable';
  static const smsSendFailed = 'Failed to send verification message, please try again';

  static const flowStateExpired = 'Registration process expired, please try again';
  static const flowStateNotFound = 'An error occurred in the registration process, please try again';

  static const unexpectedFailure = 'An unexpected error occurred, please try again';

  static const String signInCanceled = 'Sign in was canceled by the user.';
  static const String interrupted = 'Sign in was interrupted. Please try again.';
  static const String accountExistsWithDifferentCredential = 'This account exists with a different sign-in method. Please use the same method as before.';

  static const String userConfigError = 'There is an error in the login settings. Please try again later.';
  static const String providerConfigurationError = 'Login provider configuration error. Please try again later.';
  static const String uiUnavailable = 'The login interface is not available on this device.';

  static const String unknown = 'An unexpected error occurred during sign in. Please try again.';
}

class StorageErrorMessage {
  const StorageErrorMessage._();

  static const noSuchBucket = 'Bucket not found';
  static const noSuchKey = 'File not found';
  static const noSuchUpload = 'Upload operation not found';
  static const invalidJWT = 'Session is invalid';
  static const invalidRequest = 'The request is invalid';
  static const tenantNotFound = 'A storage configuration error occurred';
  static const entityTooLarge = 'File size is too large';
  static const internalError = 'An internal server error occurred';
  static const resourceAlreadyExists = 'File already exists';
  static const invalidBucketName = 'Bucket name is invalid';
  static const invalidKey = 'File name is invalid';
  static const invalidRange = 'The requested range is invalid';
  static const invalidMimeType = 'File type is not supported';
  static const invalidUploadId = 'Upload ID is invalid';
  static const keyAlreadyExists = 'File name is already in use';
  static const bucketAlreadyExists = 'Bucket already exists';
  static const databaseTimeout = 'Server timed out';
  static const invalidSignature = 'Invalid signature';
  static const signatureDoesNotMatch = 'Signature verification failed';
  static const accessDenied = 'You do not have access permission';
  static const resourceLocked = 'File is currently locked';
  static const databaseError = 'Database error';
  static const missingContentLength = 'File data is incomplete';
  static const missingParameter = 'Some data is missing';
  static const invalidUploadSignature = 'Upload signature is invalid';
  static const lockTimeout = 'Lock timed out';
  static const s3Error = 'Storage service error';
  static const s3InvalidAccessKeyId = 'Access key is incorrect';
  static const s3MaximumCredentialsLimit = 'Maximum number of keys reached';
  static const invalidChecksum = 'File is corrupted or incomplete';
  static const missingPart = 'A part of the file is missing';
  static const slowDown = 'Too many requests, please try again later';
  static const unknown = 'An unexpected error occurred';
}

class ImagePickerErrorMessage {
  const ImagePickerErrorMessage._();
  static const unknown = 'An unexpected error occurred';
  static const sizeExceeded = 'File size is too large';
  static const errorCropping = 'Failed to crop image';
  static const errorPick = 'Failed to pick image';
}