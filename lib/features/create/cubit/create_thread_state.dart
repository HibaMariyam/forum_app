part of 'create_thread_cubit.dart';

@immutable
sealed class CreateThreadState {}

final class CreateThreadInitial extends CreateThreadState {}
final class CreateThreadLoading extends CreateThreadState {}
final class CreateThreadSuccess extends CreateThreadState {
  final Thread thread;
  CreateThreadSuccess(this.thread);
}
final class CreateThreadFailure extends CreateThreadState {
  final String message;
  CreateThreadFailure(this.message);
}