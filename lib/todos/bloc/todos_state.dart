part of 'todos_bloc.dart';

sealed class TodosState extends Equatable {
  const TodosState();
  
  @override
  List<Object> get props => [];
}

final class TodosInitial extends TodosState {}
