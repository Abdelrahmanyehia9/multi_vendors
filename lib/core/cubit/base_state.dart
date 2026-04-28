import 'package:equatable/equatable.dart';
import 'package:multi_vendor/core/errors/exceptions.dart';

enum StateStatus { initial, loading, success, failure, empty }

class BaseState<T> extends Equatable {
  final StateStatus status;
  final T? data;
  final AppException? error;
  final int? version;
  final int? id;

  const BaseState._internal({
    required this.status,
    this.data,
    this.error,
    this.version,
    this.id,
  }




  );

  const BaseState.initial() : this._internal(status: StateStatus.initial);

  const BaseState.loading() : this._internal(status: StateStatus.loading);

  const BaseState.empty({int? version}) : this._internal(status: StateStatus.empty ,version: version);

  const BaseState.success(T data)
      : this._internal(status: StateStatus.success, data: data);

  const BaseState.failure(AppException error)
      : this._internal(status: StateStatus.failure, error: error);


  BaseState<T> copyWith({
    StateStatus? status,
    T? data,
    AppException? error,
    int? version,
    int? id,
  }) {
    return BaseState._internal(
      status: status ?? this.status,
      data: data ?? this.data,
      error: error ?? this.error,
      version: version ?? this.version,
      id: id ?? this.id,
    );
  }
  BaseState<T> update() {
    return copyWith(
      version: DateTime.now().millisecondsSinceEpoch,
    );
  }


  bool get isInitial => status == StateStatus.initial;
  bool get isLoading => status == StateStatus.loading;
  bool get isSuccess => status == StateStatus.success;
  bool get isFailure => status == StateStatus.failure;
  bool get isEmpty => status == StateStatus.empty;

  @override
  List<Object?> get props => [status, data, error, version, id];
}