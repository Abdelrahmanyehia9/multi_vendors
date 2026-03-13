import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/widgets/app_click.dart';
import 'package:multi_vendor/core/widgets/cards/product_card.dart';
import '../../../../../core/widgets/gap.dart';
import 'home_section_header.dart';

class HomeShopByCategories extends StatefulWidget {
  const HomeShopByCategories({super.key});

  @override
  State<HomeShopByCategories> createState() => _HomeShopByCategoriesState();
}
class _HomeShopByCategoriesState extends State<HomeShopByCategories> {
  final ValueNotifier<int> _selectedItem = ValueNotifier(0);
  @override
  Widget build(BuildContext context) {
    final Size cardSize = ProductCard.smallSize;
    return Column(
      children: [
        const HomeSectionHeader(title: "Categories"),
        _Categories(selectedItem: _selectedItem),
        Gap.medium(),
        GridView.builder(
          shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2 ,
              mainAxisSpacing: 24.h,
              crossAxisSpacing: 20.w,
              childAspectRatio: cardSize.width.w /cardSize.height.h
            ),
            itemBuilder : (_, i)=>ProductCard.small(),
            itemCount: 4,
        ),
      ],
    );
  }


  @override
  void dispose() {
    _selectedItem.dispose();
    super.dispose();
  }
}



class _Categories extends StatelessWidget {
  final ValueNotifier<int> selectedItem ;
  const _Categories({required this.selectedItem});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedItem,
      builder: (context, value, child) {
        return SizedBox(
          height: 30.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.zero,
            clipBehavior: Clip.none,
            itemBuilder: (_, i) => AppClick(
                onTap: (){
                  selectedItem.value = i;
                },
                child: _buildChip("Kids", context: context, selected: value == i)),
            separatorBuilder: (_, _) => SizedBox(width: 8.w),
            itemCount: 10,
          ),
        );
      }
    ) ;
  }
  Widget _buildChip(
      String data, {
        bool selected = false,
        required BuildContext context,
      }) {
    return Chip(
      label: Text(data),
      side: BorderSide(
        color: selected ? AppColors.primary : context.colors.surfaceContainerLow,
      ),
      labelStyle: TextStyles.bodySmall.copyWith(
        color: selected ? Colors.white : null,
      ),
      backgroundColor: selected == true ? AppColors.primary : null,
    );
  }

}

