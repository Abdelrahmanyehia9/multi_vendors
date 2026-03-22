class AppErrorMessages {
  const AppErrorMessages._();

  static const unexpectedError = 'حدث خطأ غير متوقع، حاول مرة أخرى';
  static const networkError =
      'خطأ في الاتصال بالإنترنت، تأكد من الشبكة وحاول مرة أخرى';
  static const timeoutError = 'انتهت مهلة الطلب، برجاء المحاولة مرة أخرى';
  static const unauthorized = 'غير مصرح لك بتنفيذ هذا الإجراء';
  static const formatException = 'حدث خطأ في صيغة البيانات';
}
class DatabaseErrorMessages {
  const DatabaseErrorMessages._();

  /// DATABASE
  static const duplicate = 'البيانات موجودة بالفعل';
  static const foreignKey = 'لا يمكن الحذف أو الإضافة لوجود بيانات مرتبطة';
  static const notNullViolation = 'يجب إدخال كل الحقول المطلوبة';
  static const checkViolation = 'القيمة المدخلة غير مسموح بها';

  static const insufficientPrivilege = 'ليس لديك صلاحية لتنفيذ هذا الإجراء';
  static const undefinedTable = 'البيانات المطلوبة غير موجودة';
  static const undefinedColumn = 'حدث خطأ في بنية البيانات';
  static const undefinedFunction = 'عملية غير مدعومة حالياً';

  static const invalidInputSyntax = 'البيانات المدخلة غير صحيحة';
  static const readOnlyTransaction = 'لا يمكن التعديل حالياً';

  static const connectionFailure = 'فشل الاتصال بقاعدة البيانات';
  static const internalError = 'حدث خطأ داخلي في الخادم';

  /// POSTGREST
  static const noRows = 'لا توجد بيانات';
  static const parseError = 'خطأ في صيغة الطلب';
  static const invalidBody = 'البيانات المرسلة غير صحيحة';
  static const invalidRange = 'المدى المطلوب غير صحيح';
  static const invalidPath = 'الرابط غير صحيح';
  static const invalidMethod = 'العملية غير مسموح بها';

  static const connectionError = 'تعذر الاتصال بالخادم';
  static const timeout = 'انتهت مهلة الاتصال';

  static const staleRelation = 'البيانات غير متزامنة، حاول مرة أخرى';
  static const ambiguousRelation = 'الطلب غير واضح';
  static const staleFunction = 'الدالة غير موجودة';
  static const columnNotFound = 'العمود غير موجود';
  static const tableNotFound = 'الجدول غير موجود';

  static const jwtInvalid = 'جلسة الدخول غير صالحة';
  static const jwtMissing = 'يجب تسجيل الدخول أولاً';
  static const jwtClaimsInvalid = 'انتهت صلاحية الجلسة';

  static const unknown = 'حدث خطأ غير متوقع';
}
class AuthErrorMessages {
  const AuthErrorMessages._();

  static const invalidEmail = 'عنوان البريد الإلكتروني غير صحيح';
  static const emailExists = 'البريد الإلكتروني مستخدم بالفعل';
  static const emailNotConfirmed =
      'برجاء تأكيد البريد الإلكتروني قبل تسجيل الدخول';
  static const emailProviderDisabled =
      'التسجيل بالبريد الإلكتروني غير متاح حاليًا';
  static const emailConflictIdentityNotDeletable =
      'يوجد تعارض في البريد الإلكتروني ولا يمكن حذف الهوية';

  static const invalidCredentials = 'بيانات تسجيل الدخول غير صحيحة';
  static const userNotFound = 'هذا المستخدم غير موجود';
  static const userAlreadyExists = 'هذا المستخدم مسجل بالفعل';
  static const userBanned = 'تم حظر هذا الحساب مؤقتًا';

  static const weakPassword = 'كلمة المرور ضعيفة جدًا';
  static const samePassword =
      'يجب أن تكون كلمة المرور الجديدة مختلفة عن الحالية';
  static const reauthenticationNeeded =
      'يجب إعادة تسجيل الدخول لتنفيذ هذا الإجراء';
  static const reauthenticationNotValid = 'بيانات إعادة تسجيل الدخول غير صحيحة';

  static const otpExpired = 'انتهت صلاحية رمز التحقق، برجاء طلب رمز جديد';
  static const otpDisabled =
      'تسجيل الدخول برمز التحقق غير متاح لهذا الرقم جرب تسجيل حساب جديد ';
  static const mfaVerificationFailed = 'فشل التحقق بخطوتين';
  static const mfaChallengeExpired =
      'انتهت صلاحية التحقق بخطوتين، حاول مرة أخرى';
  static const tooManyEnrolledMfaFactors =
      'تم تسجيل عدد كبير من وسائل التحقق، برجاء إزالة أحدها';

  static const sessionExpired = 'انتهت الجلسة، برجاء تسجيل الدخول مرة أخرى';
  static const refreshTokenNotFound =
      'انتهت صلاحية الجلسة، برجاء تسجيل الدخول مرة أخرى';
  static const refreshTokenAlreadyUsed =
      'تم استخدام الجلسة مسبقًا، برجاء تسجيل الدخول مرة أخرى';
  static const noAuthorization = 'غير مصرح لك بالوصول إلى هذه البيانات';

