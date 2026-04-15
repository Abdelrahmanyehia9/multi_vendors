import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor/core/extensions/colors.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../cubit/base_state.dart';
import '../errors/exceptions.dart';

class BaseBlocConsumer<B extends BlocBase<BaseState<S>>, S>
    extends StatelessWidget {
  final Widget Function(BaseState data)? builder;
  final Widget Function()? loadingBuilder;
  final Widget Function(S data)? successBuilder;
  final Widget Function(AppException error)? failureBuilder;
  final Widget Function()? emptyBuilder;
  final void Function(S? data)? onSuccess;
  final void Function()? onLoading;
  final void Function(AppException error)? onFailure;
  final void Function()? onEmpty;
  final void Function()? onLoaded;

  final B? bloc;

  const  BaseBlocConsumer({
    super.key,
    this.bloc,
    this.builder,
    this.loadingBuilder,
    this.successBuilder,
    this.failureBuilder,
    this.emptyBuilder,
    this.onLoaded,
    this.onSuccess,
    this.onLoading,
    this.onFailure,
    this.onEmpty,
  });

  @override
  Widget build(BuildContext context) {
    final B cubit = bloc ?? context.read<B>();
    return SkeletonizerConfig(
      data: SkeletonizerConfigData(
        effect: ShimmerEffect(
          baseColor: context.colors.surfaceContainerLow.lighten(),
          highlightColor: context.colors.surfaceContainerLowest,
        ),
        containersColor: context.colors.surfaceContainerLow.lighten(),
      ),
     
      child: BlocConsumer<B, BaseState<S>>(
        bloc: cubit,
        listener: (context, state) {
          if (state.isFailure && onFailure != null) {
            onFailure!(state.error!);
          } else if (state.isLoading && onLoading != null) {
            onLoading!();
          } else if (state.isSuccess && onSuccess != null) {
            onSuccess!(state.data);
          } else if (state.isEmpty && onEmpty != null) {
            onEmpty!();
          } else if (!state.isInitial &&
              !state.isLoading &&
              onLoaded != null && onSuccess ==null
              && onFailure ==null) {
            onLoaded!();
          }
        },
        builder: (context, state) {

          if (state.isLoading && loadingBuilder != null) {

            return Skeletonizer(
              child: loadingBuilder!());
          }
          if (builder != null) {
            return builder!(state);
          }
          if (state.isSuccess && successBuilder != null) {
            return successBuilder!(state.data as S);
          }
          if (state.isFailure) {
            return failureBuilder == null
                ? const SizedBox.shrink()
                : failureBuilder!(state.error!);
          }
          if (state.isEmpty) {
            return emptyBuilder == null
                ? const SizedBox.shrink()
                : emptyBuilder!();
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
