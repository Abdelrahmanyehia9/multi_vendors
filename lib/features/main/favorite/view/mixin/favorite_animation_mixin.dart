
import 'package:flutter/material.dart';

mixin FavoriteAnimationMixin<T extends StatefulWidget> on State<T>, SingleTickerProviderStateMixin<T> {
  late final AnimationController favoriteAnimController;
  late final Animation<double> favoriteScaleAnim;
  late final Animation<double> favoriteParticleAnim;

  @override
  void initState() {
    super.initState();
    favoriteAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    );
    favoriteScaleAnim = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.7), weight: 30),
      TweenSequenceItem(tween: Tween(begin: 1.7, end: 0.75), weight: 30),
      TweenSequenceItem(tween: Tween(begin: 0.75, end: 1.0), weight: 40),
    ]).animate(CurvedAnimation(parent: favoriteAnimController, curve: Curves.easeInOut));

    favoriteParticleAnim = CurvedAnimation(
      parent: favoriteAnimController,
      curve: Curves.easeInOut,
    );
  }
  void playFavoriteAnimation() => favoriteAnimController.forward(from: 0);

  @override
  void dispose() {
    favoriteAnimController.dispose();
    super.dispose();
  }


}