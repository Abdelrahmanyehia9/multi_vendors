import 'package:image_cropper/image_cropper.dart';
import 'package:multi_vendor/core/errors/error_messages.dart';
import 'package:multi_vendor/core/errors/exceptions.dart';

enum ImageCropType {
  circle,
  rectangle,
}

final class ImageCropService {
  const ImageCropService();
  static final ImageCropper _cropper = ImageCropper();
   Future<CroppedFile?> cropImage(
      String path, {
        ImageCropType? type ,
        String? title ,
      }) async
   {
    final cropStyle = type == ImageCropType.circle ? CropStyle.circle : CropStyle.rectangle;
  try{
    return await _cropper.cropImage(
      sourcePath: path,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: title,
          cropStyle: cropStyle,
        ),
        IOSUiSettings(
          title: title,
          resetAspectRatioEnabled: type != ImageCropType.circle,
        ),
      ],
    );
  }catch(e){
    throw ImagePickerError(message: ImagePickerErrorMessage.errorCropping);
  }
  }
}