import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_v2/edit_task/bloc/edit_task_bloc.dart';
import 'package:todo_app_v2/edit_task/widgets/widgets.dart';
import 'package:todo_app_v2/theme/theme.dart';
import 'package:todos_repository/todos_repository.dart';

class SubtaskIconButton extends StatelessWidget {
  const SubtaskIconButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<EditTaskBloc, EditTaskState, List<SubTask>>(
      selector: (state) => state.subtasks,
      builder: (context, subtasks) => SizedBox(
        height: 34,
        child: IconButton.filled(
          onPressed: () {
            context.read<EditTaskBloc>().add(const EditTaskSubtaskCreated());
          },
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(
              subtasks.isNotEmpty
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.secondaryContainer,
            ),
          ),
          padding: EdgeInsets.zero,
          icon: Icon(
            Icons.account_tree_rounded,
            color: subtasks.isNotEmpty ? yellowColor : greyColor,
          ),
        ),
      ),
    );
  }
}

class ImportantIconButton extends StatelessWidget {
  const ImportantIconButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<EditTaskBloc, EditTaskState, bool>(
      selector: (state) => state.important,
      builder: (context, important) => SizedBox(
        height: 34,
        child: IconButton.filled(
          onPressed: () {
            context
                .read<EditTaskBloc>()
                .add(EditTaskImportantStatusChanged(isImportant: !important));
          },
          padding: EdgeInsets.zero,
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(
              important
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.secondaryContainer,
            ),
          ),
          icon: Icon(
            Icons.star_rounded,
            color: important ? yellowColor : greyColor,
          ),
        ),
      ),
    );
  }
}

class DateIconButton extends StatelessWidget {
  const DateIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<EditTaskBloc, EditTaskState, DateTime?>(
      selector: (state) => state.taskDate,
      builder: (context, taskDate) => SizedBox(
        height: 34,
        child: IconButton.filled(
          onPressed: () {
            final ctx = context;
            showDialog<void>(
              context: ctx,
              builder: (context) => BlocProvider.value(
                value: BlocProvider.of<EditTaskBloc>(ctx),
                child: ScaffoldMessenger(
                  child: Scaffold(
                    backgroundColor: Colors.transparent,
                    body: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => Navigator.of(context).pop(),
                      child: const DateSelectDialogMenu(),
                    ),
                  ),
                ),
              ),
            );
          },
          padding: EdgeInsets.zero,
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(
              taskDate != null
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.secondaryContainer,
            ),
          ),
          icon: Icon(
            Icons.calendar_month_sharp,
            color: taskDate != null ? yellowColor : greyColor,
          ),
        ),
      ),
    );
  }
}
