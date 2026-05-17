// import 'package:multi_vendor/core/service/auth_service.dart';
//
// abstract class SocialMediaAuthProvider{
//   final AuthenticationService _service ;
//   SocialMediaAuthProvider(this._service);
//   Future<void>login();
// }
//
//
//
// class GoogleSignInProvider extends SocialMediaAuthProvider{
//   GoogleSignInProvider(super.service);
//   final String webClientId = "" ;
//   final String iosClientId ="";
//   @override
//   Future<void> login() async{
//   await  _service.googleSignIn(
//       webClientId: webClientId,
//       iosClientId: iosClientId,
//     );
//   }
// }