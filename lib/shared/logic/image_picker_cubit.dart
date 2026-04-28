import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor/core/service/image_picker_service.dart';
import 'package:multi_vendor/shared/logic/image_picker_states.dart';

class ImageCubit extends Cubit<ImagePickerState>{
  ImageCubit() : super(ImagePickerInitial());
Future<void>picker(ImagePickerSource source)async{
}



}