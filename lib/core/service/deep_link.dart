import 'package:app_links/app_links.dart';

import '../../features/authentication/view/forget_password_screen.dart';
import '../routes/routes.dart';
import 'navigation_service.dart';

typedef _Args = (String, Object);

final class DeepLinkService {
  DeepLinkService._();
  static final DeepLinkService instance = DeepLinkService._();

  late final AppLinks _appLinks;
  final Set<String> _handledUris = {};

  Future<void> initDeepLink() async {
    _appLinks = AppLinks();
    final uri = await _appLinks.getInitialLink();
    if (uri != null) _handleUri(uri);
    _appLinks.uriLinkStream.listen(_handleUri);
  }

  void _handleUri(Uri uri) {
    final uriString = uri.toString();
    if (_handledUris.contains(uriString)) return;

    for (var entry in _mapRedirect.entries) {
      if (uriString.contains(entry.key)) {
        _handledUris.add(uriString);

        NavigationService.navigatorKey.currentState
            ?.pushNamed(entry.value.$1, arguments: entry.value.$2);
        break;
      }
    }
  }

  final Map<String, _Args> _mapRedirect = {
    "myapp://reset-password": (
    Routes.forgetPassword,
    ForgetPasswordArgs(initialStep: 2),
    ),
  };
}