// ignore_for_file: non_constant_identifier_names
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:multi_vendor/core/utils/remote_database_constants.dart';

class DatabaseService {
  final SupabaseClient _supabase;
  const DatabaseService(this._supabase);

  Future<Map<String, dynamic>> CREATE({
    required String table,
    required Map<String, dynamic> data,
  }) async {
    return await _supabase.from(table).insert(data).select().single();
  }

  Future<Map<String, dynamic>>INSERT({required String table , required Map<String, dynamic> data, String? select})async{
    final Map<String, dynamic> response  =await _supabase.from(table).insert(data).select(select??"*").maybeSingle() ?? {}  ;
    return response;
  }

  Future<List<Map<String, dynamic>>> GET({
    required String table,
    String? select,
    PostgrestTransformBuilder<PostgrestList> Function(PostgrestFilterBuilder<PostgrestList>)? filter,
  }) async {
    PostgrestFilterBuilder<PostgrestList> query = _supabase.from(table).select(select ?? "*");
    final result = List<Map<String, dynamic>>.from(
      await (filter != null ? filter(query) : query),
    );
    return result;
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
     PostgrestFilterBuilder<PostgrestList> Function(PostgrestFilterBuilder<PostgrestList>)? filter,
    required Map<String, dynamic> data,
    String idColumn = 'id',
  }) async {
    return await _supabase.from(table).update(data).eq(idColumn, id).select().single();
  }

  Future<Map<String, dynamic>> UPSERT({
    required String table,
    required Map<String, dynamic> data,
    PostgrestTransformBuilder<PostgrestList> Function(
        PostgrestTransformBuilder<PostgrestList>,
        )? filter,
  }) async {
    var query = _supabase.from(table).upsert(data).select();
    final result = filter != null ? filter(query) : query;
    final response = await result.maybeSingle();
    return response ?? {};
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
  Future<List<Map<String, dynamic>>> UPSERT_WHERE({
    required String table,
    required Map<String, dynamic> data,
    required PostgrestFilterBuilder<dynamic> Function(PostgrestFilterBuilder<dynamic>) filter,
  }) async {
    PostgrestFilterBuilder<dynamic> query = _supabase.from(table).upsert(data);
    query = filter(query);
    return List<Map<String, dynamic>>.from(await query.select());
  }



  Future<dynamic>RPC({required String function,  Map<String, dynamic>? params})async{
  final  response = await _supabase.rpc(function, params: params) ;
  return response;
  }

  Future<void> DELETE({
    required String table,
    required dynamic id,
    String idColumn = RemoteDatabaseConstants.id_column,
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