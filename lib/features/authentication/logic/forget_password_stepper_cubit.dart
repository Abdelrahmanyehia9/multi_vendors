import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor/core/cubit/base_state.dart';
import 'package:multi_vendor/core/extensions/safe_emit.dart';


class ForgetPasswordStepperCubit extends Cubit<BaseState<int>>{
 late  int currentStep ;
  TextEditingController emailController = TextEditingController();
  ForgetPasswordStepperCubit() : super( const BaseState.initial()) ;


  void init({String? email,required int initialStep}){
    currentStep = initialStep;
    if(email != null) emailController.text = email;
    safeEmit(BaseState.success(currentStep));
  }

  void nextStep() {
    currentStep++;
    safeEmit(BaseState.success(currentStep));
  }
  void previousStep() {
    if(currentStep == 0) return ;
    currentStep--;
    safeEmit(BaseState.success(currentStep));
  }
 String? get email => emailController.text;
  @override
  Future<void> close() {
    emailController.dispose();
    return super.close();
  }

}
