part of 'product_filters_sheet.dart';

class _FilterItem extends StatelessWidget {
  final Widget child ;
  final bool initiallyExpanded;
  final String? title ;
  final String? subtitle ;
  const _FilterItem(this.child ,{this.initiallyExpanded = true , this.title , this.subtitle});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      initiallyExpanded: initiallyExpanded,
      childrenPadding: EdgeInsets.zero,
      tilePadding: EdgeInsets.zero,
      iconColor: context.colors.surfaceContainerHigh,
      title: title != null ? Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SectionHeader(title: title!),
          if(subtitle != null) Text(subtitle!, style: TextStyles.bodySmall.copyWith(
            color: context.colors.surfaceContainer
          ),)
        ],
      ) : const SizedBox(),
      children: [SizedBox
        (
          width: double.infinity,
          child: child)],
    );
  }
}
