import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app_v2/common/utils/navigation.dart';
import 'package:todo_app_v2/domain/notification_service.dart';
import 'package:todo_app_v2/domain/task_notification_service.dart';
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
    on<TodosUpdateOverdueTodosValue>(_onUpdateOvedueTodosValue);
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
    add(const TodosUpdateOverdueTodosValue());
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
      _todosRepository
          .getCategoriesStream()
          .asyncMap<List<CategoryObject>>((categories) async {
        final categoriesObjects = await Future.wait(
          categories.map((category) async {
            final isOverdue = await _todosRepository.hasOverdueTasks(category);

            return CategoryObject(
              categoryEntity: category,
              isOverdue: isOverdue,
            );
          }),
        );

        final ifHasOverdueTasks = await _todosRepository.hasOverdueTasks(null);

        final categoryForAllTasks = CategoryObject(
          categoryEntity: CategoryEntity(name: 'All'),
          isOverdue: ifHasOverdueTasks,
        );

        return [categoryForAllTasks, ...categoriesObjects];
      }),
      onData: (categories) {
        return state.copyWith(
          status: () => TodosOverviewStatus.success,
          categories: () => categories,
        );
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

    if (task.notificationId != null) {
      final taskNotificationData =
          await TaskNotificationData.buildTaskNotificationData(
        task,
        schedulteTime: task.taskDate!
            .subtract(Duration(minutes: task.notificationReminderTime!)),
      );

      await _updateTaskNotification(event.isCompleted, taskNotificationData);
    }

    await _todosRepository.creatTask(task);
    add(const TodosSubscriptionRequested());
    add(const TodosCategoriesSubscriptionRequested());
  }

  Future<void> _updateTaskNotification(
    bool isCompleted,
    TaskNotificationData taskNotificationData,
  ) async {
    if (isCompleted) {
      await NotificationService.cancelNotification(taskNotificationData.id);
    } else {
      await NotificationService.showNotification(
        taskNotificationData.id,
        taskNotificationData.title,
        taskNotificationData.body,
        taskNotificationData.schedulteTime!,
        RouteNames.home,
      );
    }
  }

  Future<void> _onTodoDeleted(
    TodosTodoDeleted event,
    Emitter<TodosState> emit,
  ) async {
    await _todosRepository.deleteTask(event.todo.id);

    final task = event.todo;

    // Remove notification.
    if (task.notificationId != null) {
      final taskNotificationData =
          await TaskNotificationData.buildTaskNotificationData(
        task,
        schedulteTime: task.taskDate!
            .subtract(Duration(minutes: task.notificationReminderTime!)),
      );

      await _updateTaskNotification(true, taskNotificationData);
    }

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

    final task = state.lastDeletedTodo!;
    emit(state.copyWith(lastDeletedTodo: () => null));
    await _todosRepository.creatTask(task);

    // Add notification
    if (task.notificationId != null) {
      final taskNotificationData =
          await TaskNotificationData.buildTaskNotificationData(
        task,
        schedulteTime: task.taskDate!
            .subtract(Duration(minutes: task.notificationReminderTime!)),
      );

      await _updateTaskNotification(false, taskNotificationData);
    }
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

  Future<void> _onUpdateOvedueTodosValue(
    TodosUpdateOverdueTodosValue event,
    Emitter<TodosState> emit,
  ) async {
    final tasksOverdueAmount = await _todosRepository.getTaskOverdueAmount();

    final updateState = state.copyWith(taskOverdueCount: tasksOverdueAmount);

    emit(updateState);
  }
}
