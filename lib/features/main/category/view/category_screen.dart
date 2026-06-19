import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor/core/cubit/base_bloc_consumer.dart';
import 'package:multi_vendor/core/extensions/data_type.dart';
import 'package:multi_vendor/core/widgets/app_states.dart';
import 'package:multi_vendor/features/main/category/data/model/category_model.dart';
import 'package:multi_vendor/features/main/category/logic/main_categories_cubit.dart';
import 'package:multi_vendor/features/main/category/logic/sub_categories_cubit.dart';
import 'package:multi_vendor/features/main/category/view/widgets/category_side_bar.dart';
import 'package:multi_vendor/features/main/category/view/widgets/sub_categories_grid.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final ValueNotifier<CategoryModel?> selectedCategory = ValueNotifier(null);

  @override
  void initState() {
    super.initState();
    selectedCategory.addListener(() {
      context.read<SubCategoriesCubit>().getSubCategories(
        parent: selectedCategory.value?.id,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: ()async=> _onRefresh(context),
      child: Row(
        children: [
          /// ─── Main Categories ───
          BaseBlocConsumer<MainCategoriesCubit, List<CategoryModel>>(
            onSuccess: (data) {
              if (!data.isNullOrEmpty && selectedCategory.value == null) {
                selectedCategory.value = data!.first;
              }
            },
            successBuilder: (data) => CategorySideBar(
              selectedMainCategory: selectedCategory,
              categories: data,
            ),
            failureBuilder: AppStates.error,
            loadingBuilder: () => CategorySideBar(
              selectedMainCategory: selectedCategory,
              categories: List.generate(4, (_) => CategoryModel.fake()),
            ),
          ),
          /// ─── Sub Categories ───
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: selectedCategory,
              builder: (_, value, __) {
                return  SubCategoriesGrid(
                    mainCategory: value,
                  ) ;
              },
            ),
          ),
        ],
      ),
    );

  }

  Future<void> _onRefresh(BuildContext context)async{
    context.read<MainCategoriesCubit>().getCategories();
    context.read<SubCategoriesCubit>().getSubCategories(
      parent: selectedCategory.value?.id,
    );
  }
  @override
  void dispose() {
    selectedCategory.dispose();
    super.dispose();
  }
}
