import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor/core/cubit/base_state.dart';
import 'package:multi_vendor/core/extensions/data_type.dart';
import 'package:multi_vendor/core/extensions/safe_emit.dart';
import 'package:multi_vendor/features/news/data/repository/news_repository.dart';
import 'package:multi_vendor/features/news/data/model/news_model.dart';


class NewsCubit extends Cubit<BaseState<List<NewsModel>>> {
  final NewsRepository _repository ;
  NewsCubit(this._repository) : super(const BaseState.initial());
  String? _lastQuery ='';

  Future<void> getAllNews()async{
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
  Future<void> searchNews([String? search])async{
    if (search.isNullOrEmpty||search == _lastQuery) return;
    EasyDebounce.debounce('search', const Duration(milliseconds: 500), () async{
      _lastQuery = search;
      safeEmit(const BaseState.loading());
      final result = await _repository.getNews(query: search);
      result.fold(
            (l) => safeEmit(BaseState.failure(l)),
            (r) {
              if(r.isEmpty) return safeEmit(const BaseState.empty());
              safeEmit(BaseState.success(r));
            }
        ,
      );
    });
  }
  @override
  Future<void> close() {
    EasyDebounce.cancel('search');
    return super.close();
  }


}