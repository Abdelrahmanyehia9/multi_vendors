import 'package:app_links/app_links.dart';
import 'package:multi_vendor/features/authentication/view/forget_password_screen.dart';
import 'package:multi_vendor/core/routes/routes.dart';
import 'package:multi_vendor/core/service/navigation_service.dart';

final class DeepLinkService {
  DeepLinkService._();
  static final DeepLinkService instance = DeepLinkService._();

  AppLinks? _appLinks;
  final Set<String> _handledUris = {};

  Future<void> initDeepLink() async {
    if (_appLinks != null) return;
    _appLinks = AppLinks();
    final uri = await _appLinks!.getInitialLink();
    if (uri != null) _handleUri(uri);
    _appLinks!.uriLinkStream.listen(_handleUri);
  }

  Future<void> _handleUri(Uri uri) async {
    if (uri.host != 'avera') return;

    final uriString = uri.toString();
    if (_handledUris.contains(uriString)) return;

    switch (uri.path) {
      case '/reset-password':
        _handledUris.add(uriString);
        await _handleResetPassword(uri);
        break;
      case '/product':
        final id = int.tryParse(uri.queryParameters['id'].toString());
        if (id == null) return;
        _handledUris.add(uriString);
        NavigationService.navigatorKey.currentState?.pushNamed(
          Routes.product,
          arguments: id,
        );
        break;
    }
  }

  Future<void> _handleResetPassword(Uri uri) async {
    try {
      NavigationService.navigatorKey.currentState?.pushNamed(
        Routes.forgetPassword,
        arguments: ForgetPasswordArgs(initialStep: 2),
      );
    } catch (e) {
      NavigationService.navigatorKey.currentState?.pushNamed(
        Routes.forgetPassword,
        arguments: ForgetPasswordArgs(),
      );
    }
  }
}