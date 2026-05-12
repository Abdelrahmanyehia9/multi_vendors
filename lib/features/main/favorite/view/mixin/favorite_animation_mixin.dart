
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
      duration: const Duration(milliseconds: 600),
    );
    favoriteScaleAnim = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.4), weight: 30),
      TweenSequenceItem(tween: Tween(begin: 1.4, end: 0.85), weight: 30),
      TweenSequenceItem(tween: Tween(begin: 0.85, end: 1.0), weight: 40),
    ]).animate(CurvedAnimation(parent: favoriteAnimController, curve: Curves.easeOut));

    favoriteParticleAnim = CurvedAnimation(
      parent: favoriteAnimController,
      curve: Curves.easeOut,
    );
  }
  void playFavoriteAnimation() => favoriteAnimController.forward(from: 0);

  @override
  void dispose() {
    favoriteAnimController.dispose();
    super.dispose();
  }


}