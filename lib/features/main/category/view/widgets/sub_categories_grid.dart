import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/cubit/base_bloc_consumer.dart';
import 'package:multi_vendor/core/extensions/colors.dart';
import 'package:multi_vendor/core/extensions/data_type.dart';
import 'package:multi_vendor/core/extensions/navigation.dart';
import 'package:multi_vendor/core/extensions/widget.dart';
import 'package:multi_vendor/core/routes/routes.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/theme/decorations.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';
import 'package:multi_vendor/core/utils/mv_icons.dart';
import 'package:multi_vendor/core/widgets/app_click.dart';
import 'package:multi_vendor/core/widgets/app_states.dart';
import 'package:multi_vendor/features/main/category/data/model/category_model.dart';
import 'package:multi_vendor/features/main/category/logic/sub_categories_cubit.dart';
import 'package:multi_vendor/features/shop/product/data/model/products_filters_model.dart';
import 'package:multi_vendor/features/shop/product/view/all_products_screen.dart';
import 'package:multi_vendor/shared/view/widgets/app_search_bar.dart';
import 'package:multi_vendor/shared/view/widgets/photo_overlay.dart';

class SubCategoriesGrid extends StatelessWidget {
  final CategoryModel? mainCategory;
  const SubCategoriesGrid({super.key, this.mainCategory});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12.h,
      children: [
        if(mainCategory != null)
        AppSearchbar(
          onQueryChanged: context.read<SubCategoriesCubit>().onSearch,
          title: mainCategory == null
              ? null
              : Row(
            children: [
              Text(
                "${AppStrings.search.tr()} ${AppStrings.iN.tr()} ",
                style: TextStyles.labelMedium.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                mainCategory!.name.localized,
                style: TextStyles.labelMedium.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: BaseBlocConsumer<SubCategoriesCubit, List<CategoryModel>>(
            successBuilder: (s) => _grid(context, s),
            loadingBuilder: () =>
                _grid(context, List.generate(6, (_) => CategoryModel.fake())),
            emptyBuilder: AppStates.empty,
            failureBuilder: AppStates.error,
          ),
        ),
      ],
    ).paddingHr(4);
  }

  Widget _grid(BuildContext context, List<CategoryModel> categories) {
    return GridView.builder(
      itemCount: categories.length + (mainCategory != null ? 1 : 0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10.w,
        mainAxisSpacing: 10.h,
      ),
      itemBuilder: (_, i) {
        final isSeeAll = mainCategory != null && i == categories.length;
        if (isSeeAll) {
          return _seeAllButton(
                () => _openProducts(context, [mainCategory!, ...categories]),
          );
        }
        final cat = categories[i];
        return AppClick(
          onTap: () => _openProducts(context, [cat]),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(
              Decorations.borderRadius16.r,
            ),
            child: PhotoOverlay(
              img: cat.img,
              titlePadding: 4,
              title: Text(
                "${cat.name.localized} (${cat.count})",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyles.labelSmall.copyWith(
                  color: AppColors.white,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _seeAllButton(VoidCallback onTap) {
    return AppClick(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8.r),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(Decorations.borderRadius16.r),
          image: mainCategory?.img == null
              ? null
              : DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(mainCategory!.img!),
            colorFilter: ColorFilter.mode(
              AppColors.primary.withAppOpacity(.9),
              BlendMode.srcATop,
            ),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                "${AppStrings.viewAll.tr().toUpperCase()} "
                    "${AppStrings.iN.tr().toUpperCase()}"
                    "\n"
                    "${mainCategory!.name.localized.toUpperCase()}",
                style: TextStyles.labelSmall.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeightHelper.bold,
                ),
              ),
            ),
            Icon(
              MvIcons.arrowForward,
              color: AppColors.white,
              size: 16.r,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _openProducts(
      BuildContext context,
      List<CategoryModel> categories,
      ) {
    return context.pushNamed(
      Routes.products,
      arguments: ProductsScreenArgs(
        initialFilters: ProductsFiltersModel(categories: categories),
      ),
    );
  }
}