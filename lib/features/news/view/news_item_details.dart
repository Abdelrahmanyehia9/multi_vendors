import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/extensions/date_time.dart';
import 'package:multi_vendor/core/extensions/widget.dart';
import 'package:multi_vendor/core/models/news_model.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/widgets/app_button.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_scaffold.dart';
import 'package:multi_vendor/core/widgets/app_slider.dart';
import '../../../core/mixin/scroll_visibility.dart';
import '../../../core/widgets/scaffold/base_appbar.dart';

class NewsItemDetails extends StatefulWidget {
  final NewsModel news;
  const NewsItemDetails({super.key, required this.news});

  @override
  State<NewsItemDetails> createState() => _NewsItemDetailsState();
}

class _NewsItemDetailsState extends State<NewsItemDetails>
    with ScrollTitleVisibilityMixin {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: BaseAppBar(
        title: ValueListenableBuilder(
          valueListenable: showTitle,
          builder: (_, value, _) => AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, animation) => FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, -0.3),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              ),
            ),
            child: value
                ? Text(
              widget.news.title ?? "",
              key: const ValueKey('title'),
              style: TextStyles.bodyMedium,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )
                : const SizedBox.shrink(),
          ),
        ),
        actions: const [
          AppIconButton(icon: Icons.share),
        ],
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          spacing: 16.sp,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSlider(context),
            Text(widget.news.title ?? "", style: TextStyles.labelLarge),
            Text(
              widget.news.description,
              style: TextStyles.captionMedium.copyWith(color: AppColors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSlider(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.end,
    spacing: 4.h,
    children: [
      AppSlider(
        images: widget.news.images,
        placeHolder: widget.news.thumbnail,
        height: 180,
      ),
      if (widget.news.createdAt != null)
        Text(
          widget.news.createdAt!.timeAgo,
          style: TextStyles.captionSmall.copyWith(
            color: context.colors.surfaceContainer,
          ),
        ).appPaddingHr,
    ],
  );

  @override
  double get titleThreshold => 230.h;
}