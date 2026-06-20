import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class NetworkChecker {
  final Connectivity _connectivity = Connectivity();
  final InternetConnection _internetChecker = InternetConnection.createInstance(
    checkInterval: const Duration(seconds: 3),
  );

  NetworkChecker._();
  static final NetworkChecker instance = NetworkChecker._();



  Future<bool> isConnectedToNetwork() async {
    final result = await _connectivity.checkConnectivity();
    final connected = !result.contains(ConnectivityResult.none);
    return connected;
  }

  Future<bool> hasRealInternet({
    Duration totalTimeout = const Duration(seconds: 5),
    Duration retryDelay = const Duration(milliseconds: 400),
  }) async {
    try {
      final hasNetwork = await isConnectedToNetwork();
      if (!hasNetwork) {
        return false;
      }
      final deadline = DateTime.now().add(totalTimeout);
      while (DateTime.now().isBefore(deadline)) {
        final hasInternet = await _internetChecker.hasInternetAccess;
        if (hasInternet) {
          return true;
        }
        await Future.delayed(retryDelay);
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Stream<bool> get onInternetChanged {
    return _internetChecker.onStatusChange.map((status) {
      final connected = status == InternetStatus.connected;
      return connected;
    });
  }

  Future<void> waitForRealInternet({
    required void Function() onConnected,
    void Function()? onWaiting,
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