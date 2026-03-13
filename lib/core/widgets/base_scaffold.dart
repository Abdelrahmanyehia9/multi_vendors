import 'package:flutter/material.dart';

class BaseScaffold extends StatelessWidget {
  final Widget? body ;
  final Widget? bottomNavigationBar ;
  final bool topSafeArea ;
  final PreferredSizeWidget? appBar ;
  const BaseScaffold({super.key,this.topSafeArea = true, this.appBar  ,this.body, this.bottomNavigationBar});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: appBar,
      body: _buildBody(),
      bottomNavigationBar: bottomNavigationBar,
    );
  }

  Widget? _buildBody(){
    if(appBar!=null) return body ;
    return SafeArea(
        top: topSafeArea,
        child:body?? const SizedBox.shrink());
  }
}