  static const oauthProviderNotSupported = 'طريقة تسجيل الدخول غير مدعومة';
  static const providerDisabled = 'طريقة تسجيل الدخول هذه غير متاحة حاليًا';
  static const providerEmailNeedsVerification =
      'يجب تأكيد البريد الإلكتروني أولًا';
  static const userSsoManaged =
      'هذا الحساب مدار بواسطة نظام دخول خارجي ولا يمكن تعديل بعض البيانات';

  static const overRequestRateLimit = 'عدد محاولات كبير، برجاء المحاولة لاحقًا';
  static const overEmailSendRateLimit =
      'تم إرسال عدد كبير من الرسائل، برجاء المحاولة لاحقًا';
  static const overSmsSendRateLimit =
      'تم إرسال عدد كبير من رسائل التحقق، برجاء الانتظار قليلًا';

  static const phoneExists = 'رقم الهاتف مستخدم بالفعل';
  static const phoneNotConfirmed = 'رقم الهاتف غير مُفعل';
  static const phoneProviderDisabled = 'التسجيل برقم الهاتف غير متاح حاليًا';
  static const smsSendFailed = 'فشل إرسال رسالة التحقق، حاول مرة أخرى';

  static const flowStateExpired =
      'انتهت عملية التسجيل، برجاء المحاولة مرة أخرى';
  static const flowStateNotFound =
      'حدث خطأ في عملية التسجيل، برجاء المحاولة مرة أخرى';

  static const unexpectedFailure = 'حدث خطأ غير متوقع، برجاء المحاولة مرة أخرى';

  static const String signInCanceled = 'تم إلغاء تسجيل الدخول بواسطة المستخدم.';

  static const String interrupted = 'تم مقاطعة تسجيل الدخول. حاول مرة أخرى.';

  static const String accountExistsWithDifferentCredential =
      'هذا الحساب موجود مع طريقة تسجيل مختلفة. استخدم نفس الطريقة السابقة.';

  static const String userConfigError =
      'هناك خطأ في إعدادات تسجيل الدخول. يرجى المحاولة لاحقًا.';
  static const String providerConfigurationError =
      'خطأ في إعدادات مزود تسجيل الدخول. حاول مرة أخرى لاحقًا.';
  static const String uiUnavailable =
      'واجهة تسجيل الدخول غير متاحة على هذا الجهاز.';

  static const String unknown =
      'حدث خطأ غير متوقع أثناء تسجيل الدخول. حاول مرة أخرى.';
}
class StorageErrorMessage {
  const StorageErrorMessage._();
  static const noSuchBucket = 'المجلد غير موجود';
  static const noSuchKey = 'الملف غير موجود';
  static const noSuchUpload = 'عملية الرفع غير موجودة';
  static const invalidJWT = 'جلسة الدخول غير صالحة';
  static const invalidRequest = 'الطلب غير صحيح';
  static const tenantNotFound = 'حدث خطأ في إعدادات التخزين';
  static const entityTooLarge = 'حجم الملف كبير جداً';
  static const internalError = 'حدث خطأ داخلي في الخادم';
  static const resourceAlreadyExists = 'الملف موجود بالفعل';
  static const invalidBucketName = 'اسم المجلد غير صالح';
  static const invalidKey = 'اسم الملف غير صالح';
  static const invalidRange = 'المدى المطلوب غير صحيح';
  static const invalidMimeType = 'نوع الملف غير مدعوم';
  static const invalidUploadId = 'معرّف الرفع غير صالح';
  static const keyAlreadyExists = 'اسم الملف مستخدم بالفعل';
  static const bucketAlreadyExists = 'المجلد موجود بالفعل';
  static const databaseTimeout = 'انتهت مهلة الخادم';
  static const invalidSignature = 'توقيع غير صالح';
  static const signatureDoesNotMatch = 'فشل التحقق من التوقيع';
  static const accessDenied = 'لا تملك صلاحية الوصول';
  static const resourceLocked = 'الملف مقفول حالياً';
  static const databaseError = 'خطأ في قاعدة البيانات';
  static const missingContentLength = 'بيانات الملف غير مكتملة';
  static const missingParameter = 'يوجد بيانات ناقصة';
  static const invalidUploadSignature = 'توقيع الرفع غير صالح';
  static const lockTimeout = 'انتهت مهلة القفل';
  static const s3Error = 'خطأ في خدمة التخزين';
  static const s3InvalidAccessKeyId = 'مفتاح الوصول غير صحيح';
  static const s3MaximumCredentialsLimit = 'تم الوصول للحد الأقصى من المفاتيح';
  static const invalidChecksum = 'الملف تالف أو غير مكتمل';
  static const missingPart = 'جزء من الملف مفقود';
  static const slowDown = 'طلبات كثيرة، حاول لاحقاً';
  static const unknown = 'حدث خطأ غير متوقع';
}
