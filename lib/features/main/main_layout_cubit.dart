import 'package:flutter_bloc/flutter_bloc.dart';

class MainLayoutCubit extends Cubit<int> {
  MainLayoutCubit() : super(0);
  int selectedPage = 0;
  DateTime? _lastBackPress;
  void init(int? initially) => changePage(initially);
  void changePage(int? index) {
    if (index == null) return;
    selectedPage = index;
    emit(index);
  }
  void onPopScoped({void Function()? onConfirm , void Function()? onExit}) {
    if (selectedPage != 0) {
      changePage(0);
      return ;
    }
    final now = DateTime.now();
    if (_lastBackPress == null || now.difference(_lastBackPress!) > const Duration(seconds: 2)) {
      _lastBackPress = now;
      onConfirm?.call();
      return ;
    }
    onExit?.call();
    return ;
  }
}