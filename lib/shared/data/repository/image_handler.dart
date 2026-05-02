import 'package:dartz/dartz.dart';
import 'package:multi_vendor/core/errors/error_messages.dart';
import 'package:multi_vendor/core/errors/exceptions.dart';
import 'package:multi_vendor/core/extensions/app_exception.dart';
import 'package:multi_vendor/core/service/image_crop_service.dart';
import 'package:multi_vendor/core/service/image_picker_service.dart';
import 'package:multi_vendor/core/utils/helper/file_helper.dart';

class ImageHandler {
  final ImagePickerService _picker;
  final ImageCropService _cropper;

  const ImageHandler(this._picker, this._cropper);

  Future<Either<AppException, String?>> pickImage({
    required ImagePickerSource source,
    double? maxSizeInMb,
  }) async {
    try {
      final file = await _picker.pickImage(source: source);
      if (maxSizeInMb != null) {
        await _validateImage(path: file?.path, maxSizeInMb: maxSizeInMb);
      }
      return right(file?.path);
    } catch (e) {
      return left(e.toAppException);
    }
  }

  Future<Either<AppException, String?>> cropImage(
    String path, {
    ImageCropType? type,
    String? title,
    double? maxSizeInMb,
  }) async {
    try {
      final cropped = await _cropper.cropImage(path, type: type, title: title);
      if (maxSizeInMb != null) {
        await _validateImage(path: cropped?.path, maxSizeInMb: maxSizeInMb);
      }
      return right(cropped?.path);
    } catch (e) {
      return left(e.toAppException);
    }
  }

  Future<void> _validateImage({String? path, required double maxSizeInMb}) async {
    final size = await FileHelper.sizeInMB(path);
    if (size > maxSizeInMb) {
      throw ImagePickerError(message: ImagePickerErrorMessage.sizeExceeded);
    }
    return;
  }
}
