import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/navigation.dart';
import 'package:multi_vendor/core/widgets/app_chip.dart';
import 'package:multi_vendor/core/widgets/app_click.dart';
import 'package:multi_vendor/core/widgets/cards/product_card.dart';
import '../../../../../core/routes/routes.dart';
import '../../../../../core/widgets/gap.dart';
import '../../../../../core/widgets/section_header.dart';

class HomeShopByCategories extends StatefulWidget {
  const HomeShopByCategories({super.key});

  @override
  State<HomeShopByCategories> createState() => _HomeShopByCategoriesState();
}
class _HomeShopByCategoriesState extends State<HomeShopByCategories> {
  final ValueNotifier<int> _selectedItem = ValueNotifier(0);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
         SectionHeader(title: "Categories", hasAction: true,onActionTap: ()=>context.pushNamed(Routes.products),),
        _Categories(selectedItem: _selectedItem),
        Gap.medium(),
        const ProductGrid(shrinkWrap: true,),
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
                child: AppChip(text: "Kids",selected: value == i)),
            separatorBuilder: (_, _) => SizedBox(width: 8.w),
            itemCount: 10,
          ),
        );
      }
    ) ;
  }


}

