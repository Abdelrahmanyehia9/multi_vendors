import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final class AuthenticationService {
  final SupabaseClient _client;
  const AuthenticationService(this._client);



  Future<void>signIn({required String email ,required String password})async=>await _client.auth.signInWithPassword(password: password,email: email) ;
  Future<void>signUp({required String email ,required String password})async=>await _client.auth.signUp(password: password, email: email);
  Future<void> sendOtp({
    required String phone,
    required OtpChannel channel,
    Map<String, dynamic>? data,
    bool createUser = true,
  }) async {
    await _client.auth.signInWithOtp(
      phone: phone,
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
    return await _client.auth.verifyOTP(phone: phone, token: otp, type: type);
  }


  // Future<AuthResponse> googleSignIn() async {
  //   final GoogleSignIn google = GoogleSignIn.instance;
  //   const webClientId =
  //       '1059539566814-o7fhi5710n4upfd8merdubl0e2561l69.apps.googleusercontent.com';
  //   const iosClientId =
  //       '1059539566814-0kfspb289mf8k61o6f3ht117epfamjtn.apps.googleusercontent.com';
  //   await google.initialize(clientId: iosClientId, serverClientId: webClientId);
  //   const List<String> scopes = ['email', 'profile'];
  //   final googleUser = await google.authenticate(scopeHint: scopes);
  //   final googleAuth = googleUser.authentication;
  //   final idToken = googleAuth.idToken;
  //
  //   if (idToken == null) {
  //     throw 'No ID Token found.';
  //   }
  //
  //   final result = await _client.auth.signInWithIdToken(
  //     provider: OAuthProvider.google,
  //     idToken: idToken,
  //   );
  //   return result;
  // }

  void setupAuthListener(
      Function(String id) onSignedIn,
      Function() onSignedOut,
      Function(String id)onUserUpdated,
      ) => _client.auth.onAuthStateChange.listen((data)
  async {

    final event = data.event;
    switch (event)
    {
      case AuthChangeEvent.signedIn:
        onSignedIn.call(data.session!.user.id);
        break;
      case AuthChangeEvent.signedOut:
        onSignedOut.call();
        break;
      case AuthChangeEvent.userUpdated:
        onUserUpdated.call(
          data.session!.user.id,
        );
        break;
      default:
        debugPrint("Auth event: $event");
    }
  }
  );

  bool get isAuthenticated => _client.auth.currentUser != null;
  Future<void> logout() async => await _client.auth.signOut();
}
