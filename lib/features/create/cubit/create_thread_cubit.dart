import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forum_app/common/utils/api_client.dart';

import 'package:forum_app/features/home/models/thread.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:shared_preferences/shared_preferences.dart';

part 'create_thread_state.dart';

class CreateThreadCubit extends Cubit<CreateThreadState> {
  CreateThreadCubit() : super(CreateThreadInitial());
  void createThread({
    required String content,
    XFile? image
    })async{
  emit(CreateThreadLoading());
  try {
  final formData= FormData.fromMap({
    "content":content,
    if(image!=null)
    "image": await MultipartFile.fromFile(image.path,filename: image.name)
  });

 


  final resp= await dioClient.post('/threads/',
    data: formData
  );

   
    emit(CreateThreadSuccess(Thread.fromJson(resp.data)));
  } catch (e) {
    emit(CreateThreadFailure(e.toString()));
    print(e);
  }
  }
 
   
   }

