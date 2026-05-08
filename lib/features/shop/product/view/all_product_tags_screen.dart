import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor/core/cubit/base_bloc_consumer.dart';
import 'package:multi_vendor/core/extensions/widget.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';
import 'package:multi_vendor/core/widgets/app_states.dart';
import 'package:multi_vendor/core/widgets/overlays/widget_overlay.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_scaffold.dart';
import 'package:multi_vendor/features/shop/product/logic/product_all_tags_cubit.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_appbar.dart';
import 'package:multi_vendor/shared/view/widgets/app_search_bar.dart';
import 'package:multi_vendor/shared/view/widgets/cards/product_tag_tile.dart';
import 'package:multi_vendor/shared/view/widgets/search_builder.dart';
import 'package:multi_vendor/features/main/home/data/models/product_tag_model.dart';

class AllProductTagsScreen extends StatelessWidget {
  const AllProductTagsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProductAllTagsCubit>();

    return BaseScaffold(
      paddingHr: 0,
      appBar: BaseAppBar(title: AppStrings.tags.tr()),
      body: SearchBuilder(
        builder: (_, hasFocus) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppSearchbar(onQueryChanged: cubit.onSearch).appPaddingAll,
            Expanded(
              child: WidgetOverlay(
                showOverlay: hasFocus,
                child:
                    BaseBlocConsumer<
                          ProductAllTagsCubit,
                          List<ProductTagModel>
                        >(
                          successBuilder: (tags) =>
                              ProductTagTileList(tags: tags),
                          loadingBuilder: () {
                            final fake = ProductTagModel.fake();
                            return ProductTagTileList(
                              tags: List.generate(6, (_) => fake),
                            );
                          },

                          emptyBuilder: AppStates.empty,
                          failureBuilder: AppStates.error,
                        )
                        .appPaddingHr,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
