import 'package:flutter/material.dart';
import 'package:multi_vendor/core/extensions/widget.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_appbar.dart';

class BaseScaffold extends StatelessWidget {
  final Widget? body ;
  final Widget? bottomNavigationBar ;
  final bool topSafeArea ;
  final BaseAppBar? appBar ;
  final double paddingHr  ;
  final double paddingVr ;
  const BaseScaffold({super.key, this.paddingHr=16,this.paddingVr=16,this.topSafeArea = true, this.appBar  ,this.body, this.bottomNavigationBar});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: appBar,
      body: _buildBody()?.paddingHr(paddingHr).paddingVr(paddingVr),
      bottomNavigationBar: bottomNavigationBar,
    );
  }

  Widget? _buildBody(){
    return SafeArea(
        top: topSafeArea,
        child:body?? const SizedBox.shrink()
    );
  }
}
