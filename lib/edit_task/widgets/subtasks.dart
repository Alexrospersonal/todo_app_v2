import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_v2/edit_task/bloc/edit_task_bloc.dart';
import 'package:todo_app_v2/l10n/l10n.dart';
import 'package:todos_repository/todos_repository.dart';

class SubtasksContainer extends StatefulWidget {
  const SubtasksContainer({super.key});

  @override
  State<SubtasksContainer> createState() => _SubtasksContainerState();
}

class _SubtasksContainerState extends State<SubtasksContainer> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<EditTaskBloc, EditTaskState, List<SubTask>>(
      selector: (state) => state.subtasks,
      builder: (context, subtasks) {
        final subtaskItems = subtasks
            .map(
              (subtask) => SubtaskItem(
                key: ValueKey(subtask.id),
                subtask: subtask,
              ),
            )
            .toList();

        var containerHeight = subtasks.length * 48.0;

        containerHeight = containerHeight > 288 ? 288 : containerHeight;

        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (_scrollController.hasClients && containerHeight > 256) {
            _scrollController.animateTo(
              _scrollController.position.maxScrollExtent - 30,
              duration: const Duration(milliseconds: 200),
              curve: Curves.linear,
            );
          }
        });

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: containerHeight,
          child: Scrollbar(
            controller: _scrollController,
            child: ListView(
              controller: _scrollController,
              children: subtaskItems,
            ),
          ),
        );
      },
    );
  }
}

class SubtaskItem extends StatelessWidget {
  const SubtaskItem({
    required this.subtask,
    super.key,
  });

  final SubTask subtask;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Row(
      children: [
        Checkbox(
          value: subtask.completed,
          onChanged: (value) {
            context.read<EditTaskBloc>().add(
                  EditTaskSubtaskCompleted(
                    id: subtask.id,
                    completed: !subtask.completed,
                  ),
                );
          },
        ),
        Expanded(
          child: TextFormField(
            initialValue: subtask.title,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  decoration: subtask.completed
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
            decoration: InputDecoration(
              isCollapsed: true,
              border: InputBorder.none,
              hintText: l10n.taskTitleHelperText,
              hintStyle: Theme.of(context).textTheme.bodyMedium,
            ),
            onChanged: (value) {
              context.read<EditTaskBloc>().add(
                    EditTaskSubtaskChanged(id: subtask.id, title: value),
                  );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
          child: GestureDetector(
            onTap: () {
              context
                  .read<EditTaskBloc>()
                  .add(EditTaskSubtaskDeleted(id: subtask.id));
            },
            child: Icon(
              Icons.cancel_outlined,
              size: 24,
              color: Theme.of(context).colorScheme.error,
            ),
          ),
        ),
      ],
    );
  }
}
