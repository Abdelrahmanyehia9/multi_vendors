import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/cubit/base_bloc_consumer.dart';
import 'package:multi_vendor/core/extensions/widget.dart';
import 'package:multi_vendor/core/models/product_model.dart';
import 'package:multi_vendor/core/widgets/app_states.dart';
import 'package:multi_vendor/core/widgets/cards/product_card.dart';
import 'package:multi_vendor/core/widgets/gap.dart';
import 'package:multi_vendor/core/widgets/search_builder.dart';
import 'package:multi_vendor/core/widgets/slogan_text.dart';
import 'package:multi_vendor/core/widgets/app_search_bar.dart';
import 'package:multi_vendor/features/main/search/logic/search_products_cubit.dart';
import 'package:multi_vendor/features/main/search/view/widget/search_history.dart';

import '../logic/search_product_history_cubit.dart';


class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}


class _SearchScreenState extends State<SearchScreen> {

  SearchProductsCubit get searchCubit => context.read<SearchProductsCubit>();
  SearchProductHistoryCubit get historyCubit => context.read<SearchProductHistoryCubit>();

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16.h,
      children: [
        Gap.tiny(),
        AppSearchbar(
          onSubmit: historyCubit.saveToHistory,
           onQueryChanged: searchCubit.search,
          title:  const SloganText(),
        ),
        SearchBuilder(
          builder: BaseBlocConsumer<SearchProductHistoryCubit, List<String>>(
            successBuilder: (items) => SearchHistory(
              searchHistory:items,
              onRemoveItem: historyCubit.onRemoveItem,
              onRemoveAll: historyCubit.onRemoveAll,
            ),
          ),
          resultBuilder:
              Expanded(
                child: BaseBlocConsumer<SearchProductsCubit, List<ProductModel>>(
                  successBuilder: (items) => ProductGrid(products: items),
                  loadingBuilder: () {
                    final product = ProductModel.fake();
                    return ProductGrid(
                      products: List.generate(10, (_) => product),
                    );
                  },
                  failureBuilder: AppStates.error,
                  emptyBuilder: AppStates.empty,
                ),
              ),
        ),
      ],
    ).appPaddingHr;
  }

}
