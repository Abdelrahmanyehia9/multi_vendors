import 'dart:ui';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class NetworkChecker{
  final Connectivity _connectivity;
  final InternetConnection _internetChecker;
  const NetworkChecker(this._connectivity, this._internetChecker);
  Future<bool> isConnectedToNetwork() async {
    final result = await _connectivity.checkConnectivity();
    return !result.contains(ConnectivityResult.none);
  }
  Future<bool> hasRealInternet() async {
    try {
      final hasNetwork = await isConnectedToNetwork();
      if (!hasNetwork) return false;
      final hasInternet = await _internetChecker.hasInternetAccess;
      return hasInternet;
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
  }) async
  {
    if (await hasRealInternet()) {
      onConnected();
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
