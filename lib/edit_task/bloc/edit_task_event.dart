part of 'edit_task_bloc.dart';

sealed class EditTaskEvent extends Equatable {
  const EditTaskEvent();

  @override
  List<Object> get props => [];
}

final class EditTaskTitleChanged extends EditTaskEvent {
  const EditTaskTitleChanged({required this.title});

  final String title;

  @override
  List<Object> get props => [title];
}

final class EditTaskDescriptionChanged extends EditTaskEvent {
  const EditTaskDescriptionChanged({required this.notate});

  final String notate;

  @override
  List<Object> get props => [notate];
}

final class EditTaskSubmitted extends EditTaskEvent {
  const EditTaskSubmitted();
}
