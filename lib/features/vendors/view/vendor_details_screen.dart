import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/widget.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/widgets/cards/product_card.dart';
import 'package:multi_vendor/core/widgets/gap.dart';
import 'package:multi_vendor/features/shop/product/view/widgets/product_filters_action.dart';
import 'package:multi_vendor/features/vendors/view/widgets/vendor_app_bar.dart';
import 'package:multi_vendor/features/vendors/view/widgets/vendor_info_card.dart';

class VendorDetailsScreen extends StatefulWidget {
  const VendorDetailsScreen({super.key});

  @override
  State<VendorDetailsScreen> createState() => _VendorDetailsScreenState();
}

class _VendorDetailsScreenState extends State<VendorDetailsScreen> {
  final _scroll = ScrollController();
  final _collapsed = ValueNotifier(false);
   static const double _expandedHeight = 240.0;
  @override
  void initState() {
    super.initState();
    setupListeners();

  }

void setupListeners() {
  _scroll.addListener(() {
    final c = _scroll.hasClients &&
        _scroll.offset > (_expandedHeight - kToolbarHeight - 60);
    if (c != _collapsed.value) _collapsed.value = c;
  });}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scroll,
        slivers: [
          VendorAppBar(
            collapsed: _collapsed,
            expandedHeight: _expandedHeight,
          ),
          const SliverToBoxAdapter(child: VendorInfoCard()),
            SliverToBoxAdapter(
            child: Row(
              children: [
                _numOfProducts(20),
                const Spacer(),
                const ProductFiltersAction(),
              ],
            ).appPaddingAll,
          ),
            SliverPadding(
               padding: EdgeInsets.symmetric(horizontal: 16.w),
               sliver: const ProductGrid(sliver: true,products: [],))
        ],
      ),
    );

  }

  Widget _numOfProducts(int count) {
    String countStr= count >999 ? "+999" : count.toString();
    return Row(
     children: [
       Text('Products', style: TextStyles.bodyLarge),
       const Gap(4),
       Text("($countStr)", style: TextStyles.captionMedium),
     ],
  );
  }
  @override
  void dispose() {
    _scroll.dispose();
    _collapsed.dispose();
    super.dispose();
  }
}

