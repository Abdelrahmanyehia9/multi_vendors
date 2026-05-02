import 'dart:io';

class FileHelper{
  const FileHelper._();


 static Future<double> sizeInMB(String? path) async {
    if(path == null) return 0;
    final file = File(path);
    final sizeInBytes = await file.length();
    double sizeInMB = sizeInBytes / (1024 * 1024);
    return double.parse(sizeInMB.toStringAsFixed(2));
  }

}