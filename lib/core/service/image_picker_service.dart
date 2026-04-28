import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

enum ImagePickerSource{
  camera ,
  gallery ;
  ImageSource get source {
    if(this == camera)return ImageSource.camera ;
    return ImageSource.gallery ;
  }
  String get text{
    if(this == camera) return "Camera"  ;
    return "Gallery" ;
  }
  IconData get icon{
    if(this == camera) return CupertinoIcons.photo_camera_solid ;
    return CupertinoIcons.photo ;
  }
}

final class ImagePickerService {
  const ImagePickerService();
   static final ImagePicker _picker = ImagePicker();

   Future<File?> pickImage({
    int imageQuality = 85,
    required ImagePickerSource source,
    String? prefix,
  }) async {
    try {
    final XFile? xFile = await _picker.pickImage(
      source: source.source,
      imageQuality: imageQuality,
    );
    if (xFile == null) return null;
    File file = File(xFile.path);
    final usedPrefix = (prefix == null || prefix.isEmpty)
        ? 'IMG'
        : prefix.toUpperCase();
    final ext = file.path.split('.').last;
    final newName = '${usedPrefix}_${DateTime.now().millisecondsSinceEpoch}.$ext';
    final newPath = '${file.parent.path}/$newName';
    File newFile = await file.rename(newPath);
    return newFile;
  }catch(e){
    return null;
  }

   }

}