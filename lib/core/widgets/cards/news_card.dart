import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/navigation.dart';
import 'package:multi_vendor/core/widgets/app_click.dart';

import '../../routes/routes.dart';
import '../../theme/decorations.dart';
import '../../theme/text_styles.dart';
import '../../utils/testing.dart';
import '../app_cached_network_image.dart';
import '../gap.dart';

class NewsList extends StatelessWidget {
  final bool shrinkWrap ;
  const NewsList({super.key, this.shrinkWrap = false});

  @override
  Widget build(BuildContext context) {
    return  ListView.separated(
        shrinkWrap: shrinkWrap,
        separatorBuilder: (_, __) => Gap.small(),
        physics: shrinkWrap ? const NeverScrollableScrollPhysics() : null,
        itemBuilder: (_,__)=> const NewsCard(),
        itemCount: 5,
    );
  }
}



class NewsCard extends StatelessWidget {
  const NewsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return AppClick(
      onTap: ()=>context.pushNamed(Routes.newsDetails),
      child: Row(
        children: [
          const AppCachedNetworkImage(
            Testing.girlModel,
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
                  "Fashion Celebrates Beauty in All Shapes and Sizes",
                  style: TextStyles.bodySmall,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Text(
                  "The fashion industry is increasingly embracing diversity by featuring models that represent a variety of body shapes, skin colors and backgrounds.",
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