import 'package:flutter/material.dart';

mixin SearchMixin<T extends StatefulWidget> on State<T> {
  late final FocusNode node ;
  final TextEditingController controller = TextEditingController();

  Widget body(bool hasFocus, bool hasText);

  Widget listenBuilder(){
    return ListenableBuilder(
      listenable: Listenable.merge([node, controller]),
      builder: (context, _) {
        final hasFocus = node.hasFocus;
        final hasText = controller.text.isNotEmpty;
        return body(hasFocus, hasText);
      },
    );
  }


  @override
  void initState() {
    node = FocusNode();
    node.requestFocus();
    super.initState();
  }

  @override
  void dispose() {
    node.dispose();
    controller.dispose();
    super.dispose();
  }
}