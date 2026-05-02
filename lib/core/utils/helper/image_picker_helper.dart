import 'package:flutter/material.dart';
import 'package:multi_vendor/core/service/image_picker_service.dart';
import 'package:multi_vendor/core/widgets/overlays/bottom_sheets.dart';
import 'package:multi_vendor/core/widgets/overlays/chose_image_picker_source.dart';

class ImagePickerHelper {
const ImagePickerHelper._();
 static  Future<ImagePickerSource?> choseSource(BuildContext context)async{
    return await BottomSheets.show<ImagePickerSource>(
      context,
      child: const ChooseImageSource(),
    );
  }
}

