import 'package:flutter_bloc/flutter_bloc.dart';

class MainLayoutCubit extends Cubit<int>{
  int selectedPage = 0 ;

  MainLayoutCubit() :super(0);

void init(int? initially)=> changePage(initially);
  void changePage(int? index) {
    if(index == null) return;
    selectedPage = index;
    emit(index);
  }
  void onBackPressed(bool didPop) {
    if (!didPop) {
      changePage(0);
    }
  }
  bool get canPop => selectedPage== 0;

}