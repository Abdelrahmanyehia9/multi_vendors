import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/cubit/base_bloc_consumer.dart';
import 'package:multi_vendor/core/extensions/widget.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';
import 'package:multi_vendor/core/widgets/app_states.dart';
import 'package:multi_vendor/core/widgets/overlays/widget_overlay.dart';
import 'package:multi_vendor/features/news/logic/news_cubit.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_appbar.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_scaffold.dart';
import 'package:multi_vendor/shared/data/models/news_model.dart';
import 'package:multi_vendor/shared/view/widgets/app_search_bar.dart';
import 'package:multi_vendor/shared/view/widgets/cards/news_card.dart';
import 'package:multi_vendor/shared/view/widgets/search_builder.dart';

class AllNewsScreen extends StatelessWidget {
  const AllNewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<NewsCubit>();
    return BaseScaffold(
      paddingHr: 0,
      appBar: BaseAppBar(title:AppStrings.news.tr()),
      body: Column(
        spacing: 16.h,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BaseBlocConsumer(
            bloc: cubit,
            builder: (s) {
              if(s.isSuccess || s.isLoading) {
                return AppSearchbar(
                onQueryChanged: cubit.searchNews,
            );
              }
              return const SizedBox.shrink();
            },
          ).appPaddingHr,
          Expanded(
            child: SearchBuilder(
              builder:(_,hasFocus)=> WidgetOverlay(
                showOverlay: hasFocus,
                child: BaseBlocConsumer<NewsCubit, List<NewsModel>>(
                    successBuilder:  _builder,
                    loadingBuilder: ()=>_builder(List.generate(10, (i)=>NewsModel.fake())),
                    emptyBuilder: AppStates.empty,
                    failureBuilder: AppStates.error,
                  ).appPaddingHr,
                  )
              ),
            )
        ],
      ),
    );
  }


  Widget _builder(List<NewsModel> news) =>  NewsList(news: news);
}
