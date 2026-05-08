import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:multi_vendor/core/cubit/base_bloc_consumer.dart';
import 'package:multi_vendor/core/extensions/navigation.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';
import 'package:multi_vendor/features/main/home/logic/home_tags_filter_cubit.dart';
import 'package:multi_vendor/core/routes/routes.dart';
import 'package:multi_vendor/shared/view/widgets/cards/product_tag_tile.dart';
import 'package:multi_vendor/shared/view/widgets/section_header.dart';
import 'package:multi_vendor/features/main/home/data/models/product_tag_model.dart';

class HomeShopByProductTags extends StatelessWidget {
  const HomeShopByProductTags({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseBlocConsumer<HomeTagsFilterCubit, List<ProductTagModel>>(
      successBuilder: (tags) => _builder(context, tags: tags),
      loadingBuilder: () => _builder(
        context,
        tags: List.generate(4, (_) {
          final item = ProductTagModel.fake();
          return item;
        }),
      ),
    );
  }

  Widget _builder(
    BuildContext context, {
    required List<ProductTagModel> tags,
  }) => Column(
    children: [
      SectionHeader(
        hasAction: true,
        title: AppStrings.filterByTags.tr(),
        onActionTap: () => context.pushNamed(Routes.productTags),
      ),
      ProductTagTileList(shrinkWrap: true, tags: tags),
    ],
  );
}
