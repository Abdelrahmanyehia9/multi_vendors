import 'package:flutter/material.dart';
import 'package:multi_vendor/core/cubit/base_bloc_consumer.dart';
import 'package:multi_vendor/core/widgets/app_states.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_scaffold.dart';
import 'package:multi_vendor/features/shop/product/data/model/product_details_model.dart';
import 'package:multi_vendor/features/shop/product/logic/product_details_cubit.dart';
import 'package:multi_vendor/features/shop/product/view/widgets/product_details_body.dart';
import '../../../../../core/widgets/scaffold/base_appbar.dart';
import '../../../../core/widgets/share_button.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}
class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: BaseAppBar(
        actions: const [ShareButton()],
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

}

