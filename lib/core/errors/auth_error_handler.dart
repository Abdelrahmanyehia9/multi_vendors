import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:multi_vendor/core/errors/error_messages.dart';
import 'package:multi_vendor/core/errors/exceptions.dart';

///auth
class AuthErrorCodes {
  const AuthErrorCodes._();

  static const invalidEmail = 'invalid_email';
  static const emailExists = 'email_exists';
  static const emailNotConfirmed = 'email_not_confirmed';
  static const emailProviderDisabled = 'email_provider_disabled';
  static const emailConflictIdentityNotDeletable =
      'email_conflict_identity_not_deletable';

  static const invalidCredentials = 'invalid_credentials';
  static const userNotFound = 'user_not_found';
  static const userAlreadyExists = 'user_already_exists';
  static const userBanned = 'user_banned';

  static const weakPassword = 'weak_password';
  static const samePassword = 'same_password';
  static const reauthenticationNeeded = 'reauthentication_needed';
  static const reauthenticationNotValid = 'reauthentication_not_valid';

  static const otpExpired = 'otp_expired';
  static const otpDisabled = 'otp_disabled';
  static const mfaVerificationFailed = 'mfa_verification_failed';
  static const mfaChallengeExpired = 'mfa_challenge_expired';
  static const tooManyEnrolledMfaFactors = 'too_many_enrolled_mfa_factors';
  static const sessionExpired = 'session_expired';
  static const refreshTokenNotFound = 'refresh_token_not_found';
  static const refreshTokenAlreadyUsed = 'refresh_token_already_used';
  static const noAuthorization = 'no_authorization';
  static const oauthProviderNotSupported = 'oauth_provider_not_supported';
  static const providerDisabled = 'provider_disabled';
  static const providerEmailNeedsVerification =
      'provider_email_needs_verification';
  static const userSsoManaged = 'user_sso_managed';

  static const overRequestRateLimit = 'over_request_rate_limit';
  static const overEmailSendRateLimit = 'over_email_send_rate_limit';
  static const overSmsSendRateLimit = 'over_sms_send_rate_limit';

  static const phoneExists = 'phone_exists';
  static const phoneNotConfirmed = 'phone_not_confirmed';
  static const phoneProviderDisabled = 'phone_provider_disabled';
  static const smsSendFailed = 'sms_send_failed';

  static const flowStateExpired = 'flow_state_expired';
  static const flowStateNotFound = 'flow_state_not_found';
  static const unexpectedFailure = 'unexpected_failure';
}

