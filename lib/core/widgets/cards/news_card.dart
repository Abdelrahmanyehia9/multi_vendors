import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/navigation.dart';
import 'package:multi_vendor/core/models/news_model.dart';
import 'package:multi_vendor/core/widgets/app_click.dart';

import '../../routes/routes.dart';
import '../../theme/decorations.dart';
import '../../theme/text_styles.dart';
import '../app_cached_network_image.dart';
import '../gap.dart';

class NewsList extends StatelessWidget {
  final bool shrinkWrap ;
  final List<NewsModel> news;
  const NewsList({super.key,required this.news ,this.shrinkWrap = false});

  @override
  Widget build(BuildContext context) {
    return  ListView.separated(
        shrinkWrap: shrinkWrap,
        separatorBuilder: (_, __) => Gap.small(),
        physics: shrinkWrap ? const NeverScrollableScrollPhysics() : null,
        itemBuilder: (_,i)=>  NewsCard(news: news[i],),
        itemCount: news.length,
    );
  }
}



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
              spacing: 4.h,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  news.title??"",
                  style: TextStyles.bodySmall,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Text(
                  news.description,
                  style: TextStyles.captionSmall,
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