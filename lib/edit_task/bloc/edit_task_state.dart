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
    this.hasDate = false,
    this.taskDate,
    this.hasTime = false,
    this.hasRepeats = false,
    this.repeatDuringWeek = const [],
    this.hasEndDateOfRepeatedly = false,
    this.endDateOfRepeatedly,
    this.repeatDuringDay = const [],
    this.notificationReminderTime = ReminderTime.none,
    this.hasNotification = false,
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
  final bool hasDate;
  final DateTime? taskDate;
  final bool hasTime;
  final bool hasRepeats;
  final List<int> repeatDuringWeek;
  final bool hasEndDateOfRepeatedly;
  final DateTime? endDateOfRepeatedly;
  final List<DateTime?> repeatDuringDay;
  final ReminderTime notificationReminderTime;
  final bool hasNotification;

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
    bool? hasDate,
    DateTime? taskDate,
    bool? hasTime,
    bool? hasRepeats,
    List<int>? repeatDuringWeek,
    bool? hasEndDateOfRepeatedly,
    DateTime? endDateOfRepeatedly,
    List<DateTime?>? repeatDuringDay,
    ReminderTime? notificationReminderTime,
    bool? hasNotification,
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
      hasDate: hasDate ?? this.hasDate,
      taskDate: hasDate == false ? null : taskDate ?? this.taskDate,
      hasTime: hasTime ?? this.hasTime,
      hasRepeats: hasRepeats ?? this.hasRepeats,
      repeatDuringWeek: repeatDuringWeek ?? this.repeatDuringWeek,
      hasEndDateOfRepeatedly:
          hasEndDateOfRepeatedly ?? this.hasEndDateOfRepeatedly,
      endDateOfRepeatedly: hasEndDateOfRepeatedly == false
          ? null
          : endDateOfRepeatedly ?? this.endDateOfRepeatedly,
      repeatDuringDay: repeatDuringDay ?? this.repeatDuringDay,
      notificationReminderTime:
          notificationReminderTime ?? this.notificationReminderTime,
      hasNotification: hasNotification ?? this.hasNotification,
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
        hasDate,
        repeatDuringWeek,
        categories,
        subtasks,
        notificationReminderTime,
        hasEndDateOfRepeatedly,
        endDateOfRepeatedly,
        hasNotification,
      ];
}

final class EditTaskInitial extends EditTaskState {}
