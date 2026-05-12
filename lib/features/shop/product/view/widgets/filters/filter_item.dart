part of 'product_filters_sheet.dart';

class _FilterItem extends StatelessWidget {
  final Widget child ;
  final String? title ;
  final String? subtitle ;
  const _FilterItem({required this.child , this.title , this.subtitle});

  @override
  Widget build(BuildContext context) {
    return AppExpansionTile(
      initiallyExpanded: false,
      title: title != null ? Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SectionHeader(title: title!),
          if(subtitle != null) Text(subtitle!, style: TextStyles.bodySmall.copyWith(
            color: context.colors.surfaceContainer
          ),)
        ],
      ) : const SizedBox(),
      child: child
    );
  }
}
