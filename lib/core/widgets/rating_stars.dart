import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/widgets/section_header.dart';

import '../theme/app_colors.dart';
import '../theme/text_styles.dart';
import '../utils/feature_flags.dart';
import 'gap.dart';


///generated from ai
class RatingStars extends StatefulWidget {
  final double rating;
  final double size;
  final int? count;
  final bool readOnly;
  final String? title ;
  final ValueChanged<double>? onRatingChanged;

  const RatingStars({
    super.key,
    this.count,
    required this.rating,
    this.size = 16,
    this.readOnly = true,
    this.title,
    this.onRatingChanged,
  }) : assert(
  readOnly || onRatingChanged != null,
  'onRatingChanged is required when readOnly is false',
  );

  @override
  State<RatingStars> createState() => _RatingStarsState();
}

class _RatingStarsState extends State<RatingStars>
    with TickerProviderStateMixin {
  late final ValueNotifier<double> _ratingNotifier;
  late final List<AnimationController> _controllers;
  late final List<Animation<double>> _scaleAnimations;

  @override
  void initState() {
    super.initState();
    _ratingNotifier = ValueNotifier(widget.rating);

    _controllers = List.generate(
      5,
          (i) => AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 200),
      ),
    );

    _scaleAnimations = _controllers.map((c) {
      return TweenSequence<double>([
        TweenSequenceItem(
          tween: Tween(begin: 1.0, end: 1.4),
          weight: 50,
        ),
        TweenSequenceItem(
          tween: Tween(begin: 1.4, end: 1.0),
          weight: 50,
        ),
      ]).animate(CurvedAnimation(parent: c, curve: Curves.easeOut));
    }).toList();
  }

  @override
  void didUpdateWidget(RatingStars oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.rating != widget.rating) {
      _ratingNotifier.value = widget.rating;
    }
  }

  @override
  void dispose() {
    _ratingNotifier.dispose();
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  void _updateRating(double newRating, int starIndex) {
    _ratingNotifier.value = newRating;
    widget.onRatingChanged!(newRating);

    for (int i = 0; i <= starIndex; i++) {
      Future.delayed(Duration(milliseconds: i * 40), () {
        if (mounted) {
          _controllers[i].forward(from: 0);
        }
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
              children: [
                ...List.generate(
                  5,
                      (i) => _buildStar(i, currentRating, context),
                ),
                if (widget.count != null && widget.count! > 0) ...[
                  Gap.extraSmall(),
                  Text(
                    "(${widget.count})",
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
    final half =
        !full && i < currentRating && (currentRating - currentRating.floor()) >= 0.5;

    final icon = Icon(
      full ? Icons.star : half ? Icons.star_half : Icons.star_border,
      size: widget.size.sp,
      color: full || half
          ? AppColors.warning500
          : context.colors.surfaceContainer,
    );

    if (widget.readOnly) return icon;

    return GestureDetector(
      onTap: () => _updateRating(i + 1.0, i),
      child: AnimatedBuilder(
        animation: _scaleAnimations[i],
        builder: (_, __) => Transform.scale(
          scale: _scaleAnimations[i].value,
          child: icon,
        ),
      ),
    );
  }
}