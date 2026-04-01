import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor/core/cubit/user_cubit.dart';
import 'package:multi_vendor/core/cubit/user_states.dart';
import 'package:multi_vendor/core/routes/routes.dart';

import '../service/deep_link.dart';
import '../service/navigation_service.dart';

class UserSessionBuilder extends StatefulWidget {
  final Widget child ;
  const UserSessionBuilder({super.key, required this.child});

  @override
  State<UserSessionBuilder> createState() => _UserSessionBuilderState();
}

class _UserSessionBuilderState extends State<UserSessionBuilder> {

@override
  void initState() {
    DeepLinkService.instance.initDeepLink();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit, UserStates>(
        listener: (context, state){
          if(state is UserFirstTimeJoin) _go(Routes.onBoarding);
          if(state is UserSignIn) _go(Routes.mainLayout) ;
          if(state is UserSignOut) _go(Routes.loginScreen) ;
        },
      child: widget.child,
    );

  }

  void _go(String route) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      NavigationService.navigator?.pushNamedAndRemoveUntil(route, (_) => false);
    });
  }
}

