

import 'package:multi_vendor/core/errors/exceptions.dart';

abstract class ImageHandleStates {
  const ImageHandleStates();
}

class ImageHandleInitial extends ImageHandleStates {
  const ImageHandleInitial();
}
class ImageHandleLoading extends ImageHandleStates {
  const ImageHandleLoading();
}
class ImagePickedSuccess extends ImageHandleStates{
  final String path;
  const ImagePickedSuccess(this.path);

}
class ImageCroppedSuccess extends ImageHandleStates{
  final String path;
  const ImageCroppedSuccess(this.path);
}
class ImageHandleError extends ImageHandleStates{
  final AppException exception;
  const ImageHandleError(this.exception);
}
