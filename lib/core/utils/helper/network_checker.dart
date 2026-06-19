import 'dart:ui';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class NetworkChecker{
  final Connectivity _connectivity = Connectivity();
  final InternetConnection _internetChecker = InternetConnection();
   NetworkChecker._();
   static final NetworkChecker instance = NetworkChecker._();
  Future<bool> isConnectedToNetwork() async {
    final result = await _connectivity.checkConnectivity();
    return !result.contains(ConnectivityResult.none);
  }
  Future<bool> hasRealInternet() async {
    try {
      final hasNetwork = await isConnectedToNetwork();
      if (!hasNetwork) return false;
      for (int attempt = 0; attempt < 3; attempt++) {
        final hasInternet = await _internetChecker.hasInternetAccess;
        if (hasInternet) return true;
        if (attempt < 2) {
          await Future.delayed(const Duration(milliseconds: 800));
        }
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Stream<bool> get onInternetChanged {
    return _internetChecker.onStatusChange.map((status) {
      return status == InternetStatus.connected;
    });
  }
  Future<void> waitForRealInternet({
    required VoidCallback onConnected,
    VoidCallback? onWaiting,
  }) async {
    if (await hasRealInternet()) {
      onConnected.call();
      return;
    }
    onWaiting?.call();
    await for (final isConnected in onInternetChanged) {
      if (isConnected) {
        onConnected();
        break;
      }
    }
  }
}
