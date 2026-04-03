import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/cubit/base_bloc_consumer.dart';
import 'package:multi_vendor/core/utils/app_constants.dart';
import 'package:multi_vendor/core/widgets/app_states.dart';
import 'package:multi_vendor/core/widgets/app_text_field.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_scaffold.dart';
import 'package:multi_vendor/features/shop/product/logic/product_all_tags_cubit.dart';
import '../../../../../core/widgets/scaffold/base_appbar.dart';
import '../../../../core/widgets/cards/product_tag_tile.dart';
import '../../../main/home/data/models/product_tag_model.dart';

class AllProductTagsScreen extends StatelessWidget {
  const AllProductTagsScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: BaseAppBar(title: AppConstants.tagsString),
      body: Column(
        spacing: 12.h,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSearchField(context),
          Expanded(
            child: BaseBlocConsumer<ProductAllTagsCubit, List<ProductTagModel>>(
              successBuilder: (tags) => ProductTagTileList(tags: tags),
              loadingBuilder: () {
                final fake = ProductTagModel.fake();
                return ProductTagTileList(tags: List.generate(6, (_) => fake));
              },
              emptyBuilder: AppStates.empty,
              failureBuilder: AppStates.error,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField(BuildContext context) {
    final cubit = context.read<ProductAllTagsCubit>();
    return AppTextField(hintText: "Search ... ",
        onChange: cubit.onSearch,
        prefix: const Icon(Icons.search)

      );
  }
}
