import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor/core/cubit/user_cubit.dart';
import 'package:multi_vendor/core/cubit/user_states.dart';
import 'package:multi_vendor/core/routes/routes.dart';

import '../service/navigation_service.dart';

class UserSessionBuilder extends StatelessWidget {
  final Widget child ;
  const UserSessionBuilder({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit, UserStates>(
        listener: (context, state){
          if(state is UserFirstTimeJoin) _go(Routes.onBoarding);
          if(state is UserSignIn) _go(Routes.mainLayout) ;
          if(state is UserSignOut) _go(Routes.loginScreen) ;
        },
      child: child,
    );

  }

  void _go(String route) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      NavigationService.navigator?.pushNamedAndRemoveUntil(route, (_) => false);
    });
  }

}

