import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:multi_vendor/core/cubit/base_bloc_consumer.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';
import 'package:multi_vendor/core/utils/helper/image_picker_helper.dart';
import 'package:multi_vendor/core/utils/mv_icons.dart';
import 'package:multi_vendor/core/widgets/app_click.dart';
import 'package:multi_vendor/core/widgets/buttons/app_button.dart';
import 'package:multi_vendor/features/main/profile/logic/edit_profile_pic_cubit.dart';
import 'package:multi_vendor/features/main/profile/view/mixin/edit_profile_pic_mixin.dart';
import 'package:multi_vendor/shared/logic/image_handle_cubit.dart';
import 'package:multi_vendor/shared/logic/image_handle_states.dart';
import 'package:multi_vendor/shared/view/widgets/circular_box.dart';
import 'package:multi_vendor/shared/view/widgets/user_avatar.dart';
import 'package:multi_vendor/shared/view/widgets/user_builder.dart';

class ChangeProfilePic extends StatefulWidget {
  const ChangeProfilePic({super.key});

  @override
  State<ChangeProfilePic> createState() => _ChangeProfilePicState();
}

class _ChangeProfilePicState extends State<ChangeProfilePic> with EditProfilePicMixin{

  @override
  Widget build(BuildContext context) {
    return BaseBlocConsumer<EditProfilePicCubit, String>(
      onLoading: context.loaderOverlay.show,
      onSuccess: onImageChangedSuccess,
      onFailure: onImageChangedFailed,
      builder:(_)=> Column(
        children: [
          BlocConsumer<ImageHandleCubit, ImageHandleStates>(
            listener: (_, state) async {
              /// handle errors
              if (state is ImageHandleError) onImagePickedError(state.exception);
              /// image picked
              if (state is ImagePickedSuccess) onImagePicked(state.path);
              /// to crop Image you Can Ignore it and call onImageChanged in ImagePickedSuccess
              if (state is ImageCroppedSuccess) onImageCropped(state.path);
            },
            builder: (_, state) {
              bool pickedState = state is ImageCroppedSuccess || state is ImagePickedSuccess ;
              /// image picked in file
              if (pickedState) {
                return CircularBox(
                  child: Image.file(
                    fit: BoxFit.cover,
                    width: 100.w,
                    height: 100.w,
                    File(path!),
                  ),
                );
              }
              /// default image from user
              return UserBuilder(
                builder:(u)=> Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                     UserAvatar(size: 100, profile: u?.profilePic),
                    if(u?.profilePic != null)
                    AppClick(
                      onTap: onDeletePic,
                      child: CircleAvatar(
                        backgroundColor : AppColors.error,
                        radius: 18.r,
                        child: Icon(
                          MvIcons.delete,
                          size: 18.sp,
                          color: AppColors.white,

                        ),
                      ),
                    ),

                  ],
                ),
              );
            },
          ),
          _action()
        ],
      ),
    );
  }
  Widget _action()=>UserBuilder(
    builder:(u)=> AppButton.text(
      text: u?.profilePic==null? AppStrings.add.tr():AppStrings.change.tr(),
      onPressed: () async {
        final source = await ImagePickerHelper.choseSource(context);
        if (source != null) imageHandleCubit.picker(source);
      },
      style: TextStyles.labelMedium,
    ),
  ) ;
}
