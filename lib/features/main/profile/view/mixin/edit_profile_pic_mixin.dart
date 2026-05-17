import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:multi_vendor/core/errors/exceptions.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/service/image_crop_service.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';
import 'package:multi_vendor/features/main/profile/logic/edit_profile_pic_cubit.dart';
import 'package:multi_vendor/features/main/profile/view/widgets/change_profile_pic.dart';
import 'package:flutter/material.dart';
import 'package:multi_vendor/shared/logic/image_handle_cubit.dart';


mixin EditProfilePicMixin on State<ChangeProfilePic>{
  String? path;
  ImageHandleCubit get imageHandleCubit => context.read<ImageHandleCubit>();
  EditProfilePicCubit get editPicCubit => context.read<EditProfilePicCubit>();
  void onImageChangedSuccess(String? message) {
    context.successBar(message: message!);
    context.loaderOverlay.hide() ;
    imageHandleCubit.reset() ;

  }
  void onImageChangedFailed(AppException ex) {
    context.errorBar(message: ex.message);
    imageHandleCubit.reset() ;
    context.loaderOverlay.hide() ;
  }

  void onImagePickedError(AppException ex) {
    context.errorBar(message: ex.message);
  }
  Future<void>onImagePicked(String p)async{
    path = p;
    imageHandleCubit.crop(
      p,
      title: AppStrings.setProfilePic.tr(),
      type: ImageCropType.circle,
    );
  }
  Future<void>onImageCropped(String p)async{
    path = p;
    _onAddPic();
  }
  Future<void>onDeletePic()async =>editPicCubit.remove();
  Future<void>_onAddPic()async{
    if(path == null) return;
    editPicCubit.add(path!) ;
  }

}