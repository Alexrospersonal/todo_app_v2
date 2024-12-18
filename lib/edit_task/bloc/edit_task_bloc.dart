import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app_v2/theme/theme.dart';
import 'package:todos_repository/todos_repository.dart';

part 'edit_task_event.dart';
part 'edit_task_state.dart';

class EditTaskBloc extends Bloc<EditTaskEvent, EditTaskState> {
  EditTaskBloc({
    required TodosRepository tasksRepository,
    required TaskEntity? initalTask,
  })  : _tasksRepository = tasksRepository,
        super(
          EditTaskState(
            initialTodo: initalTask,
            title: initalTask?.title ?? '',
            notate: initalTask?.notate ?? '',
          ),
        ) {
    on<EditTaskTitleChanged>(_onTitleChanged);
    on<EditTaskDescriptionChanged>(_onDescriptionChanged);
    on<EditTaskSubmitted>(_onSubmitted);
    on<EditTaskLoadCategories>(_onLoadCategories);
    on<EditTaskCategoryChanged>(_onCategoryChanged);
    on<EditTaskImportantStatusChanged>(_onIsImportantChanged);
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

  Future<void> _onSubmitted(
    EditTaskSubmitted event,
    Emitter<EditTaskState> emit,
  ) async {
    final loadingState = state.copyWith(status: EditTaskStatus.loading);
    emit(loadingState);
    final task = (state.initialTodo ?? TaskEntity(title: '')).copyWith(
      title: state.title,
      notate: state.notate,
    );

    task.category.value = state.category;

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
}
