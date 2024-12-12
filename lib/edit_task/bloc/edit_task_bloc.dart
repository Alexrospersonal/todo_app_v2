import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'edit_task_event.dart';
part 'edit_task_state.dart';

class EditTaskBloc extends Bloc<EditTaskEvent, EditTaskState> {
  EditTaskBloc() : super(EditTaskInitial()) {
    on<EditTaskEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
