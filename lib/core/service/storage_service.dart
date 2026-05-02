import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';

final class StorageService {
  final SupabaseClient _supabase;

  const StorageService(this._supabase);

  Future<String> uploadAndGetUrl(
      File file, {
        required String bucketName,
        required String folderName,
        String prefix = "IMG",
        bool upsert = true,
      }) async
  {
    final fileName = "$prefix${DateTime.now().millisecondsSinceEpoch}";
    final filePath = '$folderName/$fileName';

    await _supabase.storage
        .from(bucketName)
        .upload(filePath, file, fileOptions: FileOptions(upsert: upsert));

    final url = _supabase.storage
        .from(bucketName)
        .getPublicUrl(filePath);

    return url;
  }
}
