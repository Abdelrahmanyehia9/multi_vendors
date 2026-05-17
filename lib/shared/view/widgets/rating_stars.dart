import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/utils/mv_icons.dart';
import 'package:multi_vendor/shared/view/widgets/section_header.dart';

import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/utils/feature_flags.dart';
import 'package:multi_vendor/core/widgets/gap.dart';
import 'package:multi_vendor/shared/data/models/rating_model.dart';


///generated from ai
class RatingStars extends StatefulWidget {
  final RatingModel? rating;
  final double size;
  final bool readOnly;
  final String? title;
  final bool showCount;
  final ValueChanged<double>? onRatingChanged;

  const RatingStars({
    super.key,
    this.rating,
    this.size = 16,
    this.readOnly = true,
    this.title,
    this.showCount = true,
    this.onRatingChanged,
  }) : assert(
  readOnly || onRatingChanged != null,
  'onRatingChanged is required when readOnly is false',
  );

  @override
  State<RatingStars> createState() => _RatingStarsState();
}

class _RatingStarsState extends State<RatingStars> with TickerProviderStateMixin {
  late final ValueNotifier<double> _ratingNotifier;
  late final List<AnimationController> _controllers;
  late final List<Animation<double>> _scaleAnimations;

  RatingModel get rating => widget.rating ?? const RatingModel(count: 0, rating: 0);

  @override
  void initState() {
    super.initState();
    _ratingNotifier = ValueNotifier(rating.rating.toDouble());

    _controllers = List.generate(
      5,
          (i) => AnimationController(vsync: this, duration: const Duration(milliseconds: 200)),
    );

    _scaleAnimations = _controllers.map((c) {
      return TweenSequence<double>([
        TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.4), weight: 50),
        TweenSequenceItem(tween: Tween(begin: 1.4, end: 1.0), weight: 50),
      ]).animate(CurvedAnimation(parent: c, curve: Curves.easeOut));
    }).toList();
  }

  @override
  void didUpdateWidget(RatingStars oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.rating != widget.rating) {
      _ratingNotifier.value = widget.rating?.rating.toDouble() ?? 0.0;
    }
  }

  @override
  void dispose() {
    _ratingNotifier.dispose();
    for (final c in _controllers)
     {
       c.dispose();
     }
    super.dispose();
  }

  void _updateRating(double newRating, int starIndex) {
    _ratingNotifier.value = newRating;
    widget.onRatingChanged!(newRating);
    for (int i = 0; i <= starIndex; i++) {
      Future.delayed(Duration(milliseconds: i * 40), () {
        if (mounted) _controllers[i].forward(from: 0);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!FeatureFlags.enableRating) return const SizedBox.shrink();

    return Column(
      children: [
        if (widget.title != null) SectionHeader(title: widget.title!),
        ValueListenableBuilder<double>(
          valueListenable: _ratingNotifier,
          builder: (context, currentRating, _) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ...List.generate(5, (i) => _buildStar(i, currentRating, context)),
                if (widget.rating?.count != null && widget.showCount) ...[
                  Gap.extraSmall(),
                  Text(
                    "(${widget.rating!.count})",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyles.bodySmall.copyWith(
                      color: context.colors.surfaceContainer,
                      fontSize: (widget.size - 6).sp,
                    ),
                  ),
                ],
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildStar(int i, double currentRating, BuildContext context) {
    final full = i < currentRating.floor();
    final half = !full && i < currentRating && (currentRating - currentRating.floor()) >= 0.5;

    final icon = Icon(
      full ? MvIcons.star : half ? MvIcons.starHalf : MvIcons.starOutlined,
      size: widget.size.sp,
      color: full || half ? AppColors.warning : context.colors.surfaceContainer,
    );

    if (widget.readOnly) return icon;

    return GestureDetector(
      onTap: () => _updateRating(i + 1.0, i),
      child: AnimatedBuilder(
        animation: _scaleAnimations[i],
        builder: (_, __) => Transform.scale(scale: _scaleAnimations[i].value, child: icon),
      ),
    );
  }
}