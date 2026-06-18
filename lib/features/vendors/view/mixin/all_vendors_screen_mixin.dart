import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor/features/main/category/data/model/category_model.dart';
import 'package:multi_vendor/features/vendors/logic/vendors_by_category_cubit.dart';
import 'package:multi_vendor/features/vendors/view/all_vendors_screen.dart';
import 'package:flutter/material.dart';

mixin AllVendorsScreenMixin on State<AllVendorsScreen> {
  final selectedTagIndex = ValueNotifier<int>(-1);
  List<CategoryModel> _categories = [];

  VendorsByCategoryCubit get vendorsCubit => context.read<VendorsByCategoryCubit>();

  Future<void> onCategoriesSuccess(List<CategoryModel> categories) async {
    _categories = categories;
    selectedTagIndex.removeListener(_onSelectedTagChanged);
    selectedTagIndex.addListener(_onSelectedTagChanged);

    _onSelectedTagChanged();
  }

  void _onSelectedTagChanged() {
    final index = selectedTagIndex.value;
    final id = index == -1 ? null : _categories[index].id;
    fetchVendorsByCategory(id);
  }

  void fetchVendorsByCategory(int? categoryId) {
    vendorsCubit.getVendorsByXCategory(categoryId);
  }

  @override
  void dispose() {
    selectedTagIndex.removeListener(_onSelectedTagChanged);
    selectedTagIndex.dispose();
    super.dispose();
  }
}