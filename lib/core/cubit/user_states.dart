import '../models/base_user_model.dart';

sealed class UserStates {
  const UserStates();
}
final class UserInitial extends UserStates {
  const UserInitial();
}
final class UserSignIn extends UserStates{}
final class UserSignOut extends UserStates{}
final class UserFirstTimeJoin extends UserStates{}
final class UserUpdated extends UserStates{
  final BaseUserModel user;
   const UserUpdated(this.user);
}