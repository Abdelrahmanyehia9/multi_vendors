part of '../splash_screen.dart';

mixin SplashAnimationMixin  on State<SplashScreen>{
  late AnimationController _animController;
  late Animation<Offset> _poweredByAnim;
  late Animation<Offset> _nexyraAnim;




  Future<void> initAnimation({required TickerProvider vsync , required VoidCallback onFinished}) async{
    _animController = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 1200),
    );

    _poweredByAnim = Tween<Offset>(
      begin: const Offset(-1.8, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animController,
      curve: const Interval(0.0, 0.9, curve: Curves.easeOut),
    ));

    _nexyraAnim = Tween<Offset>(
      begin: const Offset(1.8, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animController,
      curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
    ));

    await  Future.delayed(const Duration(milliseconds: 500), () {
      _animController.forward().whenComplete(() {
        onFinished.call();
      });
    });
  }



}