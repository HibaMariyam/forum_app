import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

import 'package:forum_app/common/utils/api_client.dart';
import 'package:forum_app/features/home/models/thread.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';


part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  void getHomeData()async{
    emit(HomeLoading());
    try {
  
      final resp=await dioClient.get('/threads/',
      );
      final List<Thread> threads=[];
      for(var thread in resp.data){
        threads.add(Thread.fromJson(thread));
      }
      emit(HomeSuccess(threads));
    } catch (e) {
      emit(HomeFailure(e.toString()));
    }
  }
}
