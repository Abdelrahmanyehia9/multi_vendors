// ignore_for_file: non_constant_identifier_names
import 'package:supabase_flutter/supabase_flutter.dart';

class DatabaseService {
  final SupabaseClient _supabase;
  const DatabaseService(this._supabase);

  Future<Map<String, dynamic>> CREATE({
    required String table,
    required Map<String, dynamic> data,
  }) async {
    return await _supabase.from(table).insert(data).select().single();
  }

  Future<List<Map<String, dynamic>>> GET({
    required String table,
    String? select,
    PostgrestFilterBuilder<PostgrestList> Function(PostgrestFilterBuilder<PostgrestList>)? filter,
  }) async {
    PostgrestFilterBuilder<PostgrestList> query = _supabase.from(table).select(select ?? "*");
    if (filter != null) query = filter(query);
    return List<Map<String, dynamic>>.from(await query);
  }

  Future<Map<String, dynamic>> GET_SINGLE({
    required String table,
    required PostgrestFilterBuilder<PostgrestList> Function(PostgrestFilterBuilder<PostgrestList>) filter,
    String? select,
  }) async {
    PostgrestFilterBuilder<PostgrestList> query = _supabase.from(table).select(select ?? "*");
    return await filter(query).maybeSingle() ?? {};
  }

  Future<Map<String, dynamic>> UPDATE({
    required String table,
    required dynamic id,
    required Map<String, dynamic> data,
    String idColumn = 'id',
  }) async {
    return await _supabase.from(table).update(data).eq(idColumn, id).select().single();
  }

  Future<List<Map<String, dynamic>>> UPDATE_WHERE({
    required String table,
    required Map<String, dynamic> data,
    required PostgrestFilterBuilder<dynamic> Function(PostgrestFilterBuilder<dynamic>) filter,
  }) async {
    PostgrestFilterBuilder<dynamic> query = _supabase.from(table).update(data);
    query = filter(query);
    return List<Map<String, dynamic>>.from(await query.select());
  }

  Future<void> DELETE({
    required String table,
    required dynamic id,
    String idColumn = 'id',
  }) async {
    await _supabase.from(table).delete().eq(idColumn, id);
  }

  Future<void> DELETE_WHERE({
    required String table,
    required PostgrestFilterBuilder<dynamic> Function(PostgrestFilterBuilder<dynamic>) filter,
  }) async {
    PostgrestFilterBuilder<dynamic> query = _supabase.from(table).delete();
    await filter(query);
  }
}