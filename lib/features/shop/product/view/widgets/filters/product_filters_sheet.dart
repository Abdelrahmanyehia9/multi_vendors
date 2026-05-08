library;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:multi_vendor/core/cubit/base_bloc_consumer.dart';
import 'package:multi_vendor/core/extensions/colors.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/extensions/data_type.dart';
import 'package:multi_vendor/core/extensions/date_time.dart';
import 'package:multi_vendor/core/extensions/navigation.dart';
import 'package:multi_vendor/core/extensions/widget.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/theme/decorations.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';
import 'package:multi_vendor/core/utils/mv_icons.dart';
import 'package:multi_vendor/core/widgets/buttons/app_button.dart';
import 'package:multi_vendor/core/widgets/app_click.dart';
import 'package:multi_vendor/features/main/home/data/models/product_tag_model.dart';
import 'package:multi_vendor/features/shop/product/data/model/products_filters_model.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/utils/feature_flags.dart';
import 'package:multi_vendor/core/widgets/gap.dart';
import 'package:multi_vendor/shared/data/models/category_model.dart';
import 'package:multi_vendor/shared/data/models/vendor_model.dart';
import 'package:multi_vendor/shared/view/widgets/app_chip.dart';
import 'package:multi_vendor/shared/view/widgets/app_expansion_tile.dart';
import 'package:multi_vendor/core/widgets/app_radion_button.dart';
import 'package:multi_vendor/shared/view/widgets/circular_box.dart';
import 'package:multi_vendor/shared/view/widgets/range_input.dart';
import 'package:multi_vendor/shared/view/widgets/section_header.dart';
import 'package:multi_vendor/features/shop/product/logic/products_all_filters_cubit.dart';
import 'package:multi_vendor/core/widgets/app_cached_network_image.dart';
import 'package:easy_debounce/easy_debounce.dart';

part 'stock_filters.dart';

part 'tags_filters.dart';
part 'category_filter_checkbox.dart';
part 'filter_item.dart';
part 'category_filter_mixin.dart';
part '../mixin/product_filters_sheet_mixin.dart';
part 'category_filters.dart';
part 'price_filters.dart';

part 'rating_filters.dart';

part 'vendor_filters.dart';

part 'base_filters.dart';

class ProductFiltersSheet extends StatefulWidget {
  const ProductFiltersSheet({super.key});

  @override
  State<ProductFiltersSheet> createState() => _ProductFiltersSheetState();
}

class _ProductFiltersSheetState extends State<ProductFiltersSheet>
    with _ProductFiltersSheetMixin {
  @override
  Widget build(BuildContext context) {
    return BaseBlocConsumer<ProductsAllFiltersCubit, ProductsFiltersModel>(
      successBuilder: _buildContent,
      loadingBuilder: () => _buildContent(ProductsFiltersModel.fake()),
    );
  }

  Widget _buildContent(ProductsFiltersModel f) {
    return DraggableScrollableSheet(
      minChildSize: 0.5,
      maxChildSize: 0.9,
      initialChildSize: 0.9,
      expand: false,
      builder: (_, controller) {
        return SingleChildScrollView(
          controller: controller,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 12.h,
            children: [
              Gap.small(),

              /// Header
              SectionHeader(
                title: AppStrings.filters.tr(),
                headerStyle: TextStyles.labelLarge,
                action: "Reset",
                hasAction: true,
                actionStyle: TextStyles.labelLarge,
                onActionTap: resetFilters,
              ),

              /// Categories
              if (_isVisible(f.categories, ProductsFilters.categories))
                ValueListenableBuilder(
                  valueListenable: _selectedCategories,
                  builder: (_, value, __) {
                    final selectedText = value.isNullOrEmpty
                        ? null
                        : value.map((e) => e.name.localized).join(", ");

                    return _FilterItem(
                      title: AppStrings.categories.tr(),
                      subtitle: selectedText,
                      child: _CategoryFilter(
                        items: f.categories!,
                        selected: _selectedCategories,
                      ),
                    );
                  },
                ),

              /// Price
              if (_isVisible(f.priceRange, ProductsFilters.price))
                _FilterItem(
                  title: AppStrings.price.tr(),
                  child: _PriceFilter(
                    priceRange: _priceRange,
                    availableRange: f.priceRange!.toRangeValues(),
                  ),
                ),

              /// Rating
              if (_isVisible(f.ratingRange, ProductsFilters.rating))
                _FilterItem(
                  title: AppStrings.rating.tr(),
                  child: _RatingFilter(
                    selectedRating: _selectedRating,
                    ratingRange: f.ratingRange!.toRangeValues(),
                  ),
                ),

              /// Vendors
              if (_isVisible(f.vendors, ProductsFilters.vendor) &&
                  FeatureFlags.multiVendor)
                _FilterItem(
                  title: AppStrings.vendor.tr(),
                  child: _VendorFilters(
                    items: f.vendors!,
                    selected: _selectedVendors,
                  ),
                ),

              /// Tags
              if (_isVisible(f.tags, ProductsFilters.tags) &&
                  FeatureFlags.shopByTags)
                _FilterItem(
                  title: AppStrings.tags.tr(),
                  child: _TagsFilters(
                    tags: f.tags!,
                    selectedTags: _selectedTags,
                  ),
                ),

              // /// Stock
              // if (_isVisible(StockAvailability.values, ProductsFilters.stock))
              //   _FilterItem(
              //     title: "Availability",
              //     initiallyExpanded: false,
              //     _StockFilters(
              //       items: StockAvailability.values,
              //       selected: _selectedStock,
              //     ),
              //   ),
              /// Button
              ValueListenableBuilder(
                valueListenable: _cubit.totalProducts,
                builder: (_, value, __) {
                  return AppButton(
                    text: "${AppStrings.see.tr()} ${value ?? ""} ${AppStrings.products.tr()}",
                    buttonSize: null,
                    onPressed: _onSubmit,
                  );
                },
              ),

              Gap.medium(),
            ],
          ).appPaddingHr,
        );
      },
    );
  }

  bool _isVisible(Object? value, ProductsFilters type) {
    final ex = _cubit.excludes;
    if (value == null) return false;
    if (value is List && value.isEmpty) return false;
    return !ex.contains(type);
  }

  void _onSubmit() {
    if (_filters != null) _cubit.setFilters(_filters!);
    context.pop(_filters);
  }
}

// if (!f.attributes.isNullOrEmpty&&_selectedVariants.length == f.attributes!.groupedVariants.length)
//   _FilterItem(
//     title: "Attributes",
//     showTrailing: false,
//     _VariantFilters(
//       groupedVariants: f.attributes!.groupedVariants,
//       activeIndexes: _selectedVariants,
//     ),
//   ),
