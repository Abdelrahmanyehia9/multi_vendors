import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/cubit/base_bloc_consumer.dart';
import 'package:multi_vendor/core/models/news_model.dart';
import 'package:multi_vendor/core/widgets/app_states.dart';
import 'package:multi_vendor/core/widgets/cards/news_card.dart';
import 'package:multi_vendor/features/news/logic/news_cubit.dart';
import '../../../core/widgets/app_search_bar.dart';
import '../../../core/widgets/scaffold/base_appbar.dart';
import '../../../core/widgets/scaffold/base_scaffold.dart';

class AllNewsScreen extends StatelessWidget {
  const AllNewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<NewsCubit>();
    return BaseScaffold(
      appBar: BaseAppBar(title:"News"),
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
          ),
          Expanded(
          child: BaseBlocConsumer<NewsCubit, List<NewsModel>>(
            successBuilder:  _builder,
            loadingBuilder: ()=>_builder(List.generate(10, (i)=>NewsModel.fake())),
            emptyBuilder: AppStates.empty,
            failureBuilder: AppStates.error,
          ),
        )
        ],
      ),
    );
  }


  Widget _builder(List<NewsModel> news) =>  NewsList(news: news);
}
