import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/widgets/buttons/app_button.dart';
import 'package:multi_vendor/core/widgets/gap.dart';
import 'package:multi_vendor/shared/logic/image_picker_cubit.dart';
import 'package:multi_vendor/shared/logic/image_picker_states.dart';
import 'package:multi_vendor/shared/view/widgets/user_avatar.dart';

class ChangeProfilePic extends StatefulWidget {
  const ChangeProfilePic({super.key});

  @override
  State<ChangeProfilePic> createState() => _ChangeProfilePicState();
}

class _ChangeProfilePicState extends State<ChangeProfilePic> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ImageCubit, ImagePickerState>(
      listener: (_,s)async{

        }
      ,
      builder:(_,_)=> Column(
        children: [
          const Center(child: UserAvatar(size: 100)),
          Gap.small(),
          AppButton.text(
            text: "Change Profile Photo",
            onPressed: ()async{

            },
            style: TextStyles.labelSmall,)
        ],
      ),
    );
  }
}
