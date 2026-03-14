import 'package:flutter/material.dart';
import 'package:multi_vendor/core/extensions/navigation.dart';
import 'package:multi_vendor/core/routes/routes.dart';
import 'package:multi_vendor/core/widgets/section_header.dart';
import '../../../../../core/widgets/cards/news_card.dart';

class HomeNewsSection extends StatelessWidget {
  const HomeNewsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
         SectionHeader(title: "Featured News", onActionTap: ()=>context.pushNamed(Routes.news),),
        const NewsList(
          shrinkWrap: true,
        ),
      ],
    );
  }
}
