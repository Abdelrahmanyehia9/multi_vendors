import 'package:multi_vendor/core/extensions/data_type.dart';
import 'package:multi_vendor/features/shop/product/logic/products_all_filters_cubit.dart';
import '../../../features/shop/product/data/model/products_filters_model.dart';

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
        "From ${priceRange!.min.round().usdPrice}",
        "To ${priceRange!.max.round().usdPrice}",
      ],
      if (ratingRange != null && !ex.contains(ProductsFilters.rating))
        "Over ${ratingRange!.min} ⭐",
      if (!categories.isNullOrEmpty &&
          !ex.contains(ProductsFilters.categories)) ...[
        for (var c in categories!) c.name,
      ],
      if (!vendors.isNullOrEmpty &&
          !ex.contains(ProductsFilters.vendor)) ...[
        for (var v in vendors!) v.name,
      ],
      if (!tags.isNullOrEmpty && !ex.contains(ProductsFilters.tags)) ...[
        for (var t in tags!) t.name,
      ],

      if (sortBy != null)
        sortBy!.type.text + (sortBy!.asc ? "↑" : "↓"),
    ];
  }
}