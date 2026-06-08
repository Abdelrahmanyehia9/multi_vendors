import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor/core/cubit/connection_states.dart';
import 'package:multi_vendor/core/extensions/safe_emit.dart';
import 'package:multi_vendor/core/utils/helper/network_checker.dart';

class ConnectionCubit extends Cubit<ConnectionStates> {
  bool hasNetwork = false;
   StreamSubscription? _internetSubscription;
  final NetworkChecker checker;
  ConnectionCubit(this.checker) : super(ConnectionStateInitial());

  Future<void> init() async {
    await getNetworkState();
    _listenToConnectivity();
  }

  Future<void> getNetworkState() async {
    final hasInternet = await checker.hasRealInternet();
    if (hasInternet) {
      hasNetwork = true;
      return safeEmit(HaveConnectionWithNetwork());
    }
    hasNetwork = false ;
    final connected = await checker.isConnectedToNetwork();
    if (connected) {
      safeEmit(HaveConnectionWithoutNetwork());
    }
    else {
      safeEmit(HaveNotConnection());
    }
  }

  void _listenToConnectivity() {
    _internetSubscription = checker.onInternetChanged.listen(
          (event) async {
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
      },
    );
  }

  @override
  Future<void> close() {
    _internetSubscription?.cancel();
    return super.close();
  }
}