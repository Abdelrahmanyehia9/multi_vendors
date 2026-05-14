import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:multi_vendor/core/cubit/base_bloc_consumer.dart';
import 'package:multi_vendor/core/extensions/data_type.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_appbar.dart';

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
    return Column(
      children: [
        SizedBox(
          height: 70.h,
          child: BaseAppBar(
            title: AppStrings.categories.tr(),
            showLeading: false,
          ),
        ),

        Expanded(
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
        ),
      ],
    );
  }

  @override
  void dispose() {
    selectedCategory.dispose();
    super.dispose();
  }
}
