import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor/core/DI/setup_get_it.dart';
import 'package:multi_vendor/shared/data/models/user_model.dart';
import 'package:multi_vendor/shared/logic/user_cubit.dart';
import 'package:multi_vendor/shared/logic/user_states.dart';

class UserBuilder extends StatelessWidget {
  final Widget Function(UserModel? user)   builder ;
  const UserBuilder({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<UserCubit, UserStates>(
        builder: (_, state)=> state is UserUpdated ?builder.call(state.user):builder.call(userCubit.user)
    );
  }
}
