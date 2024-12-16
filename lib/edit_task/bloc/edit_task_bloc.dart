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

  Future<void> _onSubmitted(
    EditTaskSubmitted event,
    Emitter<EditTaskState> emit,
  ) async {
    emit(state.copyWith(status: EditTaskStatus.loading));
    final task = (state.initialTodo ?? TaskEntity(title: '')).copyWith(
      title: state.title,
      notate: state.notate,
    );

    try {
      await _tasksRepository.creatTask(task);
      emit(state.copyWith(status: EditTaskStatus.success));
    } catch (e) {
      emit(state.copyWith(status: EditTaskStatus.failure));
    }
  }
}
