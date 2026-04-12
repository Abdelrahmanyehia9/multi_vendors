library;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:multi_vendor/core/cubit/base_bloc_consumer.dart';
import 'package:multi_vendor/core/enum/stock_availability.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/extensions/data_type.dart';
import 'package:multi_vendor/core/extensions/date_time.dart';
import 'package:multi_vendor/core/extensions/navigation.dart';
import 'package:multi_vendor/core/extensions/widget.dart';
import 'package:multi_vendor/core/models/base_category_model.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/theme/decorations.dart';
import 'package:multi_vendor/core/widgets/app_button.dart';
import 'package:multi_vendor/core/widgets/app_chip.dart';
import 'package:multi_vendor/core/widgets/app_click.dart';
import 'package:multi_vendor/core/widgets/section_header.dart';
import 'package:multi_vendor/features/main/home/data/models/product_tag_model.dart';
import 'package:multi_vendor/features/shop/product/data/model/products_filters_model.dart';
import '../../../../../../core/theme/text_styles.dart';
import '../../../../../../core/widgets/app_radion_button.dart';
import '../../../../../../core/widgets/gap.dart';
import '../../../../../../core/widgets/range_input.dart';
import '../../../logic/products_all_filters_cubit.dart';
import 'package:multi_vendor/core/widgets/app_cached_network_image.dart';
import 'package:multi_vendor/core/widgets/circular_box.dart';
import '../../../../../../core/models/vendor_model.dart';
import 'package:easy_debounce/easy_debounce.dart';
part 'stock_filters.dart';
part 'tags_filters.dart';
part 'filter_item.dart';
part 'product_filters_sheet_mixin.dart';
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
      successBuilder: _builder,
      loadingBuilder: () => _builder(ProductsFiltersModel.fake()),
    );
  }

  Widget _builder(ProductsFiltersModel f) {
    return DraggableScrollableSheet(
      minChildSize: 0.5,
      maxChildSize: 0.9,
      initialChildSize: 0.9,
      expand: false,
      builder:(_,c) {
        final exclude = _cubit.excludeFilters;
        return SingleChildScrollView(
        controller: c,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12.h,
          children: [
            Gap.small(),
            SectionHeader(
             title: "Filters",
              headerStyle: TextStyles.headline3,
              action: "Reset",
              hasAction: true,
              actionStyle: TextStyles.labelLarge,
              onActionTap: resetFilters,
            ),
            if (!f.categories.isNullOrEmpty&&!exclude.contains(ProductsFilters.categories))
              ValueListenableBuilder(
                     valueListenable: _selectedCategories,
                     builder: (context, value, child) {
                       final String? selectedText = value.isNullOrEmpty?null:  value.map((e) => e.name).join(", ");
                       return _FilterItem(
                         title: "Categories",
                            subtitle: selectedText,
                            _CategoryFilter(items: f.categories!,selected: _selectedCategories));
                     }
                   ),
            if (f.priceRange!=null &&!exclude.contains(ProductsFilters.price))
            _FilterItem(
             _PriceFilter(
                priceRange: _priceRange,
                availableRange: f.priceRange!.toRangeValues(),
              ),
              title: "Price",
            ),
            if (f.ratingRange!=null &&!exclude.contains(ProductsFilters.rating))
            _FilterItem(
               _RatingFilter(
                 selectedRating: _selectedRating,
                 ratingRange: f.ratingRange!.toRangeValues(),
              ),
              title: "Rating",
            ),
            if (!f.vendors.isNullOrEmpty&&!exclude.contains(ProductsFilters.vendor))
              _FilterItem(
                 _VendorFilters(
                  items: f.vendors!,
                  selected: _selectedVendors,
                ),
                title: "Vendor",
              ),
            if (!f.tags.isNullOrEmpty&&!exclude.contains(ProductsFilters.tags))
              _FilterItem(
                title: "Tags",
                initiallyExpanded: false,
                _TagsFilters(tags: f.tags!, selectedTags: _selectedTags),
              ),
            // if (!f.attributes.isNullOrEmpty&&_selectedVariants.length == f.attributes!.groupedVariants.length)
            //   _FilterItem(
            //     title: "Attributes",
            //     showTrailing: false,
            //     _VariantFilters(
            //       groupedVariants: f.attributes!.groupedVariants,
            //       activeIndexes: _selectedVariants,
            //     ),
            //   ),
              if(!f.stockAvailability.isNullOrEmpty&&!exclude.contains(ProductsFilters.stock))
              _FilterItem(
                  title: "Availability",
                  initiallyExpanded: false,
                  _StockFilters(items: f.stockAvailability!, selected: _selectedStock)),
            ValueListenableBuilder(
              valueListenable: _cubit.totalProducts,
              builder: (context, value, child) {
                return AppButton(
                    text: "See ${value??""} product/s",
                    buttonSize: null,
                    onPressed:()=> context.pop(_filters),
                  );
              }
            ),
            Gap.medium(),
          ],
        ).appPaddingHr,
      );
      },
    );
  }
}
