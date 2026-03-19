import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/widget.dart';
import 'package:multi_vendor/core/widgets/cards/product_card.dart';
import 'package:multi_vendor/core/widgets/gap.dart';
import 'package:multi_vendor/core/widgets/search_builder.dart';
import 'package:multi_vendor/features/main/search/view/widget/search_history.dart';
import '../../../../core/cubit/search_cubit.dart';
import '../../home/view/home_screen.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final searchCubit = context.read<SearchCubit>();
    return Column(
      spacing: 16.h,
      children: [
        Gap.tiny(),
        StoreSearchBar(
          focusNode: searchCubit.focusNode,
          controller: searchCubit.controller,
        ),
        const SearchBuilder(
          builder: SearchHistory(),
          resultBuilder: Expanded(child: ProductGrid()),
        ),
      ],
    ).appPaddingHr;
  }
}

