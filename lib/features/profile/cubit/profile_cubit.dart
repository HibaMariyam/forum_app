import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:forum_app/common/utils/api_client.dart';
import 'package:forum_app/features/home/models/thread.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());
  void getProfileData({required int userId})async{
    emit(ProfileLoading());
    try {
   
      final resp=await dioClient.get('/threads/?user=$userId',
     
     );
      final List<Thread> threads=[];
      for(var thread in resp.data){
        threads.add(Thread.fromJson(thread));
      }
      emit(ProfileSuccess(threads));
    } 
    catch (e) {
      emit(ProfileFailure(e.toString()));
    }
  }
}
