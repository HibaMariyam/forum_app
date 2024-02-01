import 'package:bloc/bloc.dart';
import 'package:forum_app/common/utils/api_client.dart';
import 'package:forum_app/features/home/models/thread.dart';
import 'package:meta/meta.dart';

part 'delete_state.dart';

class DeleteCubit extends Cubit<DeleteState> {
  DeleteCubit() : super(DeleteInitial());
  void deleteThread(int id)async{
  emit(DeleteLoading());
  try {
    await dioClient.delete('/threads/$id/');
    emit(DeleteSuccess());
  } catch (e) {
    emit(DeleteFailure(e.toString()));
  }
}
}
