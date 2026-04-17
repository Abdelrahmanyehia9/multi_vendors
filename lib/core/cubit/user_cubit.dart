import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor/core/cubit/user_states.dart';
import 'package:multi_vendor/core/extensions/safe_emit.dart';
import '../models/user_model.dart';
import '../utils/helper/user_session_helper.dart';

class UserCubit extends Cubit<UserStates> {
  final UserSessionHelper _sessionHelper ;
  UserCubit(this._sessionHelper) : super(const UserInitial());
  Future<void>init()async{
    _sessionHelper.setupListener(
    onSignIn: () => safeEmit(UserSignIn()),
   onFirstTimeJoin: () => safeEmit(UserFirstTimeJoin()),
   onSignOut: () => safeEmit(UserSignOut()),
    onUpdateUser:  (user) => safeEmit(UserUpdated(user)),
    );
  }
  Future<void>logout()async{
    await _sessionHelper.logout();
  }
   void finishIntro() => _sessionHelper.finishIntro();
  UserModel? get user => _sessionHelper.cachedUser;
  String get userName => user?.fullName?? user?.phone??"Guest" ;
  bool get isGuest => user == null;
}