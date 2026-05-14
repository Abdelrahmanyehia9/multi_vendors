import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor/core/cubit/base_state.dart';
import 'package:multi_vendor/core/extensions/data_type.dart';
import 'package:multi_vendor/core/extensions/safe_emit.dart';
import 'package:multi_vendor/features/main/category/data/repository/category_repository.dart';
import 'package:multi_vendor/features/main/category/data/model/category_model.dart';
import 'package:multi_vendor/shared/view/mixin/cubit_search.dart';

class SubCategoriesCubit extends Cubit<BaseState<List<CategoryModel>>> with LocalCubitSearch<CategoryModel>{
  final CategoryRepository _repository;
  SubCategoriesCubit(this._repository) : super(const BaseState.initial());
List<CategoryModel> _subcategories = [] ;


  Future<void>getSubCategories({int? parent})async{
    safeEmit(const BaseState.loading());
    final result = await _repository.getSubCategories(parentId: parent);
    result.fold(
          (l) => safeEmit(BaseState.failure(l)),
          (r) {
            _subcategories = r ;
            if(r.isEmpty) return safeEmit(const BaseState.empty()) ;
        safeEmit(BaseState.success(r));
      },
    );

  }

  @override
  // TODO: implement items
  List<CategoryModel> get items => _subcategories;

  @override
  // TODO: implement searchFields
  List<String Function(CategoryModel)> get searchFields => [(e)=>e.name.localized, (e)=>e.description?.localized??''];


}