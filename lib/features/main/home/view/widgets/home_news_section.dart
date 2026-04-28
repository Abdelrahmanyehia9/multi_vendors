import 'package:flutter/material.dart';
import 'package:multi_vendor/core/cubit/base_bloc_consumer.dart';
import 'package:multi_vendor/core/extensions/navigation.dart';
import 'package:multi_vendor/core/routes/routes.dart';
import 'package:multi_vendor/features/main/home/logic/home_news_cubit.dart';
import 'package:multi_vendor/shared/data/models/news_model.dart';
import 'package:multi_vendor/shared/view/widgets/cards/news_card.dart';
import 'package:multi_vendor/shared/view/widgets/section_header.dart';

class HomeNewsSection extends StatelessWidget {
  const HomeNewsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseBlocConsumer<HomeNewsCubit, List<NewsModel>>(
      successBuilder: (news) => _builder(context, news: news),
      loadingBuilder: () {
        final NewsModel fake = const NewsModel();
        return _builder(context, news: List.generate(5, (_) => fake));
      },
    ) ;
  }

  Widget _builder(BuildContext context, {required List<NewsModel> news}) =>
      Column(
        children: [
          SectionHeader(
            title: "Featured News",
            hasAction: true,
            onActionTap: () => context.pushNamed(Routes.news),
          ),
           NewsList(shrinkWrap: true, news: news),
        ],
      );
}
