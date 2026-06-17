import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor/core/cubit/connection_states.dart';
import 'package:multi_vendor/core/extensions/safe_emit.dart';
import 'package:multi_vendor/core/utils/helper/network_checker.dart';

class ConnectionCubit extends Cubit<ConnectionStates>
    with WidgetsBindingObserver {
  bool hasNetwork = false;
  StreamSubscription? _internetSubscription;
  Timer? _debounceTimer;
  final NetworkChecker checker;

  ConnectionCubit(this.checker) : super(ConnectionStateInitial());

  Future<void> init() async {
    WidgetsBinding.instance.addObserver(this);
    await getNetworkState();
    _listenToConnectivity();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      getNetworkState();
    }
  }

  Future<void> getNetworkState() async {
    final hasInternet = await checker.hasRealInternet();
    if (hasInternet) {
      hasNetwork = true;
      return safeEmit(HaveConnectionWithNetwork());
    }
    hasNetwork = false;
    final connected = await checker.isConnectedToNetwork();
    if (connected) {
      safeEmit(HaveConnectionWithoutNetwork());
    } else {
      safeEmit(HaveNotConnection());
    }
  }

  void _listenToConnectivity() {
    _internetSubscription = checker.onInternetChanged.listen(
          (event) {
        _debounceTimer?.cancel();
        _debounceTimer = Timer(const Duration(seconds: 3), () async {
          hasNetwork = event;
          if (hasNetwork) {
            safeEmit(HaveConnectionWithNetwork());
          } else {
            if (await checker.isConnectedToNetwork()) {
              safeEmit(HaveConnectionWithoutNetwork());
            } else {
              safeEmit(HaveNotConnection());
            }
          }
        });
      },
    );
  }

  @override
  Future<void> close() {
    _debounceTimer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    _internetSubscription?.cancel();
    return super.close();
  }
}