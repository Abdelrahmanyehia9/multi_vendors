import 'package:easy_localization/easy_localization.dart';
import 'package:multi_vendor/core/extensions/data_type.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';
import 'package:multi_vendor/features/shop/product/logic/products_all_filters_cubit.dart';
import 'package:multi_vendor/features/shop/product/data/model/products_filters_model.dart';

extension ProductsFiltersEXT on ProductsFiltersModel {

  ProductsFiltersModel withoutEXCLUDES(List<ProductsFilters> exclude){
    return ProductsFiltersModel(
      categories: !exclude.contains(ProductsFilters.categories)
          ? null
          : categories,

      tags: !exclude.contains(ProductsFilters.tags)
          ? null
          : tags,


      vendors: !exclude.contains(ProductsFilters.vendor)
          ? null
          : vendors,

      stockAvailability: exclude.contains(ProductsFilters.stock)
          ? null
          : stockAvailability,

      ratingRange: !exclude.contains(ProductsFilters.rating)
          ? null
          : ratingRange,

      priceRange: !exclude.contains(ProductsFilters.price)
          ? null
          : priceRange,
    );
  }
  List<String> toChips(List<ProductsFilters>? exclude) {
    final ex = exclude ?? [];
    return [
      if (priceRange != null && !ex.contains(ProductsFilters.price)) ...[
        "${AppStrings.from.tr()} ${priceRange!.min.round().usdPrice}",
        "${AppStrings.to.tr()} ${priceRange!.max.round().usdPrice}",
      ],
      if (ratingRange != null && !ex.contains(ProductsFilters.rating))
        "${AppStrings.over.tr()} ${ratingRange!.min} ⭐",
      if (!categories.isNullOrEmpty &&
          !ex.contains(ProductsFilters.categories)) ...[
        for (var c in categories!) c.name.localized,
      ],
      if (!vendors.isNullOrEmpty &&
          !ex.contains(ProductsFilters.vendor)) ...[
        for (var v in vendors!) v.name.localized,
      ],
      if (!tags.isNullOrEmpty && !ex.contains(ProductsFilters.tags)) ...[
        for (var t in tags!) t.name,
      ],

      if (sortBy != null)
        sortBy!.type.text + (sortBy!.asc ? "↑" : "↓"),
    ];
  }
}