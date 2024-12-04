// ignore_for_file: cascade_invocations

import 'package:isar/isar.dart';
import 'package:todo_db_api/src/models/category.dart';

part 'task.g.dart';

/// Task model for the Isar database.
///
/// Used to store data about tasks, including categories,
/// repetitions, reminders, and more.
@collection
class TaskEntity {
  /// Constructor to create a task.
  ///
  /// [title] is a required parameter for the task's title.
  TaskEntity({required this.title});

  /// Unique identifier for the task, generated automatically.
  Id id = Isar.autoIncrement;

  /// Title of the task.
  String title;

  /// Indicates if the task is important.
  bool important = false;

  /// The category to which the task belongs.
  final IsarLink<CategoryEntity> category = IsarLink<CategoryEntity>();

  /// Reference to the original task (for copies or recurring tasks).
  final IsarLink<TaskEntity> originalTask = IsarLink<TaskEntity>();

  /// Note for the task.
  String? notate;

  /// The date when the task is scheduled.
  @Index()
  DateTime? taskDate;

  /// Indicates whether the task has a specific time.
  bool hasTime = false;

  /// Task color (stored as an integer).
  int? color;

  /// Indicates whether the task has repetitions.
  bool hasRepeats = false;

  /// Indicates whether the task is completed.
  bool isFinished = false;

  /// Indicates whether the task is a copy.
  bool isCopy = false;

  /// Notification ID, if any.
  int? notificationId;

  /// Days of the week when the task repeats (day number).
  List<int>? repeatDuringWeek;

  /// The end date of the recurring task.
  @Index()
  DateTime? endDateOfRepeatedly;

  /// Time intervals for repetition during the day.
  List<DateTime?>? repeatDuringDay;

  /// Creates a copy of the task with updated values.
  TaskEntity copyWith({
    String? title,
    String? notate,
    DateTime? taskDate,
    bool? hasTime,
    bool? isFinished,
    bool? hasRepeats,
    bool? important,
    bool? isCopy,
    int? color,
    int? notificationId,
    List<int>? repeatDuringWeek,
    DateTime? endDateOfRepeatedly,
    List<DateTime?>? repeatDuringDay,
  }) {
    final task = TaskEntity(title: title ?? this.title);

    task.notate = notate ?? this.notate;
    task.taskDate = taskDate ?? this.taskDate;
    task.hasTime = hasTime ?? this.hasTime;
    task.hasRepeats = hasRepeats ?? this.hasRepeats;
    task.important = important ?? this.important;
    task.isFinished = isFinished ?? this.isFinished;
    task.color = color ?? this.color;
    task.isCopy = isCopy ?? this.isCopy;
    task.notificationId = notificationId ?? this.notificationId;
    task.repeatDuringWeek = repeatDuringWeek ?? this.repeatDuringWeek;
    task.endDateOfRepeatedly = endDateOfRepeatedly ?? this.endDateOfRepeatedly;
    task.repeatDuringDay = repeatDuringDay ?? this.repeatDuringDay;

    return task;
  }

  /// Converts the task into JSON format.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'notate': notate,
      'taskDate': taskDate?.toIso8601String(),
      'hasTime': hasTime,
      'hasRepeats': hasRepeats,
      'important': important,
      'color': color,
    };
  }
}
