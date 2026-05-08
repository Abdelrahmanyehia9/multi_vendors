import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor/core/extensions/safe_emit.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';
import 'package:multi_vendor/shared/logic/user_states.dart';
import 'package:multi_vendor/shared/data/repository/user_session_repository.dart';
import 'package:multi_vendor/shared/data/models/user_model.dart';

class UserCubit extends Cubit<UserStates> {
  final UserSessionRepository _sessionHelper ;
  UserCubit(this._sessionHelper) : super(const UserInitial());
  Future<void>init()async{
    _sessionHelper.setupListener(
    onSignIn: () => safeEmit(UserSignIn()),
   onFirstTimeJoin: () => safeEmit(UserFirstTimeJoin()),
   onSignOut: () => safeEmit(UserSignOut()),
    onUpdateUser:  (user) => safeEmit(UserUpdated(user)),
      onError: (_){}
    );
  }
  Future<void>logout()async{
    await _sessionHelper.logout();
  }
   void finishIntro() => _sessionHelper.finishIntro();
  void loginAsGuest()=> safeEmit(UserSignIn());
  
  
  UserModel? get user => _sessionHelper.cachedUser;
  String get userName => user?.fullName?? user?.phone??AppStrings.guest.tr() ;
  bool get isGuest => user == null;
}