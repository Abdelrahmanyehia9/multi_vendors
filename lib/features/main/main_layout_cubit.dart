import 'package:flutter_bloc/flutter_bloc.dart';

class MainLayoutCubit extends Cubit<int>{
  int selectedPage = 2 ;

  MainLayoutCubit() :super(2);

void init(int? initially)=> changePage(initially);
  void changePage(int? index) {
    if(index == null) return;
    selectedPage = index;
    emit(index);
  }
  void onBackPressed(bool didPop) {
    if (!didPop) {
      changePage(2);
    }
  }
  bool get canPop => selectedPage== 2;

}