// ignore_for_file: non_constant_identifier_names
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:multi_vendor/core/utils/remote_database_constants.dart';

class DatabaseService {
  final SupabaseClient _supabase;
  const DatabaseService(this._supabase);
  static const _defaultTimeOut = Duration(seconds: 30);

  Future<Map<String, dynamic>> CREATE({
    required String table,
    required Map<String, dynamic> data,
    Duration? timeout,
  }) async {
    return await _supabase.from(table).insert(data).select().single().timeout(timeout ?? _defaultTimeOut);
  }

  Future<Map<String, dynamic>> INSERT({
    required String table,
    required Map<String, dynamic> data,
    String? select,
    Duration? timeout,
  }) async {
    final Map<String, dynamic> response = await _supabase.from(table).insert(data).select(select ?? "*").maybeSingle().timeout(timeout ?? _defaultTimeOut) ?? {};
    return response;
  }

  Future<List<Map<String, dynamic>>> UPSERT_MANY({
    required String table,
    required List<Map<String, dynamic>> data,
    String? select,
    Duration? timeout,
  }) async {
    final List<Map<String, dynamic>> response = await _supabase.from(table).upsert(data).select(select ?? "*").timeout(timeout ?? _defaultTimeOut);
    return response;
  }

  Future<List<Map<String, dynamic>>> GET({
    required String table,
    String? select,
    PostgrestTransformBuilder<PostgrestList> Function(PostgrestFilterBuilder<PostgrestList>)? filter,
    Duration? timeout,
  }) async {
    PostgrestFilterBuilder<PostgrestList> query = _supabase.from(table).select(select ?? "*");
    final result = List<Map<String, dynamic>>.from(
      await (filter != null ? filter(query) : query).timeout(timeout ?? _defaultTimeOut),
    );
    return result;
  }

  Future<Map<String, dynamic>> GET_SINGLE({
    required String table,
    required PostgrestFilterBuilder<PostgrestList> Function(PostgrestFilterBuilder<PostgrestList>) filter,
    String? select,
    Duration? timeout,
  }) async {
    PostgrestFilterBuilder<PostgrestList> query = _supabase.from(table).select(select ?? "*");
    return await filter(query).maybeSingle().timeout(timeout ?? _defaultTimeOut) ?? {};
  }

  Future<Map<String, dynamic>> UPDATE({
    required String table,
    required dynamic id,
    PostgrestFilterBuilder<PostgrestList> Function(PostgrestFilterBuilder<PostgrestList>)? filter,
    required Map<String, dynamic>? data,
    String idColumn = 'id',
    Duration? timeout,
  }) async {
    if (data == null) return {};
    return await _supabase.from(table).update(data).eq(idColumn, id).select().single().timeout(timeout ?? _defaultTimeOut);
  }

  Future<List<Map<String, dynamic>>> UPDATE_MANY({
    required String table,
    required Map<String, dynamic> data,
    PostgrestFilterBuilder<dynamic> Function(PostgrestFilterBuilder<dynamic>)? filter,
    Duration? timeout,
  }) async {
    if (data.isEmpty) return [];
    if (filter == null) {
      return await _supabase.from(table).update(data).select().timeout(timeout ?? _defaultTimeOut);
    }
    final result = await filter(
      _supabase.from(table).update(data),
    ).select().timeout(timeout ?? _defaultTimeOut);

    return List<Map<String, dynamic>>.from(result);
  }

  Future<Map<String, dynamic>> UPSERT({
    required String table,
    required Map<String, dynamic> data,
    PostgrestTransformBuilder<PostgrestList> Function(PostgrestTransformBuilder<PostgrestList>)? filter,
    Duration? timeout,
  }) async {
    var query = _supabase.from(table).upsert(data).select();
    final result = filter != null ? filter(query) : query;
    final response = await result.maybeSingle().timeout(timeout ?? _defaultTimeOut);
    return response ?? {};
  }

  Future<List<Map<String, dynamic>>> UPDATE_WHERE({
    required String table,
    required Map<String, dynamic> data,
    required PostgrestFilterBuilder<dynamic> Function(PostgrestFilterBuilder<dynamic>) filter,
    Duration? timeout,
  }) async {
    PostgrestFilterBuilder<dynamic> query = _supabase.from(table).update(data);
    query = filter(query);
    return List<Map<String, dynamic>>.from(await query.select().timeout(timeout ?? _defaultTimeOut));
  }

  Future<List<Map<String, dynamic>>> UPSERT_WHERE({
    required String table,
    required Map<String, dynamic> data,
    required PostgrestFilterBuilder<dynamic> Function(PostgrestFilterBuilder<dynamic>) filter,
    Duration? timeout,
  }) async {
    PostgrestFilterBuilder<dynamic> query = _supabase.from(table).upsert(data);
    query = filter(query);
    return List<Map<String, dynamic>>.from(await query.select().timeout(timeout ?? _defaultTimeOut));
  }

  Future<dynamic> RPC({
    required String function,
    Map<String, dynamic>? params,
    Duration? timeout,
  }) async {
    final response = await _supabase.rpc(function, params: params).timeout(timeout ?? _defaultTimeOut);
    return response;
  }

  Future<void> DELETE({
    required String table,
    required dynamic id,
    String idColumn = RemoteDatabaseConstants.id_column,
    Duration? timeout,
  }) async {
    await _supabase.from(table).delete().eq(idColumn, id).timeout(timeout ?? _defaultTimeOut);
  }

  Future<void> DELETE_WHERE({
    required String table,
    required PostgrestFilterBuilder<dynamic> Function(PostgrestFilterBuilder<dynamic>) filter,
    Duration? timeout,
  }) async {
    PostgrestFilterBuilder<dynamic> query = _supabase.from(table).delete();
    await filter(query).timeout(timeout ?? _defaultTimeOut);
  }

  Future<int> COUNT({
    required String table,
    PostgrestFilterBuilder<PostgrestList> Function(PostgrestFilterBuilder<PostgrestList>)? filter,
    Duration? timeout,
  }) async {
    var query = _supabase.from(table).select();
    if (filter != null) {
      query = filter(query);
    }
    final response = await query.count().timeout(timeout ?? _defaultTimeOut);
    return response.count;
  }
}