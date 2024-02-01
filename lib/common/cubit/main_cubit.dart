import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

class MainCubit extends Cubit<int> {
  MainCubit() : super(0);

  void setIndex(int index){
    emit(index);
  }
}
