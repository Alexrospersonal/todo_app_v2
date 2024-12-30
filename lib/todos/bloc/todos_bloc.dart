import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app_v2/todos/models/tasks_filters.dart';
import 'package:todos_repository/todos_repository.dart';

part 'todos_event.dart';
part 'todos_state.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  TodosBloc({required TodosRepository todosRepository})
      : _todosRepository = todosRepository,
        super(const TodosState()) {
    on<TodosSubscriptionRequested>(_onSubscriptionRequested);
    on<TodosTodoCompletionToggled>(_onTodoCompletionToggled);
    on<TodosTodoDeleted>(_onTodoDeleted);
    on<TodosUndoDeletionRequested>(_onUndoDeletionRequested);
    on<TodosOverviewFilterChanged>(_onFilterChanged);
  }

  final TodosRepository _todosRepository;

  Future<void> _onSubscriptionRequested(
    TodosSubscriptionRequested event,
    Emitter<TodosState> emit,
  ) async {
    emit(state.copyWith(status: () => TodosOverviewStatus.loading));

    await emit.forEach<List<TaskEntity>>(
      _todosRepository.getAllTasks(),
      onData: (todos) {
        final newState = state.copyWith(
          status: () => TodosOverviewStatus.success,
          todos: () => todos,
        );
        return newState;
      },
      onError: (_, __) => state.copyWith(
        status: () => TodosOverviewStatus.failure,
      ),
    );
  }

  Future<void> _onTodoCompletionToggled(
    TodosTodoCompletionToggled event,
    Emitter<TodosState> emit,
  ) async {
    final task = event.todo..isFinished = event.isCompleted;

    await _todosRepository.creatTask(task);
  }

  Future<void> _onTodoDeleted(
    TodosTodoDeleted event,
    Emitter<TodosState> emit,
  ) async {
    emit(state.copyWith(lastDeletedTodo: () => event.todo));
    await _todosRepository.deleteTask(event.todo.id);
  }

  Future<void> _onUndoDeletionRequested(
    TodosUndoDeletionRequested event,
    Emitter<TodosState> emit,
  ) async {
    assert(
      state.lastDeletedTodo != null,
      'Last deleted todo can not be null.',
    );

    final todo = state.lastDeletedTodo!;
    emit(state.copyWith(lastDeletedTodo: () => null));
    await _todosRepository.creatTask(todo);
  }

  void _onFilterChanged(
    TodosOverviewFilterChanged event,
    Emitter<TodosState> emit,
  ) {
    emit(state.copyWith(filter: () => event.filter));
  }
}
