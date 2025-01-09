import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_v2/edit_task/models/reminder_time.dart';
import 'package:todo_app_v2/theme/theme.dart';
import 'package:todos_repository/todos_repository.dart';

part 'edit_task_event.dart';
part 'edit_task_state.dart';

class EditTaskBloc extends Bloc<EditTaskEvent, EditTaskState> {
  EditTaskBloc({
    required TodosRepository tasksRepository,
    required TaskEntity? initalTask,
    required CategoryEntity? initialCategory,
  })  : _tasksRepository = tasksRepository,
        super(
          EditTaskState(
            initialTodo: initalTask,
            title: initalTask?.title ?? '',
            notate: initalTask?.notate ?? '',
            important: initalTask?.important ?? false,
            category: initialCategory,
            color: initalTask?.color ?? baseColor.value,
            subtasks: initalTask?.subtasks ?? [],
          ),
        ) {
    on<EditTaskTitleChanged>(_onTitleChanged);
    on<EditTaskDescriptionChanged>(_onDescriptionChanged);
    on<EditTaskSubmitted>(_onSubmitted);
    on<EditTaskLoadCategories>(_onLoadCategories);
    on<EditTaskCategoryChanged>(_onCategoryChanged);
    on<EditTaskImportantStatusChanged>(_onIsImportantChanged);
    on<EditTaskColorChanged>(_onColorChanged);
    on<EditTaskSubtaskCreated>(_onSubtaskCreated);
    on<EditTaskSubtaskDeleted>(_onSubtaskDeleted);
    on<EditTaskSubtaskChanged>(_onSubtaskChanged);
    on<EditTaskSubtaskCompleted>(_onSubtaskCompleted);
    on<EditTaskDateChanged>(_onDateChanged);
    on<EditTaskTimeChanged>(_onTimeChanged);
    on<EditTaskNotificationTimeChanged>(_onNotificationTimeChanged);
    add(const EditTaskLoadCategories());
  }

  final TodosRepository _tasksRepository;

  void _onTitleChanged(
    EditTaskTitleChanged event,
    Emitter<EditTaskState> emit,
  ) {
    emit(state.copyWith(title: event.title));
  }

  void _onDescriptionChanged(
    EditTaskDescriptionChanged event,
    Emitter<EditTaskState> emit,
  ) {
    emit(state.copyWith(notate: event.notate));
  }

  void _onCategoryChanged(
    EditTaskCategoryChanged event,
    Emitter<EditTaskState> emit,
  ) {
    final newState = state.copyWith(category: event.category);
    emit(newState);
  }

  void _onIsImportantChanged(
    EditTaskImportantStatusChanged event,
    Emitter<EditTaskState> emit,
  ) {
    emit(state.copyWith(important: event.isImportant));
  }

  void _onColorChanged(
    EditTaskColorChanged event,
    Emitter<EditTaskState> emit,
  ) {
    emit(state.copyWith(color: event.color));
  }

  void _onSubtaskCreated(
    EditTaskSubtaskCreated event,
    Emitter<EditTaskState> emit,
  ) {
    final subtaskList = [...state.subtasks];
    final randomId = Random().nextInt(10000);
    final newSubtask = SubTask(id: randomId, title: '');
    subtaskList.add(newSubtask);

    emit(state.copyWith(subtasks: subtaskList));
  }

  void _onSubtaskDeleted(
    EditTaskSubtaskDeleted event,
    Emitter<EditTaskState> emit,
  ) {
    final subtaskList =
        state.subtasks.where((subtast) => subtast.id != event.id).toList();

    emit(state.copyWith(subtasks: subtaskList));
  }

  void _onSubtaskChanged(
    EditTaskSubtaskChanged event,
    Emitter<EditTaskState> emit,
  ) {
    final updatesSubtasks = state.subtasks.map((subtask) {
      if (subtask.id == event.id) {
        return subtask.copyWith(title: event.title);
      }
      return subtask;
    }).toList();

    emit(state.copyWith(subtasks: updatesSubtasks));
  }

  void _onSubtaskCompleted(
    EditTaskSubtaskCompleted event,
    Emitter<EditTaskState> emit,
  ) {
    final updatedSubtasks = state.subtasks.map((subtask) {
      if (subtask.id == event.id) {
        return subtask.copyWith(completed: event.completed);
      }
      return subtask;
    }).toList();

    emit(state.copyWith(subtasks: updatedSubtasks));
  }

  Future<void> _onSubmitted(
    EditTaskSubmitted event,
    Emitter<EditTaskState> emit,
  ) async {
    final loadingState = state.copyWith(status: EditTaskStatus.loading);
    emit(loadingState);

    //TODO: Add date, times, and create
    //notification repository and create copies of task

    final task = state.initialTodo ?? TaskEntity(title: '')
      ..title = state.title
      ..notate = event.description
      ..color = state.color
      ..important = state.important;

    task.category.value = state.category;

    if (state.subtasks.isNotEmpty) {
      task.subtasks = state.subtasks;
    }

    try {
      await _tasksRepository.creatTask(task);
      emit(state.copyWith(status: EditTaskStatus.success));
    } catch (e) {
      emit(state.copyWith(status: EditTaskStatus.failure));
    }
  }

  Future<void> _onLoadCategories(
    EditTaskLoadCategories event,
    Emitter<EditTaskState> emit,
  ) async {
    final categories = await _tasksRepository.getAllCategories();
    final newState = state.copyWith(categories: categories);
    emit(newState);
  }

  Future<void> _onDateChanged(
    EditTaskDateChanged event,
    Emitter<EditTaskState> emit,
  ) async {
    if (event.taskDate == null) {
      emit(state.copyWith(taskDate: event.taskDate, hasDate: false));
      add(const EditTaskTimeChanged(hasTime: false));
    } else {
      emit(state.copyWith(taskDate: event.taskDate, hasDate: true));
    }
  }

  // TODO: рефактор коду
  Future<void> _onTimeChanged(
    EditTaskTimeChanged event,
    Emitter<EditTaskState> emit,
  ) async {
    final taskTime = await event.taskTime;

    if (taskTime != null && state.taskDate != null) {
      final currentDate = state.taskDate!;

      final dateWithTime = DateTime(
        currentDate.year,
        currentDate.month,
        currentDate.day,
        taskTime.hour,
        taskTime.minute,
      );
      emit(state.copyWith(taskDate: dateWithTime, hasTime: true));
    } else {
      if (event.hasTime == false) {
        if (state.hasDate) {
          final currentDate = state.taskDate!;

          final dateWithTime = DateTime(
            currentDate.year,
            currentDate.month,
            currentDate.day,
          );

          emit(state.copyWith(hasTime: false, taskDate: dateWithTime));
        }
        emit(state.copyWith(hasTime: false));
        add(
          const EditTaskNotificationTimeChanged(
            reminderTime: ReminderTime.none,
          ),
        );
      }
    }
  }

  Future<void> _onNotificationTimeChanged(
    EditTaskNotificationTimeChanged event,
    Emitter<EditTaskState> emit,
  ) async {
    if (event.reminderTime == ReminderTime.none) {
      emit(
        state.copyWith(
          notificationReminderTime: event.reminderTime,
          hasNotification: false,
        ),
      );
    } else {
      final newState = state.copyWith(
        notificationReminderTime: event.reminderTime,
        hasNotification: true,
      );
      emit(newState);
    }
  }
}
