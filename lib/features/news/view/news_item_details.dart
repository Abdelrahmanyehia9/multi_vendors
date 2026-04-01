import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/models/news_model.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_scaffold.dart';
import 'package:multi_vendor/core/widgets/app_slider.dart';

import '../../../core/widgets/scaffold/base_appbar.dart';

class NewsItemDetails extends StatelessWidget {
  final NewsModel news ;
  const NewsItemDetails({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: BaseAppBar(),
      body: SingleChildScrollView(
        child: Column(
          spacing: 16.sp,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppSlider(
               images:news.images,
               placeHolder: news.thumbnail,
               height: 150,),
            Text(news.title??"" , style: TextStyles.labelLarge,),
            Text(news.description, style: TextStyles.captionMedium.copyWith(color: AppColors.grey),)
          ],
        ),
      ),
    );
  }
}
