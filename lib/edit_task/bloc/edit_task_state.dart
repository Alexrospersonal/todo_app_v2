part of 'edit_task_bloc.dart';

enum EditTaskStatus { initial, loading, success, failure }

extension EditTodoStatusX on EditTaskStatus {
  bool get isLoadingOrSuccess => [
        EditTaskStatus.loading,
        EditTaskStatus.success,
      ].contains(this);
}

final class EditTaskState extends Equatable {
  const EditTaskState({
    this.categories = const [],
    this.status = EditTaskStatus.initial,
    this.initialTodo,
    this.title = '',
    this.notate = '',
    this.subtasks = const [],
    this.important = false,
    this.color = -1,
    this.category,
    this.taskDate,
    this.hasTime = false,
    this.hasRepeats = false,
    this.repeatDuringWeek = const [],
    this.endDateOfRepeatedly,
    this.repeatDuringDay = const [],
  });

  final String title;
  final String notate;
  final List<SubTask> subtasks;
  final List<CategoryEntity> categories;
  final EditTaskStatus status;
  final TaskEntity? initialTodo;
  final int color;
  final bool important;
  final CategoryEntity? category;
  final DateTime? taskDate;
  final bool hasTime;
  final bool hasRepeats;
  final List<int> repeatDuringWeek;
  final DateTime? endDateOfRepeatedly;
  final List<DateTime?> repeatDuringDay;

  bool get isNewTodo => initialTodo == null;

  EditTaskState copyWith({
    List<CategoryEntity>? categories,
    EditTaskStatus? status,
    TaskEntity? initialTodo,
    String? title,
    List<SubTask>? subtasks,
    String? notate,
    bool? important,
    int? color,
    CategoryEntity? category,
    DateTime? taskDate,
    bool? hasTime,
    bool? hasRepeats,
    List<int>? repeatDuringWeek,
    DateTime? endDateOfRepeatedly,
    List<DateTime?>? repeatDuringDay,
  }) {
    return EditTaskState(
      categories: categories ?? this.categories,
      title: title ?? this.title,
      status: status ?? this.status,
      subtasks: subtasks ?? this.subtasks,
      initialTodo: initialTodo ?? this.initialTodo,
      notate: notate ?? this.notate,
      important: important ?? this.important,
      color: color ?? this.color,
      category: category ?? this.category,
      taskDate: taskDate,
      hasTime: hasTime ?? this.hasTime,
      hasRepeats: hasRepeats ?? this.hasRepeats,
      repeatDuringWeek: repeatDuringWeek ?? this.repeatDuringWeek,
      endDateOfRepeatedly: endDateOfRepeatedly ?? this.endDateOfRepeatedly,
      repeatDuringDay: repeatDuringDay ?? this.repeatDuringDay,
    );
  }

  @override
  List<Object?> get props => [
        status,
        title,
        notate,
        important,
        category,
        color,
        taskDate,
        hasTime,
        hasRepeats,
        repeatDuringWeek,
        categories,
        subtasks,
      ];
}

final class EditTaskInitial extends EditTaskState {}
