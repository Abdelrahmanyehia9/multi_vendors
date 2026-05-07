import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor/core/extensions/safe_emit.dart';
import 'package:multi_vendor/core/service/image_crop_service.dart';
import 'package:multi_vendor/core/service/image_picker_service.dart';
import 'package:multi_vendor/shared/data/repository/image_handler.dart';
import 'package:multi_vendor/shared/logic/image_handle_states.dart';

class ImageHandleCubit extends Cubit<ImageHandleStates>{
  final ImageHandler _handler ;
  final double? maxSizeInMb;
  ImageHandleCubit(this._handler,{this.maxSizeInMb}) : super(const ImageHandleInitial());
Future<void>picker(ImagePickerSource source)async{
  safeEmit(const ImageHandleLoading());
  final result  = await _handler.pickImage(source: source, maxSizeInMb: maxSizeInMb) ;
  result.fold((l) => safeEmit(ImageHandleError(l)), (r) {
    if(r==null) return reset() ;
    safeEmit(ImagePickedSuccess(r));
  }) ;
}
Future<void>crop(String path , {String? title, ImageCropType? type })async{
  final result  = await _handler.cropImage(path,maxSizeInMb: maxSizeInMb ,type: type, title: title??"Crop Image") ;
  result.fold((l) => safeEmit(ImageHandleError(l)), (r) {
    safeEmit(ImageCroppedSuccess(r));
  }) ;
}
void reset(){
  return safeEmit(const ImageHandleInitial()) ;
}



}