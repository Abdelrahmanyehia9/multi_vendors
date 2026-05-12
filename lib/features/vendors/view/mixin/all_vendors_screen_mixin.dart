import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor/features/main/category/data/model/category_model.dart';
import 'package:multi_vendor/features/vendors/logic/vendors_by_category_cubit.dart';
import 'package:multi_vendor/features/vendors/view/all_vendors_screen.dart';
import 'package:flutter/material.dart';

mixin AllVendorsScreenMixin on State<AllVendorsScreen> {
  final selectedTagIndex = ValueNotifier<int>(-1);
  VendorsByCategoryCubit get vendorsCubit => context.read<VendorsByCategoryCubit>() ;



  Future<void>onCategoriesSuccess(List<CategoryModel> categories)async{
    if(categories.isNotEmpty)selectedTagIndex.value = 0;
    final id = categories[selectedTagIndex.value].id ??0;
    fetchVendorsByCategory(id);
    selectedTagIndex.addListener((){
      final id = categories[selectedTagIndex.value].id ??0;
      fetchVendorsByCategory(id);
    });
  }


  void fetchVendorsByCategory(int categoryId){
    vendorsCubit.getVendorsByXCategory(categoryId);

  }

  @override
  void dispose() {
    selectedTagIndex.dispose();
    super.dispose();
  }

}