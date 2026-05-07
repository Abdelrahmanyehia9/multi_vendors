class AppStrings {
  const AppStrings._();

  // ─── Orders ───────────────────────────────────────────────────────────────
  static const String orderPending = 'order_pending';
  static const String orderCancelled = 'order_cancelled';
  static const String orderDelivered = 'order_delivered';
  static const String orderConfirmed = 'order_confirmed';
  static const String orderProcessing = 'order_processing';
  static const String orderShipped = 'order_shipped';
  static const String orderConfirmedDescription = 'order_confirmed_description';
  static const String orderProcessingDescription = 'order_processing_description';
  static const String orderShippedDescription = 'order_shipped_description';
  static const String orderDeliveredDescription = 'order_delivered_description';

  // ─── Payment ──────────────────────────────────────────────────────────────
  static const String storePayment = 'store_payment';
  static const String cashOnDelivery = 'cash_on_delivery';

  // ─── Product ──────────────────────────────────────────────────────────────
  static const String bestSelling = 'best_selling';
  static const String featured = 'featured';
  static const String summerOffer = 'summer_offer';
  static const String newArrivals = 'new_arrivals';
  static const String healthyChoice = 'healthy_choice';
  static const String inStock = 'in_stock';
  static const String outOfStock = 'out_of_stock';
  static const String onBackOrder = 'on_back_order';

  // ─── App errors ───────────────────────────────────────────────────────────
  static const String unexpectedError = 'unexpected_error';
  static const String networkError = 'network_error';
  static const String timeoutError = 'timeout_error';
  static const String unauthorizedError = 'unauthorized_error';
  static const String formatExceptionError = 'format_exception_error';

  // ─── Database errors ──────────────────────────────────────────────────────
  static const String duplicateError = 'duplicate_error';
  static const String foreignKeyError = 'foreign_key_error';
  static const String notNullViolationError = 'not_null_violation_error';
  static const String checkViolationError = 'check_violation_error';
  static const String insufficientPrivilegeError = 'insufficient_privilege_error';
  static const String undefinedTableError = 'undefined_table_error';
  static const String undefinedColumnError = 'undefined_column_error';
  static const String undefinedFunctionError = 'undefined_function_error';
  static const String invalidInputSyntaxError = 'invalid_input_syntax_error';
  static const String readOnlyTransactionError = 'read_only_transaction_error';
  static const String connectionFailureError = 'connection_failure_error';
  static const String dbInternalError = 'db_internal_error';

  // ─── PostgREST errors ─────────────────────────────────────────────────────
  static const String noRowsError = 'no_rows_error';
  static const String parseError = 'parse_error';
  static const String invalidBodyError = 'invalid_body_error';
  static const String invalidRangeError = 'invalid_range_error';
  static const String invalidPathError = 'invalid_path_error';
  static const String invalidMethodError = 'invalid_method_error';
  static const String connectionError = 'connection_error';
  static const String dbTimeoutError = 'db_timeout_error';
  static const String staleRelationError = 'stale_relation_error';
  static const String ambiguousRelationError = 'ambiguous_relation_error';
  static const String staleFunctionError = 'stale_function_error';
  static const String columnNotFoundError = 'column_not_found_error';
  static const String tableNotFoundError = 'table_not_found_error';
  static const String jwtInvalidError = 'jwt_invalid_error';
  static const String jwtMissingError = 'jwt_missing_error';
  static const String jwtClaimsInvalidError = 'jwt_claims_invalid_error';
  static const String unknownError = 'unknown_error';

  // ─── Auth errors ──────────────────────────────────────────────────────────
  static const String invalidEmailError = 'invalid_email_error';
  static const String emailExistsError = 'email_exists_error';
  static const String emailNotConfirmedError = 'email_not_confirmed_error';
  static const String emailProviderDisabledError = 'email_provider_disabled_error';
  static const String emailConflictIdentityNotDeletableError = 'email_conflict_identity_not_deletable_error';
  static const String invalidCredentialsError = 'invalid_credentials_error';
  static const String userNotFoundError = 'user_not_found_error';
  static const String userAlreadyExistsError = 'user_already_exists_error';
  static const String userBannedError = 'user_banned_error';
  static const String weakPasswordError = 'weak_password_error';
  static const String samePasswordError = 'same_password_error';
  static const String reauthenticationNeededError = 'reauthentication_needed_error';
  static const String reauthenticationNotValidError = 'reauthentication_not_valid_error';
  static const String otpExpiredError = 'otp_expired_error';
  static const String otpDisabledError = 'otp_disabled_error';
  static const String mfaVerificationFailedError = 'mfa_verification_failed_error';
  static const String mfaChallengeExpiredError = 'mfa_challenge_expired_error';
  static const String tooManyEnrolledMfaFactorsError = 'too_many_enrolled_mfa_factors_error';
  static const String sessionExpiredError = 'session_expired_error';
  static const String refreshTokenNotFoundError = 'refresh_token_not_found_error';
  static const String refreshTokenAlreadyUsedError = 'refresh_token_already_used_error';
  static const String noAuthorizationError = 'no_authorization_error';
  static const String oauthProviderNotSupportedError = 'oauth_provider_not_supported_error';
  static const String providerDisabledError = 'provider_disabled_error';
  static const String providerEmailNeedsVerificationError = 'provider_email_needs_verification_error';
  static const String userSsoManagedError = 'user_sso_managed_error';
  static const String overRequestRateLimitError = 'over_request_rate_limit_error';
  static const String overEmailSendRateLimitError = 'over_email_send_rate_limit_error';
  static const String overSmsSendRateLimitError = 'over_sms_send_rate_limit_error';
  static const String phoneExistsError = 'phone_exists_error';
  static const String phoneNotConfirmedError = 'phone_not_confirmed_error';
  static const String phoneProviderDisabledError = 'phone_provider_disabled_error';
  static const String smsSendFailedError = 'sms_send_failed_error';
  static const String flowStateExpiredError = 'flow_state_expired_error';
  static const String flowStateNotFoundError = 'flow_state_not_found_error';
  static const String unexpectedFailureError = 'unexpected_failure_error';
  static const String signInCanceledError = 'sign_in_canceled_error';
  static const String interruptedError = 'interrupted_error';
  static const String accountExistsWithDifferentCredentialError = 'account_exists_with_different_credential_error';
  static const String userConfigError = 'user_config_error';
  static const String providerConfigurationError = 'provider_configuration_error';
  static const String uiUnavailableError = 'ui_unavailable_error';
  static const String authUnknownError = 'auth_unknown_error';

  // ─── Storage errors ───────────────────────────────────────────────────────
  static const String noSuchBucketError = 'no_such_bucket_error';
  static const String noSuchKeyError = 'no_such_key_error';
  static const String noSuchUploadError = 'no_such_upload_error';
  static const String storageInvalidJwtError = 'storage_invalid_jwt_error';
  static const String storageInvalidRequestError = 'storage_invalid_request_error';
  static const String tenantNotFoundError = 'tenant_not_found_error';
  static const String entityTooLargeError = 'entity_too_large_error';
  static const String storageInternalError = 'storage_internal_error';
  static const String resourceAlreadyExistsError = 'resource_already_exists_error';
  static const String invalidBucketNameError = 'invalid_bucket_name_error';
  static const String invalidKeyError = 'invalid_key_error';
  static const String storageInvalidRangeError = 'storage_invalid_range_error';
  static const String invalidMimeTypeError = 'invalid_mime_type_error';
  static const String invalidUploadIdError = 'invalid_upload_id_error';
  static const String keyAlreadyExistsError = 'key_already_exists_error';
  static const String bucketAlreadyExistsError = 'bucket_already_exists_error';
  static const String storageDatabaseTimeoutError = 'storage_database_timeout_error';
  static const String invalidSignatureError = 'invalid_signature_error';
  static const String signatureDoesNotMatchError = 'signature_does_not_match_error';
  static const String accessDeniedError = 'access_denied_error';
  static const String resourceLockedError = 'resource_locked_error';
  static const String storageDatabaseError = 'storage_database_error';
  static const String missingContentLengthError = 'missing_content_length_error';
  static const String missingParameterError = 'missing_parameter_error';
  static const String invalidUploadSignatureError = 'invalid_upload_signature_error';
  static const String lockTimeoutError = 'lock_timeout_error';
  static const String s3Error = 's3_error';
  static const String s3InvalidAccessKeyIdError = 's3_invalid_access_key_id_error';
  static const String s3MaximumCredentialsLimitError = 's3_maximum_credentials_limit_error';
  static const String invalidChecksumError = 'invalid_checksum_error';
  static const String missingPartError = 'missing_part_error';
  static const String slowDownError = 'slow_down_error';
  static const String storageUnknownError = 'storage_unknown_error';

  // ─── Image picker errors ──────────────────────────────────────────────────
  static const String imagePickerUnknownError = 'image_picker_unknown_error';
  static const String imageSizeExceededError = 'image_size_exceeded_error';
  static const String errorCroppingError = 'error_cropping_error';
  static const String errorPickError = 'error_pick_error';


  static const String cannotBeEmpty = "cannot_be_empty" ;
  static const String thisField = "this_field" ;
  static const String password = "password" ;
  static const String emailAddress = "email_address" ;
  static const String confirmPassword = "confirm_password" ;

  static const String justNow   = 'just_now';
  static const String yesterday = 'yesterday';
  static const String tomorrow  = 'tomorrow';
  static const String unknown   = 'unknown';
  static const String ago = 'ago';
  static const String inPrefix = 'in';
  static const String minuteSingular = 'minute';
  static const String minutePlural   = 'minutes';
  static const String hourSingular   = 'hour';
  static const String hourPlural     = 'hours';
  static const String daySingular    = 'day';
  static const String dayPlural      = 'days';
  static const String weekSingular   = 'week';
  static const String weekPlural     = 'weeks';
  static const String monthSingular  = 'month';
  static const String monthPlural    = 'months';
  static const String yearSingular   = 'year';
  static const String yearPlural     = 'years';

  static const String am = 'AM';
  static const String pm = 'PM';

  static const List<String> months = [
    'january', 'february', 'march',     'april',   'may',      'june',
    'july',    'august',   'september', 'october', 'november', 'december',
  ];

  static const String addToCart = "add_to_cart" ;
  static const String delete = "delete" ;
  static const String added = "added" ;
  static const String removed = "removed" ;
  static const String successfully = "successfully" ;
  static const String from = "from" ;
  static const String to = "to" ;
  static const String favorite = "favorite" ;
  static const String forward = 'forward' ;
  static const String share = 'share' ;
  static const String chooseSource = 'choose_source' ;
  static const String chooseImageSourceCameraOrGallery = 'choose_image_source_camera_or_gallery' ;
  static const String camera = "camera" ;
  static const String gallery = "gallery" ;
  static const String areYouSure = "are_you_sure";
  static const String areYouSureToDoThisAction = "are_you_sure_to_do_this_action";
  static const String submit= "submit" ;
  static const String cancel= "cancel" ;
  static const String operationDidSuccessfully= "operation_did_successfully";
  static const String errorOccurred= "error_occurred";
  static const String warning= "warning";
  static const String thereWasAnErrorWhileLoadingData= "there_was_an_error_while_loading_data";
  static const String noDataAvailable= "no_data_available";

  static const String enter ="enter";
  static const String phoneNumber ="phone_number" ;
  static const String search ="search" ;
  static const String welcomeBack = "welcome_back" ;
  static const String pleasFillFormBelowToLogin = "please_fill_form_below_to_login" ;
  static const String forgetPassword = "forget_password" ;
  static const String confirm = "confirm" ;
  static const String resetPassword = "reset_password" ;
  static const String resetYourPassword = "reset_your_password" ;
  static const String toResetYourPasswordPleaseEnterYourRegisteredEmail = "To_reset_your_password_please_enter_your_registered_email" ;
  static const String sendConfirmation = "send_confirm" ;
  static const String weHaveSentYouAnEmailContainingConfirmation = "we_have_sent_you_an_email_containing_confirmation" ;
  static const String confirmationHasBeenSentToYourEmailAddress = "confirmation_has_been_sent_to_your_email_address" ;
  static const String pleaseClickTheURLInTheEmailToResetYourPassword = "please_click_the_url_in_the_email_to_reset_your_password" ;
  static const String resendIn  = "resend_in" ;
  static const String recommended = "recommended" ;
  static const String atLeastOneLowerCase = "at_least_one_lower_case" ;
  static const String atLeastOneUpperCase = "at_least_one_upper_case" ;
  static const String atLeastOneSpecialCharacter= "at_least_one_special_character" ;
  static const String atLeastOneNumber = "at_least_one_number" ;
  static const String atLeast8Length = "at_least_8_length" ;
  static const String dontHaveAnAccount = "dont_have_an_account" ;
  static const String signUp = "sign_up";
  static const String signIn = "sign_in";
  static const String continueAsGuest = "continue_as_guest";
  static const String confirmYourNumber = "confirm_your_number";
  static const String toCompleteTheVerificationProcess = "to_complete_the_verification_process";
  static const String pleaseEnterThe6DigitCodeSentToYourNumber = "please_enter_the_6_digit_code_sent_to_your_number";
  static const String confirmOtp = "confirm_otp";
  static const String joinUs = "join_us";
  static const String exploreRecommendationsMadeForYourActivity = "explore_recommendations_made_for_your_activity";
  static const String fullName = "full_name";
  static const String getStarted = "get_started";
  static const String next = "next";
  static const String skip = "skip";
  static const String onBoarding1Title = "on_boarding_1_title" ;
  static const String onBoarding1description = "on_boarding_1_description" ;
  static const String onBoarding1HighLight = "on_boarding_1_highlight" ;
  static const String onBoarding2Title = "on_boarding_2_title" ;
  static const String onBoarding2description = "on_boarding_2_description" ;
  static const String onBoarding2HighLight = "on_boarding_2_highlight" ;
  static const String onBoarding3Title = "on_boarding_3_title" ;
  static const String onBoarding3description = "on_boarding_3_description" ;








}