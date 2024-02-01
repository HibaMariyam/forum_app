import 'package:bloc/bloc.dart';
import 'package:forum_app/common/utils/api_client.dart';
import 'package:forum_app/features/home/models/thread.dart';
import 'package:meta/meta.dart';

part 'edit_state.dart';

class EditCubit extends Cubit<EditState> {
  EditCubit() : super(EditInitial());
void editThread(String content,int id)async{
  emit(EditLoading());
  try {
    final resp=await dioClient.patch('/threads/$id/',
    data: {
   'content':content
   }
    );
    emit(EditSuccess(Thread.fromJson(resp.data)));
  } catch (e) {
    emit(EditFailure(e.toString()));
  }
}

}
