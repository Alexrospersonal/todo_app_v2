import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app_v2/todos/models/tasks_filters.dart';
import 'package:todos_repository/todos_repository.dart';

part 'todos_event.dart';
part 'todos_state.dart';

class CategoryObject {
  const CategoryObject({
    required this.categoryEntity,
    required this.isOverdue,
  });

  final CategoryEntity categoryEntity;
  final bool isOverdue;
}

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  TodosBloc({required TodosRepository todosRepository})
      : _todosRepository = todosRepository,
        super(const TodosState()) {
    on<TodosSelectedCategoryLoading>(_onSelectedCategoryLoading);
    on<TodosSelectedCategoryChanged>(_onSelectedCategoryChanged);
    on<TodosSubscriptionRequested>(_onSubscriptionRequested);
    on<TodosCategoriesSubscriptionRequested>(
      _onCategoriesSubscriptionRequested,
    );
    on<TodosTodoCompletionToggled>(_onTodoCompletionToggled);
    on<TodosTodoDeleted>(_onTodoDeleted);
    on<TodosUndoDeletionRequested>(_onUndoDeletionRequested);
    on<TodosOverviewFilterChanged>(_onFilterChanged);
    on<TodosCreateCategoryRequested>(_onCreateCategoryRequested);
    on<TodosCreateNewList>(_onCreateNewList);
  }

  final TodosRepository _todosRepository;

  Future<void> _onSelectedCategoryChanged(
    TodosSelectedCategoryChanged event,
    Emitter<TodosState> emit,
  ) async {
    emit(
      state.copyWith(
        selectedCategory: () => event.category,
      ),
    );

    add(const TodosSubscriptionRequested());
  }

  Future<void> _onSelectedCategoryLoading(
    TodosSelectedCategoryLoading event,
    Emitter<TodosState> emit,
  ) async {
    final categories = await _todosRepository.getAllCategories();
    if (categories.isNotEmpty) {
      emit(
        state.copyWith(selectedCategory: () => categories.first),
      );
    }

    add(const TodosCategoriesSubscriptionRequested());
    add(const TodosSubscriptionRequested());
  }

  Future<void> _onSubscriptionRequested(
    TodosSubscriptionRequested event,
    Emitter<TodosState> emit,
  ) async {
    emit(state.copyWith(status: () => TodosOverviewStatus.loading));

    await emit.forEach<List<TaskEntity>>(
      _todosRepository.getTasksByCategory(state.selectedCategory),
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

  Future<void> _onCategoriesSubscriptionRequested(
    TodosCategoriesSubscriptionRequested event,
    Emitter<TodosState> emit,
  ) async {
    emit(state.copyWith(status: () => TodosOverviewStatus.loading));

    await emit.forEach(
      _todosRepository.getCategoriesStream(),
      onData: (categories) {
        final categoriesObj = categories.map((category) {
          category.tasks.loadSync();
          final overdueTasks = category.tasks.where(
            (task) =>
                task.taskDate != null &&
                task.isFinished == false &&
                task.taskDate!.isBefore(DateTime.now()),
          );
          return CategoryObject(
            categoryEntity: category,
            isOverdue: overdueTasks.isNotEmpty,
          );
        });

        final ifHasOverdueTasks =
            categoriesObj.where((category) => category.isOverdue).isNotEmpty;

        // TODO: переписати логіку для категорії All
        final categoryForAllTasks = CategoryObject(
          categoryEntity: CategoryEntity(name: 'All'),
          isOverdue: ifHasOverdueTasks,
        );

        final newState = state.copyWith(
          status: () => TodosOverviewStatus.success,
          categories: () => [categoryForAllTasks, ...categoriesObj],
        );

        return newState;
      },
      onError: (error, stackTrace) => state.copyWith(
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
    add(const TodosSubscriptionRequested());
    add(const TodosCategoriesSubscriptionRequested());
  }

  Future<void> _onTodoDeleted(
    TodosTodoDeleted event,
    Emitter<TodosState> emit,
  ) async {
    await _todosRepository.deleteTask(event.todo.id);
    emit(state.copyWith(lastDeletedTodo: () => event.todo));
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

  Future<void> _onCreateNewList(
    TodosCreateNewList event,
    Emitter<TodosState> emit,
  ) async {
    await _todosRepository.createCategory(event.categoryTitle);
    add(const TodosCreateCategoryRequested(isOpen: false));
    add(const TodosCategoriesSubscriptionRequested());
  }

  Future<void> _onCreateCategoryRequested(
    TodosCreateCategoryRequested event,
    Emitter<TodosState> emit,
  ) async {
    emit(
      state.copyWith(isOpenCreateCategory: () => event.isOpen),
    );
  }
}
