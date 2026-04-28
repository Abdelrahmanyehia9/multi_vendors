import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';

final class StorageService {
  final SupabaseClient _supabase;

  const StorageService(this._supabase);

  Future<String> uploadAndGetUrl(
    File file, {
    required String bucketName,
    required String folderName,
    bool upsert = true,
  }) async {
    final fileName = file.path.split('/').last;
    final filePath = '$folderName/$fileName';
    await _supabase.storage
        .from(bucketName)
        .upload(filePath, file, fileOptions: FileOptions(upsert: upsert));
    final url =await _supabase.storage
        .from(bucketName)
        .createSignedUploadUrl(filePath);
    return url.signedUrl;
  }
}
