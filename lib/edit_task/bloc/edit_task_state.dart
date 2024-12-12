part of 'edit_task_bloc.dart';

sealed class EditTaskState extends Equatable {
  const EditTaskState();
  
  @override
  List<Object> get props => [];
}

final class EditTaskInitial extends EditTaskState {}
