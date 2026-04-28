import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor/core/cubit/base_state.dart';
import 'package:multi_vendor/core/extensions/safe_emit.dart';
import 'package:multi_vendor/features/shop/product/data/repository/product_repository.dart';
import 'package:multi_vendor/shared/view/mixin/cubit_search.dart';
import 'package:multi_vendor/features/main/home/data/models/product_tag_model.dart';

class ProductAllTagsCubit extends Cubit<BaseState<List<ProductTagModel>>> with LocalCubitSearch<ProductTagModel> {
  final ProductRepository _repository ;
  ProductAllTagsCubit(this._repository) : super(const BaseState.initial());
  final List<ProductTagModel>_allTags = [];



  Future<void>getAllTags()async{
    safeEmit(const BaseState.loading());
    final result = await _repository.getAllTags() ;
    result.fold(
      (l) => safeEmit(BaseState.failure(l)),
      (r) {
        if(r.isEmpty) return safeEmit(const BaseState.empty());
        _allTags.addAll(r);
        safeEmit(BaseState.success(r));
      },
    );
  }

  @override
  List<ProductTagModel> get items => _allTags;

  @override
  List<String Function(ProductTagModel)> get searchFields => [ (e) => e.name ];

}