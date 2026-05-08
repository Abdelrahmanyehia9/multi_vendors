part of 'product_filters_sheet.dart';

class _RatingFilter extends StatelessWidget {
  final ValueNotifier<RangeValues?> selectedRating;
  final RangeValues ratingRange;

  const _RatingFilter({required this.selectedRating, required this.ratingRange});

  List<int> get _ratings => List.generate(
    (ratingRange.end - ratingRange.start).toInt() + 1,
        (i) => ratingRange.start.toInt() + i,
  );

  @override
  Widget build(BuildContext context) {
    final ratings = _ratings;
    return ValueListenableBuilder<RangeValues?>(
      valueListenable: selectedRating,
      builder: (context, value, child) {
        return Column(
          spacing: 2.h,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: List.generate(
            ratings.length ,
                (i) {
              final rating = ratings[i];
              final isSelected = value?.start.round() == rating;
              return AppRadioButton<int>(
                value: rating,
                groupValue: value?.start.round(),
                onChanged: (_) => _onChange(rating, ratingRange.end, isSelected),
                child: Text("$rating ⭐ ${AppStrings.andMore.tr()}"),
              );
            },
          ),
        );
      },
    );
  }

  void _onChange(int rating, double max, bool isSelected) {
    selectedRating.value = isSelected ? null : RangeValues(rating.toDouble(), max);
  }
}