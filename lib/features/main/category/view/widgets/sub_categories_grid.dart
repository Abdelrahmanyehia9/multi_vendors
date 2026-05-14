import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/cubit/base_bloc_consumer.dart';
import 'package:multi_vendor/core/extensions/data_type.dart';
import 'package:multi_vendor/core/extensions/widget.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/theme/decorations.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';
import 'package:multi_vendor/core/widgets/app_states.dart';
import 'package:multi_vendor/features/main/category/data/model/category_model.dart';
import 'package:multi_vendor/features/main/category/logic/sub_categories_cubit.dart';
import 'package:multi_vendor/shared/view/widgets/app_search_bar.dart';
import 'package:multi_vendor/shared/view/widgets/photo_overlay.dart';

class SubCategoriesGrid extends StatelessWidget {
  final CategoryModel? mainCategory ;
  const SubCategoriesGrid({super.key,this.mainCategory});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12.h,
      children: [
        AppSearchbar(
          onQueryChanged: (q)=>context.read<SubCategoriesCubit>().onSearch(q),
          title: mainCategory==null?null: Row(
            children: [
              Text( "${AppStrings.search.tr()} ${AppStrings.iN.tr()}\t", style: TextStyles.labelSmall.copyWith(fontWeight: FontWeight.bold),),
              Text(mainCategory!.name.localized, style: TextStyles.labelSmall.copyWith(color: AppColors.primary),)
            ],
          ),
        ),
        Expanded(
          child: BaseBlocConsumer<SubCategoriesCubit,  List<CategoryModel>>(
            successBuilder:(s)=>_builder(s),
            loadingBuilder: ()=>_builder(List.generate(6, (_)=>CategoryModel.fake())),
            emptyBuilder: AppStates.empty,
            failureBuilder: AppStates.error,
          ),
        ),
      ],
    ).paddingHr(12);
  }

  Widget _builder(List<CategoryModel>categories)=>GridView.builder(
    itemCount: categories.length,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: 10.w,
      mainAxisSpacing: 10.h,
    ),
    itemBuilder: (_, i) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(Decorations.borderRadius12.r),
        child: PhotoOverlay(
          img: categories[i].img,
          titlePadding: 4,
          title: Row(
            children: [
              Expanded(
                child: Text(categories[i].name.localized,maxLines: 2, overflow: TextOverflow.ellipsis , style: TextStyles.labelSmall.copyWith(
                    color: AppColors.white
                ),),
              ),
              Text("(${categories[i].count})", style: TextStyles.labelSmall.copyWith(
                  color: AppColors.white
              ),)
            ],
          ),

        ),
      );
    },
  ) ;
}
