import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/cubit/base_bloc_consumer.dart';
import 'package:multi_vendor/core/widgets/app_states.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_scaffold.dart';
import 'package:multi_vendor/features/main/favorite/view/widgets/add_to_favorite_button.dart';
import 'package:multi_vendor/features/shop/product/data/model/product_details_model.dart';
import 'package:multi_vendor/features/shop/product/logic/product_details_cubit.dart';
import 'package:multi_vendor/features/shop/product/view/widgets/product_details_body.dart';
import '../../../../../core/widgets/scaffold/base_appbar.dart';
import '../../../../core/models/product_model.dart';
import '../../../../core/widgets/share_button.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}
class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  ValueNotifier<ProductDetailsModel?> product = ValueNotifier(null) ;
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: BaseAppBar(
        actions:  [
          BaseBlocConsumer<ProductDetailsCubit, ProductDetailsModel>(
            successBuilder: (p) => _productAction(ProductModel.fromProductDetails(p)),
            loadingBuilder: () => _productAction(ProductModel.fake()),
          )
        ],
      ),
      body: BaseBlocConsumer<ProductDetailsCubit, ProductDetailsModel>(
        successBuilder: (p) => ProductDetailsBody(
            model: p,
          onAddCart: (v){
          },
          ),
        loadingBuilder: () => ProductDetailsBody(
            model: ProductDetailsModel.fake()
        ),
        failureBuilder: AppStates.error,
      ),
    );
  }


  Widget _productAction(ProductModel model){
    return Row(
      spacing: 4.w,
      children: [
        FavoriteButton.product(
            size: 30,
            padding: 8,
            product: model),
        const ShareButton()
      ],
    );
  }
  @override
  void dispose() {
    product.dispose();
    super.dispose();
  }
}

