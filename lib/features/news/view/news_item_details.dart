import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/widget.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/utils/testing.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_scaffold.dart';
import 'package:multi_vendor/core/widgets/app_slider.dart';

import '../../../core/widgets/scaffold/base_appbar.dart';

class NewsItemDetails extends StatelessWidget {
  const NewsItemDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: BaseAppBar(),
      body: SingleChildScrollView(
        child: Column(
          spacing: 16.sp,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppSlider(images: [Testing.girlModel], height: 150,),
            Text("Fashion Celebrates Beauty in All Shapes and Sizes" , style: TextStyles.labelLarge,),
            Text('''
Fashion, once considered an exclusive realm for a limited range of body types, is undergoing a transformative shift in the 21st century. The industry, often criticized for promoting unrealistic beauty standards, is now embracing diversity and inclusivity like never before. The mantra is clear: beauty exists in all shapes and sizes.

In the past, fashion runways and advertising campaigns predominantly featured models with a specific body type, leaving many consumers feeling excluded. However, the winds of change are blowing, and the fashion world is taking significant strides towards inclusivity. Designers, influencers, and brands are now acknowledging that beauty transcends the limitations of size, color, and age.

One notable development is the rise of body-positive movements that challenge the conventional norms of beauty. Social media platforms have become powerful tools for promoting diverse body images, with influencers and activists using their platforms to redefine beauty standards. The fashion industry is gradually responding to this societal shift, with brands incorporating models of various sizes and shapes in their campaigns.

Several fashion labels are making a conscious effort to break away from the traditional mold. They are featuring plus-size models and celebrating the natural curves and unique beauty of individuals. This shift is not only empowering for consumers but is also sending a powerful message to the fashion industry: inclusivity is not just a trend but a necessity.
            
            ''' , style: TextStyles.captionMedium.copyWith(color: AppColors.grey),)
          ],
        ).appPaddingHr,
      ),
    );
  }
}
