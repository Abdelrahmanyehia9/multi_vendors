import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/cubit/base_bloc_consumer.dart';
import 'package:multi_vendor/core/extensions/data_type.dart';
import 'package:multi_vendor/core/extensions/navigation.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';
import 'package:multi_vendor/core/utils/mv_icons.dart';
import 'package:multi_vendor/core/widgets/app_cached_network_image.dart';
import 'package:multi_vendor/core/widgets/app_click.dart';
import 'package:multi_vendor/features/main/home/logic/home_vendors_cubit.dart';
import 'package:multi_vendor/core/routes/routes.dart';
import 'package:multi_vendor/features/vendors/data/model/vendor_model.dart';
import 'package:multi_vendor/shared/view/widgets/circular_box.dart';
import 'package:multi_vendor/shared/view/widgets/section_header.dart';

class HomeVendorsSection extends StatelessWidget {
  const HomeVendorsSection({super.key});

  int get maxItems => 6;

  @override
  Widget build(BuildContext context) {
    return BaseBlocConsumer<HomeVendorsCubit, List<VendorModel>>(
      successBuilder: (v) {
        final items = v.length;
        final displayCount = items < maxItems ? items : maxItems;
        return _builder(v, displayCount: displayCount, context: context);
      },
      loadingBuilder: () {
        final item = VendorModel.fake();
        return _builder(
          List.generate(maxItems, (_) => item),
          displayCount: maxItems,
          context: context,
        );
      },
    );
  }

  Widget _builder(
    List<VendorModel> vendors, {
    required int displayCount,
    required BuildContext context,
  }) {
    final reminder = vendors.length - displayCount + 1;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: AppStrings.vendors.tr(),
          hasAction: true,
          onActionTap: () => context.pushNamed(Routes.vendors),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          clipBehavior: Clip.none,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8.w,
            children: List.generate(displayCount, (index) {
              bool lastOne =
                  vendors.length > maxItems && index == displayCount - 1;
              return _Vendor(
                vendors[index],
                lastOne: lastOne,
                reminder: reminder,
              );
            }),
          ),
        ),
      ],
    );
  }
}

class _Vendor extends StatelessWidget {
  final bool lastOne;
  final int reminder;
  final VendorModel vendor;

  const _Vendor(this.vendor, {this.lastOne = false, required this.reminder});

  @override
  Widget build(BuildContext context) {
    return AppClick(
      onTap: () => context.pushNamed(Routes.vendor, arguments: vendor.id),
      child: Column(
        children: [
              CircularBox(
                radius: 65,
                padding: EdgeInsets.zero,
                child: !lastOne
                    ? AppCachedNetworkImage(vendor.image)
                    : AppClick(
                        onTap: () => context.pushNamed(Routes.vendors),
                        child: CircleAvatar(
                          backgroundColor: AppColors.primary,
                          child: Text(
                            "+$reminder",
                            style: TextStyles.bodyMedium.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ),
              ),
               Row(
            children: [
                ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: 70.w,
                  minWidth: 40.w,
                  maxHeight: 70.h,
                ),
                child: Text(
                  vendor.name.localized,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: TextStyles.labelSmall
                ),
              ),
                if(vendor.isVerified)
                Icon(MvIcons.verified, size: 16.sp, color: AppColors.success600),
            ],
          ),
        ],
      ),
    );
  }
}
