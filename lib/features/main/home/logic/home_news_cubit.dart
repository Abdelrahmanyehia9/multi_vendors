import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor/core/cubit/base_state.dart';
import 'package:multi_vendor/core/extensions/safe_emit.dart';
import 'package:multi_vendor/features/main/home/data/repository/home_repository.dart';
import 'package:multi_vendor/features/news/data/model/news_model.dart';


class HomeNewsCubit extends Cubit<BaseState<List<NewsModel>>> {
  final HomeRepository _repository;
  HomeNewsCubit(this._repository) : super(const BaseState.initial());
  Future<void> getNews()async{
    safeEmit(const BaseState.loading());
    final result = await _repository.getNews();
    result.fold(
          (l) => safeEmit(BaseState.failure(l)),
          (r) {
        if(r.isEmpty) return safeEmit(const BaseState.empty());
        safeEmit(BaseState.success(r));
      },
    );
  }
}