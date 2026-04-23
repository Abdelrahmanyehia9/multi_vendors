import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/cubit/base_bloc_consumer.dart';
import 'package:multi_vendor/core/widgets/app_states.dart';
import 'package:multi_vendor/core/widgets/buttons/app_favorite_button.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_scaffold.dart';
import 'package:multi_vendor/features/shop/product/data/model/product_details_model.dart';
import 'package:multi_vendor/features/shop/product/logic/product_details_cubit.dart';
import 'package:multi_vendor/features/shop/product/view/widgets/product_details_body.dart';
import '../../../../../core/widgets/scaffold/base_appbar.dart';
import '../../../../core/models/product_model.dart';
import '../../../../core/widgets/buttons/share_button.dart';

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
          _productAction()
        ],
      ),
      body: BaseBlocConsumer<ProductDetailsCubit, ProductDetailsModel>(
        successBuilder: (p) => ProductDetailsBody(
            model: p,
          ),
        loadingBuilder: () => ProductDetailsBody(
            model: ProductDetailsModel.fake()
        ),
        failureBuilder: AppStates.error,
      ),
    );
  }
  Widget _productAction(){
    Widget action(ProductModel model) => Row(
      spacing: 4.w,
      children: [
      AppFavoriteButton(item: model, size: 30,padding: 8,),
        const AppShareButton()
      ],
    );
    return  BaseBlocConsumer<ProductDetailsCubit, ProductDetailsModel>(
      successBuilder: (p) =>  action(ProductModel.fromProductDetails(p)),
      loadingBuilder: () => action(ProductModel.fake()),
    );

  }
  @override
  void dispose() {
    product.dispose();
    super.dispose();
  }
}

