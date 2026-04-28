import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/cubit/base_bloc_consumer.dart';
import 'package:multi_vendor/core/extensions/navigation.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/widgets/app_cached_network_image.dart';
import 'package:multi_vendor/core/widgets/app_click.dart';
import 'package:multi_vendor/features/main/home/data/models/home_vendor_model.dart';
import 'package:multi_vendor/features/main/home/logic/home_vendors_cubit.dart';
import 'package:multi_vendor/core/routes/routes.dart';
import 'package:multi_vendor/shared/view/widgets/circular_box.dart';
import 'package:multi_vendor/shared/view/widgets/section_header.dart';

class HomeVendorsSection extends StatelessWidget {
  const HomeVendorsSection({super.key});
  int get maxItems => 6;

  @override
  Widget build(BuildContext context) {
    return BaseBlocConsumer<HomeVendorsCubit, List<HomeVendorModel>>(
      successBuilder: (v) {
        final items = v.length;
        final displayCount = items < maxItems ? items : maxItems;
        return _builder(
          v,
          displayCount: displayCount,
          context: context,
        );
      },
      loadingBuilder: () {
        final item =const HomeVendorModel(name: "", image: "") ;
        return _builder(
        List.generate(
          maxItems,
          (_) =>item,
        ),
        displayCount: maxItems,
        context: context,
      );
      },
    );
  }

  Widget _builder(
    List<HomeVendorModel> vendors, {
    required int displayCount,
    required BuildContext context,
  }) {

    final reminder = vendors.length - displayCount + 1;
    return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
       SectionHeader(
        title: "Vendors",
        hasAction: true,
        onActionTap: ()=> context.pushNamed(Routes.vendors)
      ),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        child: Row(
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
  final HomeVendorModel vendor;
  const _Vendor(this.vendor, {this.lastOne = false, required this.reminder});

  @override
  Widget build(BuildContext context) {
    return AppClick(
      onTap: () => context.pushNamed(Routes.vendor, arguments: vendor.id),
      child: CircularBox(
        radius: 52,
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
    );
  }
}
