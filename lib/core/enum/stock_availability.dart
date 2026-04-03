enum StockAvailability {
  inStock,
  outOfStock,
  onBackOrder ;


  static const Map<StockAvailability, String> _map ={
    StockAvailability.inStock: "in_Stock",
    StockAvailability.outOfStock: "out_of_Stock",
    StockAvailability.onBackOrder: "on_back_order",
  };
  String get toDatabase => _map[this]!;
  factory StockAvailability.fromDatabase(String value) {
    return _map.entries.firstWhere((entry) => entry.value == value).key;
  }
}