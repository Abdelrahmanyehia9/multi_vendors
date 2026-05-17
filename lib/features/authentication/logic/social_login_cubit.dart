import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor/core/cubit/base_state.dart';
import 'package:multi_vendor/core/enum/login_providers.dart';
import 'package:multi_vendor/core/extensions/safe_emit.dart';
import 'package:multi_vendor/features/authentication/data/repository/auth_repository.dart';

class SocialLoginCubit extends Cubit<BaseState<Unit>> {
  final AuthRepository _repository ;
  SocialLoginCubit(this._repository) : super(const BaseState.initial());

  Future<void> loginWithProvider(SocialMediaAuth auth)async{
   safeEmit( const BaseState.loading()) ;
   final result = await _repository.socialLogin(auth.provider);
   result.fold(
     (l) => safeEmit(BaseState.failure(l)),
     (r) => safeEmit(BaseState.success(r)),
   );
  }
}