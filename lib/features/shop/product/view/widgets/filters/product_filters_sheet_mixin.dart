part of 'product_filters_sheet.dart';

mixin _ProductFiltersSheetMixin on State<ProductFiltersSheet> {
  final ValueNotifier<RangeValues?> _priceRange = ValueNotifier(null);
  final ValueNotifier<RangeValues?> _selectedRating = ValueNotifier(null);
  final ValueNotifier<List<VendorModel>> _selectedVendors = ValueNotifier([]);
  final ValueNotifier<List<ProductTagModel>> _selectedTags = ValueNotifier([]);
  final ValueNotifier<List<CategoryModel>> _selectedCategories = ValueNotifier([]);
  final ValueNotifier<List<StockAvailability>> _selectedStock = ValueNotifier([]);
   ProductsFiltersModel? _filters;
  ProductsAllFiltersCubit get _cubit => context.read<ProductsAllFiltersCubit>();

  @override
  void initState() {
    _setupInitialFilters();
    super.initState();
  }

  void _setupInitialFilters() {
    final p = _cubit.selectedFilters;
    if (p != null) {
      if (!p.categories.isNullOrEmpty) _selectedCategories.value = p.categories!;
      if (!p.tags.isNullOrEmpty) _selectedTags.value = p.tags!;
      if (!p.vendors.isNullOrEmpty) _selectedVendors.value = p.vendors!;
      if (!p.stockAvailability.isNullOrEmpty) _selectedStock.value = p.stockAvailability!;
      if (p.priceRange != null) _priceRange.value = p.priceRange!.toRangeValues();
      if (p.ratingRange != null) _selectedRating.value = p.ratingRange!.toRangeValues();
    }

    for (final notifier in notifiers) {
      notifier.addListener(_getFiltersByFilters);
    }
  }
  List<ValueNotifier> get notifiers => [
    _selectedStock,
    _selectedVendors,
    _selectedTags,
    _selectedCategories,
    _selectedRating,
    _priceRange,
  ];

  Future<void> _onSet() async {
      _filters = ProductsFiltersModel(
        categories: _selectedCategories.value,
        tags: _selectedTags.value,
        vendors: _selectedVendors.value,
        stockAvailability: _selectedStock.value,
        priceRange: _priceRange.value?.toRangeModel,
        ratingRange: _selectedRating.value?.toRangeModel,
        sortBy: _cubit.selectedFilters?.sortBy
      );
  }

  void _onSubmit() {
    if (_filters != null) _cubit.setFilters(_filters!);
    context.pop(_filters);
  }
  Future<void> _getFiltersByFilters() async {
    EasyDebounce.debounce(
      'filter_change',
      const Duration(milliseconds: 600),
          () async {
        context.loaderOverlay.show();
        _onSet();
        await _cubit.getCountByFilters(_filters);
        if (mounted) context.loaderOverlay.hide();
      },
    );
  }

  void resetFilters() {
  if(!_cubit.excludes.contains(ProductsFilters.price))  _priceRange.value = null;
  if(!_cubit.excludes.contains(ProductsFilters.rating))  _selectedRating.value = null;
  if(!_cubit.excludes.contains(ProductsFilters.categories))  _selectedCategories.value = [];
  if(!_cubit.excludes.contains(ProductsFilters.tags))  _selectedTags.value = [];
  if(!_cubit.excludes.contains(ProductsFilters.vendor))  _selectedVendors.value = [];
   if(!_cubit.excludes.contains(ProductsFilters.stock)) _selectedStock.value = [];
  }





  @override
  void dispose() {
    for (final notifier in notifiers) {
      notifier.dispose();
    }
    super.dispose();
  }
}