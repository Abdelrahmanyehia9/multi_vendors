import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/extensions/data_type.dart';
import 'package:multi_vendor/core/extensions/navigation.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/widgets/app_click.dart';

import 'package:multi_vendor/core/routes/routes.dart';
import 'package:multi_vendor/core/theme/decorations.dart';
import 'package:multi_vendor/core/widgets/app_cached_network_image.dart';
import 'package:multi_vendor/core/widgets/gap.dart';
import 'package:multi_vendor/features/news/data/model/news_model.dart';





class NewsCard extends StatelessWidget {
  final NewsModel news;
  const NewsCard({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return AppClick(
      onTap: ()=>context.pushNamed(Routes.newsDetails , arguments: news),
      child: Row(
        children: [
           AppCachedNetworkImage(
            news.thumbnail,
            height: 100,
            width: 120,
            radius: Decorations.borderRadius8,
          ),
          Gap.small(),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4.h,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  news.title?.localized??"",
                  style: TextStyles.labelSmall,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Text(
                  news.description.localized,
                  style: TextStyles.bodySmall.copyWith(
                    color: context.colors.surfaceContainer
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}