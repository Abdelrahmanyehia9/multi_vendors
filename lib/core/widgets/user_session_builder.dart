import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor/core/cubit/user_cubit.dart';
import 'package:multi_vendor/core/cubit/user_states.dart';
import 'package:multi_vendor/core/routes/routes.dart';

import '../service/deep_link.dart';
import '../service/navigation_service.dart';

class UserSessionBuilder extends StatefulWidget {
  final Widget child;
  const UserSessionBuilder({super.key, required this.child});

  @override
  State<UserSessionBuilder> createState() => _UserSessionBuilderState();
}

class _UserSessionBuilderState extends State<UserSessionBuilder> {
  bool _isNavigating = false;

  @override
  void initState() {
    super.initState();
    DeepLinkService.instance.initDeepLink();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit, UserStates>(
      listener: (context, state) {
        if (_isNavigating) return;

        if (state is UserFirstTimeJoin) {
          _go(Routes.onBoarding);
        } else if (state is UserSignIn) {
          _go(Routes.mainLayout);
        } else if (state is UserSignOut) {
          _go(Routes.loginScreen);
        }
      },
      child: widget.child,
    );
  }

  void _go(String route) {
    if (!mounted || _isNavigating) return;

    _isNavigating = true;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      NavigationService.navigator?.pushNamedAndRemoveUntil(
        route,
            (_) => false,
      );

      _isNavigating = false;
    });
  }
}