import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor/core/extensions/safe_emit.dart';
import 'package:multi_vendor/features/authentication/data/repository/otp_repository.dart';

import '../../../core/cubit/base_state.dart';

class OtpConfirmCubit extends Cubit<BaseState<Unit>>{
  final OtpRepository _repository ;
  OtpConfirmCubit(this._repository) : super(const BaseState.initial());



  Future<void>confirmOtp({required String otp,required String provider})async{
  safeEmit(const BaseState.loading()) ;
  final result = await _repository.confirmOtp(otp: otp,phone:  provider);
  result.fold((e)=>safeEmit(BaseState.failure(e)),
      (r)=>safeEmit(BaseState.success(r))) ;
  }


}