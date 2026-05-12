import 'package:flutter/material.dart';
import 'package:multi_vendor/core/widgets/gap.dart';
import 'package:multi_vendor/features/news/data/model/news_model.dart';
import 'package:multi_vendor/shared/view/widgets/cards/news_card.dart';

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
