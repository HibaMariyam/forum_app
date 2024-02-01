part of 'edit_cubit.dart';

@immutable
sealed class EditState {}

final class EditInitial extends EditState {}
final class EditLoading extends EditState {}
final class EditSuccess extends EditState {
  final Thread thread;
  EditSuccess(this.thread);
}
final class EditFailure extends EditState {
  final String message;
  EditFailure(this.message);
}
