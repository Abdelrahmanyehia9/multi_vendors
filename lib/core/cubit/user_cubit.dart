import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor/core/cubit/user_states.dart';
import 'package:multi_vendor/core/extensions/safe_emit.dart';
import 'package:multi_vendor/core/helper/user_session_helper.dart';
import '../models/base_user_model.dart';

class UserCubit extends Cubit<UserStates> {
  final UserSessionHelper _sessionHelper ;
  BaseUserModel? _model ;
  UserCubit(this._sessionHelper) : super(const UserInitial());
  Future<void>init()async{
    _sessionHelper.setupListener(
    onSignIn: () => safeEmit(UserSignIn()),
   onFirstTimeJoin: () => safeEmit(UserFirstTimeJoin()),
   onSignOut: () => safeEmit(UserSignOut()),
    onUpdateUser:  (user) => safeEmit(UserUpdated(user)),
    );
    _model =_sessionHelper.cachedUser;
  }
  Future<void>logout()async{
    await _sessionHelper.logout();
    _model = null;
  }
   void finishIntro() => _sessionHelper.finishIntro();
  BaseUserModel? get user => _model;
}