class AuthErrorHandler {
  const AuthErrorHandler._();
  static final Map<String, String> _errorMapping = {
    AuthErrorCodes.invalidEmail: AuthErrorMessages.invalidEmail,
    AuthErrorCodes.emailExists: AuthErrorMessages.emailExists,
    AuthErrorCodes.emailNotConfirmed: AuthErrorMessages.emailNotConfirmed,
    AuthErrorCodes.emailProviderDisabled:
        AuthErrorMessages.emailProviderDisabled,
    AuthErrorCodes.emailConflictIdentityNotDeletable:
        AuthErrorMessages.emailConflictIdentityNotDeletable,
    AuthErrorCodes.invalidCredentials: AuthErrorMessages.invalidCredentials,
    AuthErrorCodes.userNotFound: AuthErrorMessages.userNotFound,
    AuthErrorCodes.userAlreadyExists: AuthErrorMessages.userAlreadyExists,
    AuthErrorCodes.userBanned: AuthErrorMessages.userBanned,
    AuthErrorCodes.weakPassword: AuthErrorMessages.weakPassword,
    AuthErrorCodes.samePassword: AuthErrorMessages.samePassword,
    AuthErrorCodes.reauthenticationNeeded:
        AuthErrorMessages.reauthenticationNeeded,
    AuthErrorCodes.reauthenticationNotValid:
        AuthErrorMessages.reauthenticationNotValid,
    AuthErrorCodes.otpExpired: AuthErrorMessages.otpExpired,
    AuthErrorCodes.otpDisabled: AuthErrorMessages.otpDisabled,
    AuthErrorCodes.mfaVerificationFailed:
        AuthErrorMessages.mfaVerificationFailed,
    AuthErrorCodes.mfaChallengeExpired: AuthErrorMessages.mfaChallengeExpired,
    AuthErrorCodes.tooManyEnrolledMfaFactors:
        AuthErrorMessages.tooManyEnrolledMfaFactors,
    AuthErrorCodes.sessionExpired: AuthErrorMessages.sessionExpired,
    AuthErrorCodes.refreshTokenNotFound: AuthErrorMessages.refreshTokenNotFound,
    AuthErrorCodes.refreshTokenAlreadyUsed:
        AuthErrorMessages.refreshTokenAlreadyUsed,
    AuthErrorCodes.noAuthorization: AuthErrorMessages.noAuthorization,
    AuthErrorCodes.oauthProviderNotSupported:
        AuthErrorMessages.oauthProviderNotSupported,
    AuthErrorCodes.providerDisabled: AuthErrorMessages.providerDisabled,
    AuthErrorCodes.providerEmailNeedsVerification:
        AuthErrorMessages.providerEmailNeedsVerification,
    AuthErrorCodes.userSsoManaged: AuthErrorMessages.userSsoManaged,
    AuthErrorCodes.overRequestRateLimit: AuthErrorMessages.overRequestRateLimit,
    AuthErrorCodes.overEmailSendRateLimit:
        AuthErrorMessages.overEmailSendRateLimit,
    AuthErrorCodes.overSmsSendRateLimit: AuthErrorMessages.overSmsSendRateLimit,
    AuthErrorCodes.phoneExists: AuthErrorMessages.phoneExists,
    AuthErrorCodes.phoneNotConfirmed: AuthErrorMessages.phoneNotConfirmed,
    AuthErrorCodes.phoneProviderDisabled:
        AuthErrorMessages.phoneProviderDisabled,
    AuthErrorCodes.smsSendFailed: AuthErrorMessages.smsSendFailed,
    AuthErrorCodes.flowStateExpired: AuthErrorMessages.flowStateExpired,
    AuthErrorCodes.flowStateNotFound: AuthErrorMessages.flowStateNotFound,
    AuthErrorCodes.unexpectedFailure: AuthErrorMessages.unexpectedFailure,
  };
  static AppException handle(AuthException exception) {
    final code = exception.code ?? AuthErrorCodes.unexpectedFailure;
    final message = _errorMapping[code] ?? AuthErrorMessages.unexpectedFailure;
    return AuthenticateException(code: code, message: message);
  }
}

// /// google
// class GoogleAuthErrorCodes {
//   const GoogleAuthErrorCodes._();
//
//   static const signInCanceled = GoogleSignInExceptionCode.canceled;
//   static const interrupted = GoogleSignInExceptionCode.interrupted;
//   static const accountExistsWithDifferentCredential =
//       GoogleSignInExceptionCode.userMismatch;
//   static const userConfigError =
//       GoogleSignInExceptionCode.clientConfigurationError;
//   static const providerConfigurationError =
//       GoogleSignInExceptionCode.providerConfigurationError;
//   static const uiUnavailable = GoogleSignInExceptionCode.uiUnavailable;
//   static const unknown = GoogleSignInExceptionCode.unknownError;
// }
//
// class GoogleAuthErrorHandler {
//   const GoogleAuthErrorHandler._();
//
//   static final Map<GoogleSignInExceptionCode, String> _errorMapping = {
//     GoogleAuthErrorCodes.signInCanceled: AuthErrorMessages.signInCanceled,
//     GoogleAuthErrorCodes.interrupted: AuthErrorMessages.interrupted,
//     GoogleAuthErrorCodes.accountExistsWithDifferentCredential:
//         AuthErrorMessages.userAlreadyExists,
//     GoogleAuthErrorCodes.userConfigError: AuthErrorMessages.userConfigError,
//     GoogleAuthErrorCodes.providerConfigurationError:
//         AuthErrorMessages.providerConfigurationError,
//     GoogleAuthErrorCodes.uiUnavailable: AuthErrorMessages.uiUnavailable,
//     GoogleAuthErrorCodes.unknown: AuthErrorMessages.unknown,
//   };
//
//   static AppException handle(GoogleSignInException exception) {
//     final code = exception.code;
//     final message = _errorMapping[code] ?? 'Unexpected error occurred.';
//     return AuthenticateException(code: code.toString(), message: message);
//   }
// }
