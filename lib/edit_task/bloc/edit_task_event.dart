part of 'edit_task_bloc.dart';

sealed class EditTaskEvent extends Equatable {
  const EditTaskEvent();

  @override
  List<Object> get props => [];
}

final class EditTaskLoadCategories extends EditTaskEvent {
  const EditTaskLoadCategories();
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

final class EditTaskCategoryChanged extends EditTaskEvent {
  const EditTaskCategoryChanged({required this.category});

  final CategoryEntity category;

  @override
  List<Object> get props => [category];
}

final class EditTaskImportantStatusChanged extends EditTaskEvent {
  const EditTaskImportantStatusChanged({required this.isImportant});

  final bool isImportant;

  @override
  List<Object> get props => [isImportant];
}

final class EditTaskColorChanged extends EditTaskEvent {
  const EditTaskColorChanged({required this.color});

  final int color;

  @override
  List<Object> get props => [color];
}

final class EditTaskSubtaskCreated extends EditTaskEvent {
  const EditTaskSubtaskCreated();
}

final class EditTaskSubtaskDeleted extends EditTaskEvent {
  const EditTaskSubtaskDeleted({required this.id});

  final int id;

  @override
  List<Object> get props => [id];
}

final class EditTaskSubtaskChanged extends EditTaskEvent {
  const EditTaskSubtaskChanged({
    required this.id,
    required this.title,
  });

  final int id;
  final String title;

  @override
  List<Object> get props => [id, title];
}

final class EditTaskSubtaskCompleted extends EditTaskEvent {
  const EditTaskSubtaskCompleted({
    required this.id,
    required this.completed,
  });

  final int id;
  final bool completed;

  @override
  List<Object> get props => [id, completed];
}

final class EditTaskSubmitted extends EditTaskEvent {
  const EditTaskSubmitted({required this.description});

  final String description;

  @override
  List<Object> get props => [description];
}

final class EditTaskDateChanged extends EditTaskEvent {
  const EditTaskDateChanged({this.taskDate});

  final DateTime? taskDate;
}

final class EditTaskTimeChanged extends EditTaskEvent {
  const EditTaskTimeChanged({this.taskTime});

  final Future<TimeOfDay?>? taskTime;
}
