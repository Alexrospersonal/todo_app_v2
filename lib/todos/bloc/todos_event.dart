part of 'todos_bloc.dart';

sealed class TodosEvent extends Equatable {
  const TodosEvent();

  @override
  List<Object> get props => [];
}

final class TodosSelectedCategoryLoading extends TodosEvent {
  const TodosSelectedCategoryLoading();
}

final class TodosSelectedCategoryChanged extends TodosEvent {
  const TodosSelectedCategoryChanged({required this.category});

  final CategoryEntity? category;
}

final class TodosSubscriptionRequested extends TodosEvent {
  const TodosSubscriptionRequested();
}

final class TodosCategoriesSubscriptionRequested extends TodosEvent {
  const TodosCategoriesSubscriptionRequested();
}

final class TodosTodoCompletionToggled extends TodosEvent {
  const TodosTodoCompletionToggled({
    required this.todo,
    required this.isCompleted,
  });

  final TaskEntity todo;
  final bool isCompleted;

  @override
  List<Object> get props => [todo, isCompleted];
}

final class TodosTodoDeleted extends TodosEvent {
  const TodosTodoDeleted({required this.todo});

  final TaskEntity todo;

  @override
  List<Object> get props => [todo];
}

final class TodosUndoDeletionRequested extends TodosEvent {
  const TodosUndoDeletionRequested();
}

final class TodosOverviewFilterChanged extends TodosEvent {
  const TodosOverviewFilterChanged(this.filter);

  final TasksFilters filter;

  @override
  List<Object> get props => [filter];
}

final class TodosCreateNewList extends TodosEvent {
  const TodosCreateNewList({
    required this.categoryTitle,
  });

  final String categoryTitle;
}

final class TodosCreateCategoryRequested extends TodosEvent {
  const TodosCreateCategoryRequested({
    required this.isOpen,
  });

  final bool isOpen;
}

final class TodosUpdateOverdueTodosValue extends TodosEvent {
  const TodosUpdateOverdueTodosValue();
}
