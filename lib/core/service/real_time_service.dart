import 'package:supabase_flutter/supabase_flutter.dart';

typedef RealtimeCallback = void Function(PostgresChangePayload payload);

final class RealtimeService {
  final SupabaseClient _client;
  final Map<String, RealtimeChannel> _channels = {};

  RealtimeService(this._client);

  void subscribeToTable({
    required String channelName,
    required String schema,
    required String table,
    required RealtimeCallback callback,
    PostgresChangeEvent event = PostgresChangeEvent.all,
    PostgresChangeFilter? filter,
  }) {
    if (_channels.containsKey(channelName)) {
      unsubscribe(channelName);
    }

    try {
      final channel = _client
          .channel(channelName)
          .onPostgresChanges(
        event: event,
        schema: schema,
        table: table,
        filter: filter,
        callback: callback,
      )
          .subscribe();

      _channels[channelName] = channel;
    } catch (e) {
      rethrow;
    }
  }

  void unsubscribe(String channelName) {
    final channel = _channels.remove(channelName);
    if (channel != null) {
      _client.removeChannel(channel);
    }
  }

  void unsubscribeAll() {
    for (var channel in _channels.values) {
      _client.removeChannel(channel);
    }
    _channels.clear();
  }

  bool isSubscribed(String channelName) {
    return _channels.containsKey(channelName);
  }

  int get activeChannelsCount => _channels.length;

  void dispose() {
    unsubscribeAll();
  }
}
