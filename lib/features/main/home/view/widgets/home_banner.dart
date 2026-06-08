import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/cubit/base_bloc_consumer.dart';
import 'package:multi_vendor/core/enum/banner_type.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/extensions/data_type.dart';
import 'package:multi_vendor/core/extensions/navigation.dart';
import 'package:multi_vendor/core/extensions/widget.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/theme/decorations.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/widgets/app_click.dart';
import 'package:multi_vendor/core/widgets/buttons/app_button.dart';
import 'package:multi_vendor/core/widgets/app_cached_network_image.dart';
import 'package:multi_vendor/core/widgets/app_states.dart';
import 'package:multi_vendor/features/main/home/data/models/home_banner_model.dart';
import 'package:multi_vendor/features/main/home/logic/home_banner_cubit.dart';
import 'package:multi_vendor/core/widgets/gap.dart';
import 'package:multi_vendor/shared/view/widgets/app_slider.dart';

class HomeBanner extends StatelessWidget {
  const HomeBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseBlocConsumer<HomeBannerCubit, List<HomeBannerModel>>(
      successBuilder: (banners) {
        return AppSlider(
          height: 144,
          slides: banners.map((e) => _Slide(e)).toList(),
        );
      },
      loadingBuilder: () {
        final banner = const HomeBannerModel(
          image: "",
          bannerType: BannerType.v2,
        );
        return AppSlider(
          height: 144,
          slides: List.generate(5, (_) => _Slide(banner)),
        );
      },
      failureBuilder: AppStates.error,
    );
  }
}

class _Slide extends StatelessWidget {
  final HomeBannerModel banner;

  const _Slide(this.banner);

  @override
  Widget build(BuildContext context) {
    final width = context.width;
    return banner.bannerType == BannerType.v1
        ? Stack(
            alignment: AlignmentDirectional.bottomCenter,
            clipBehavior: Clip.none,
            children: [
              Container(
                margin:  EdgeInsetsDirectional.only(top: 8.h, start: 16.w , end: 16.w),
                decoration: BoxDecoration(
                  color: AppColors.grey800,
                  borderRadius: BorderRadius.circular(
                    Decorations.borderRadius16,
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            banner.title?.localized ?? "",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyles.labelMedium.copyWith(
                              color: banner.textColor,
                              fontWeight: FontWeightHelper.bold
                            ),
                          ),
                          Text(
                            banner.description?.localized ?? "",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyles.captionMedium.copyWith(
                              color: banner.textColor,
                            ),
                          ),
                          AppButton(
                            text: banner.buttonText?.localized ?? "",
                            color: AppColors.secondary,
                            style: TextStyles.labelSmall,
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              if (banner.redirect != null) {
                                context.pushNamed(banner.redirect!);
                              }
                            },
                            fixedSize: const Size(120, 28),
                            buttonSize: null,
                          ),
                        ],
                      ).appPaddingAll,
                    ),
                    Gap(width * .3),
                  ],
                ),
              ),
              Positioned(
                bottom: 0.h,
                right: context.isRTL ? null : -4.w,
                left: context.isRTL ? -4.w : null,
                child: AppCachedNetworkImage(
                  banner.image,
                  width: 147,
                  fit: BoxFit.fill,
                  height: 147,
                ),
              ),
            ],
          )
        : AppClick(
          onTap: () {
            if (banner.redirect != null) {
              context.pushNamed(banner.redirect!);
            }
          },
          child: Padding(
            padding:  EdgeInsets.only(top: 8.0.h),
            child: AppCachedNetworkImage(
                banner.image,
                radius: Decorations.borderRadius8.r,
                width: width ,
              ),
          ),
        ).appPaddingHr;
  }
}
