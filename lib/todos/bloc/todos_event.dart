part of 'todos_bloc.dart';

sealed class TodosEvent extends Equatable {
  const TodosEvent();

  @override
  List<Object> get props => [];
}

final class TodosSubscriptionRequested extends TodosEvent {
  const TodosSubscriptionRequested();
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
  const TodosTodoDeleted(this.todo);

  final TaskEntity todo;

  @override
  List<Object> get props => [todo];
}

final class TodosUndoDeletionRequested extends TodosEvent {
  const TodosUndoDeletionRequested();
}

class TodosOverviewFilterChanged extends TodosEvent {
  const TodosOverviewFilterChanged(this.filter);

  final TasksFilters filter;

  @override
  List<Object> get props => [filter];
}
