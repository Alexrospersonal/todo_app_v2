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
    this.status = EditTaskStatus.initial,
    this.initialTodo,
    this.title = '',
    this.notate = '',
    this.important = false,
    this.color = baseColor,
    this.category,
    this.taskDate,
    this.hasTime = false,
    this.hasRepeats = false,
    this.repeatDuringWeek = const [],
    this.endDateOfRepeatedly,
    this.repeatDuringDay = const [],
  });

  final EditTaskStatus status;
  final TaskEntity? initialTodo;
  final String title;
  final String notate;
  final bool important;
  final Color color;
  final CategoryEntity? category;
  final DateTime? taskDate;
  final bool hasTime;
  final bool hasRepeats;
  final List<int> repeatDuringWeek;
  final DateTime? endDateOfRepeatedly;
  final List<DateTime?> repeatDuringDay;

  bool get isNewTodo => initialTodo == null;

  EditTaskState copyWith({
    EditTaskStatus? status,
    TaskEntity? initialTodo,
    String? title,
    String? notate,
    bool? important,
    Color? color,
    CategoryEntity? category,
    DateTime? taskDate,
    bool? hasTime,
    bool? hasRepeats,
    List<int>? repeatDuringWeek,
    DateTime? endDateOfRepeatedly,
    List<DateTime?>? repeatDuringDay,
  }) {
    return EditTaskState(
      status: status ?? this.status,
      initialTodo: initialTodo ?? this.initialTodo,
      notate: notate ?? this.notate,
      important: important ?? this.important,
      color: color ?? this.color,
      category: category ?? this.category,
      taskDate: taskDate ?? this.taskDate,
      hasTime: hasTime ?? this.hasTime,
      hasRepeats: hasRepeats ?? this.hasRepeats,
      repeatDuringWeek: repeatDuringWeek ?? this.repeatDuringWeek,
      endDateOfRepeatedly: endDateOfRepeatedly ?? this.endDateOfRepeatedly,
      repeatDuringDay: repeatDuringDay ?? this.repeatDuringDay,
    );
  }

  @override
  List<Object> get props => [
        status,
        title,
        notate,
        important,
        color,
        hasTime,
        hasRepeats,
        repeatDuringWeek,
      ];
}

final class EditTaskInitial extends EditTaskState {}
