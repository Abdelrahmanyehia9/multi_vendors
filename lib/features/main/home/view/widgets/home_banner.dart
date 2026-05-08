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
          height: 175,
          slides: banners.map((e) => _Slide(e)).toList(),
        );
      },
      loadingBuilder: () {
        final banner = const HomeBannerModel(
          image: "",
          bannerType: BannerType.v2,
        );
        return AppSlider(
          height: 175,
          slides: List.generate(5, (_) => _Slide(banner)),
        );
      },
      failureBuilder: AppStates.error,
    ).paddingVr(8);
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            banner.title?.localized??"",
                            style: TextStyles.bodyMedium.copyWith(
                              color: banner.textColor,
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
                          Gap.small(),
                          AppButton(
                            text: banner.buttonText?.localized ?? "",
                            color: AppColors.secondary,
                            style: TextStyles.bodySmall,
                            onPressed: () {
                              if (banner.redirect != null) {
                                context.pushNamed(banner.redirect!);
                              }
                            },
                            fixedSize: const Size(180, 35),
                            padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
                            buttonSize: null,
                          ),
                        ],
                      ).appPaddingAll,
                    ),
                    Gap(width * .275),
                  ],
                ),
              ),
              Positioned(
                bottom: 0.h,
                right: context.isRTL ? null : 0,
                left: context.isRTL ? 0 : null,
                child: AppCachedNetworkImage(
                  banner.image,
                  width: width * .365,
                ),
              ),
            ],
          ).appPaddingAll
        : AppCachedNetworkImage(
            banner.image,
            width: width - 20.w,
          );
  }
}
