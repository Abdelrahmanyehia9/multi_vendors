
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final class AuthenticationService {
  final SupabaseClient _client;
  const AuthenticationService(this._client);

  Future<void> signIn({
    required String email,
    required String password,
  }) async => await _client.auth.signInWithPassword(password: password, email: email);

  Future<AuthResponse> signUp({
    required String email,
    required String password,
    Map<String, dynamic>? data,
  }) async => await _client.auth.signUp(password: password, email: email, data: data);

  Future<void> sendForgetPasswordEmail({required String email}) async =>
      await _client.auth.resetPasswordForEmail(
        email,
        redirectTo: 'myapp://reset-password',
      );

  Future<void> updateUser({
    String? password,
    String? email,
    Object? data,
  }) async
  {
    await _client.auth.updateUser(
      UserAttributes(password: password, email: email, data: data),
    );
  }

  Future<void> sendOtp({
    String? phone,
    String? email,
    required OtpChannel channel,
    Map<String, dynamic>? data,
    bool createUser = true,
  }) async {
    await _client.auth.signInWithOtp(
      phone: phone,
      email: email,
      channel: channel,
      data: data,
      shouldCreateUser: createUser,
    );
  }
  Future<AuthResponse> verifyOtp({
    required String phone,
    required String otp,
    OtpType type = OtpType.sms,
  }) async {
    return await _client.auth.verifyOTP(
        phone: phone, token: otp, type: type);
  }



  void setupAuthListener(
      Function(String id) onSignedIn,
      Function() onSignedOut,
      Function(String id) onUserUpdated,
      Function ()onInitialSession,
      ) => _client.auth.onAuthStateChange.listen(
        (data) async {
      final event = data.event;
      switch (event) {
        case AuthChangeEvent.signedIn:
          onSignedIn.call(data.session!.user.id);
          break;
        case AuthChangeEvent.initialSession:
        case AuthChangeEvent.tokenRefreshed:
          onInitialSession.call();
          break;
        case AuthChangeEvent.signedOut:
          onSignedOut.call();
          break;
        case AuthChangeEvent.userUpdated:
          onUserUpdated.call(data.session!.user.id);
          break;
        default:
          debugPrint("Auth event: $event");
      }
    },
       onError: (error) {
      if (error is AuthRetryableFetchException) {
        debugPrint("Token refresh failed temporarily: $error");
      } else {
        onSignedOut.call();
      }
    },
  );
  bool get isAuthenticated => _client.auth.currentUser != null;

  Future<bool> signInWithOAuth(OAuthProvider provider)async{
    return await _client.auth.signInWithOAuth(
      provider,
    );
  }


  Future<bool>loginWithOAuth(OAuthProvider provider)async{
   final result =await _client.auth.signInWithOAuth(provider) ;
    return result;

  }

  Future<void> logout() async => await _client.auth.signOut();
  Future<void>reAuth()async=>await _client.auth.reauthenticate() ;
  User? get currentUser => _client.auth.currentUser;
}
