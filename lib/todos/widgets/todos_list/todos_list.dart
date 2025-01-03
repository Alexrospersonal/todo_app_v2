import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/quill_delta.dart';
import 'package:todo_app_v2/common/utils/date_formatter.dart';
import 'package:todo_app_v2/edit_task/view/view.dart';
import 'package:todo_app_v2/l10n/l10n.dart';
import 'package:todo_app_v2/theme/theme.dart';
import 'package:todo_app_v2/todos/bloc/todos_bloc.dart';
import 'package:todos_repository/todos_repository.dart';

class TodosList extends StatelessWidget {
  const TodosList({super.key});

  bool _buildNewWidgetWhen(TodosState previous, TodosState current) {
    if (previous.todos.length != current.todos.length) {
      return true;
    }

    if (previous.filter != current.filter) {
      return true;
    }

    if (previous.selectedCategory != current.selectedCategory) {
      return true;
    }

    return true;
  }

  Widget _buildWidgetIfTasksIsEmpty(TodosState state, AppLocalizations l10n) {
    if (state.status == TodosOverviewStatus.loading) {
      return const Center(child: CupertinoActivityIndicator());
    } else if (state.status != TodosOverviewStatus.success) {
      return const SizedBox.shrink();
    } else {
      return Center(
        child: Text(l10n.addAnewTask),
      );
    }
  }

  List<Widget> _createTaskCartForExpansionTile(
    Iterable<TaskEntity> tasks,
    BuildContext context,
  ) {
    return tasks
        .map(
          (task) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: TodoCard(
              task: task,
              onTap: () => Navigator.of(context).push(
                EditTaskPage.route(initialTask: task),
              ),
              category: task.category.value,
              title: task.title,
              dateTime: task.taskDate,
              isNotification: task.notificationId != null || false,
              repeatDuringWeek: task.repeatDuringWeek ?? [],
              repeatDuringDay: task.repeatDuringDay,
              isImportant: task.important,
              color: task.color ?? baseColor.value,
              isFinish: task.isFinished,
            ),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodosBloc, TodosState>(
      buildWhen: _buildNewWidgetWhen,
      builder: (context, state) {
        final l10n = context.l10n;

        if (state.todos.isEmpty) {
          return _buildWidgetIfTasksIsEmpty(state, l10n);
        }

        final newTasks = state.newTodos;
        final finishedTasks = state.finishedTodos;
        final overdueTasks = state.overdueTodos;

        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 10),
            child: ListView(
              children: [
                ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final task = newTasks.elementAt(index);
                    return TodoCard(
                      task: task,
                      onTap: () => Navigator.of(context).push(
                        EditTaskPage.route(initialTask: task),
                      ),
                      category: task.category.value,
                      title: task.title,
                      dateTime: task.taskDate,
                      isNotification: task.notificationId != null || false,
                      repeatDuringWeek: task.repeatDuringWeek ?? [],
                      repeatDuringDay: task.repeatDuringDay,
                      isImportant: task.important,
                      color: task.color ?? baseColor.value,
                      isFinish: task.isFinished,
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 10),
                  itemCount: newTasks.length,
                ),
                const SizedBox(
                  height: 10,
                ),
                if (finishedTasks.isNotEmpty)
                  ExpansionTile(
                    title: Text(l10n.finishedTasksTitle),
                    tilePadding: EdgeInsets.zero,
                    childrenPadding: const EdgeInsets.symmetric(vertical: 5),
                    children:
                        _createTaskCartForExpansionTile(finishedTasks, context),
                  ),
                if (overdueTasks.isNotEmpty)
                  ExpansionTile(
                    title: Text(l10n.overdueTasksTitle),
                    children:
                        _createTaskCartForExpansionTile(overdueTasks, context),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class TodoCard extends StatefulWidget {
  const TodoCard({
    required this.task,
    required this.onTap,
    required this.title,
    required this.dateTime,
    required this.color,
    this.category,
    this.isNotification = false,
    this.repeatDuringWeek = const [],
    this.repeatDuringDay = const [],
    this.isImportant = false,
    this.isFinish = false,
    this.isOVerdute = false,
    super.key,
  });

  final TaskEntity task;
  final VoidCallback onTap;
  final CategoryEntity? category;
  final String title;
  final DateTime? dateTime;
  final bool isNotification;

  final List<int> repeatDuringWeek;
  final List<DateTime?>? repeatDuringDay;

  final bool isImportant;

  final bool isFinish;
  final bool isOVerdute;
  final int color;

  @override
  State<TodoCard> createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  bool isFinish = false;

  WidgetStatePropertyAll<Color> getFillColor(BuildContext context) {
    Color fillColor;

    if (isFinish && !widget.isOVerdute) {
      fillColor = Theme.of(context).colorScheme.primary;
    } else if (widget.isOVerdute) {
      fillColor = Theme.of(context).colorScheme.error;
    } else {
      fillColor = Theme.of(context).colorScheme.onPrimary;
    }

    return WidgetStatePropertyAll<Color>(fillColor);
  }

  @override
  Widget build(BuildContext context) {
    isFinish = widget.isFinish;

    final l10n = context.l10n;
    final category = widget.category ?? l10n.uncategorized;

    return GestureDetector(
      onTap: widget.onTap,
      child: Dismissible(
        onDismissed: (direction) {
          context.read<TodosBloc>().add(TodosTodoDeleted(todo: widget.task));
        },
        key: UniqueKey(),
        direction: DismissDirection.endToStart,
        background: Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Icon(
              Icons.delete_forever,
              size: 38,
              color: Theme.of(context).colorScheme.error,
            ),
          ),
        ),
        child: Container(
          height: 87,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(26),
            color: Theme.of(context).colorScheme.secondaryContainer,
            gradient: RadialGradient(
              colors: [
                Color(widget.color),
                Theme.of(context).colorScheme.secondaryContainer,
              ],
              radius: 3,
              center: const Alignment(1.4, 0),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              children: [
                Checkbox(
                  value: isFinish,
                  fillColor: getFillColor(context),
                  checkColor: getFillColor(context).value,
                  onChanged: (value) {
                    context.read<TodosBloc>().add(
                          TodosTodoCompletionToggled(
                            todo: widget.task,
                            isCompleted: !isFinish,
                          ),
                        );
                  },
                ),
                TodoTextsColumn(
                  category: category.toString(),
                  title: widget.title,
                  description: widget.task.notate ?? '',
                  date: DateFormatter.formatDateTime(
                    context,
                    widget.dateTime,
                  ),
                  isNotification: widget.isNotification,
                  repeatDuringWeek: DateFormatter.formatNumberToWeekdays(
                    context,
                    widget.repeatDuringWeek,
                  ),
                  repeatDuringDay: DateFormatter.formatDateTimesToTimeString(
                    widget.repeatDuringDay,
                  ),
                ),
                CardStar(
                  isImportant: widget.isImportant,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TodoTextsColumn extends StatelessWidget {
  const TodoTextsColumn({
    required this.category,
    required this.title,
    required this.date,
    required this.description,
    this.isNotification = false,
    this.repeatDuringWeek = '',
    this.repeatDuringDay = '',
    super.key,
  });

  final String category;
  final String title;
  final String description;
  final String date;
  final bool isNotification;

  final String repeatDuringWeek;
  final String repeatDuringDay;

  Color getIconColor(BuildContext context, {bool? flag}) {
    return flag != null && flag
        ? Theme.of(context).colorScheme.onPrimary
        : Theme.of(context).colorScheme.surface;
  }

  String extractPlainText(String jsonString) {
    final json = jsonDecode(jsonString) as List<dynamic>;
    final buffer = StringBuffer();

    for (final operation in json) {
      operation as Map;
      if (operation.containsKey('insert')) {
        buffer.write(operation['insert']);
      }
    }

    return buffer.toString().trim();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            category,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.labelSmall!.copyWith(height: 1),
          ),
          Text(
            extractPlainText(description),
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(height: 1),
          ),
          Text(
            date,
            style: const TextStyle(
              fontSize: 12,
            ),
          ),
          Row(
            children: [
              Icon(
                Icons.notifications_active,
                color: getIconColor(context, flag: isNotification),
              ),
              const SizedBox(
                width: 3,
              ),
              TodoTextsColumnRowWidget(
                iconData: Icons.repeat,
                flag: repeatDuringWeek.isNotEmpty,
                text: repeatDuringWeek,
              ),
              const SizedBox(
                width: 3,
              ),
              TodoTextsColumnRowWidget(
                iconData: Icons.av_timer_sharp,
                flag: repeatDuringDay.isNotEmpty,
                text: repeatDuringDay,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TodoTextsColumnRowWidget extends StatelessWidget {
  const TodoTextsColumnRowWidget({
    required this.iconData,
    required this.flag,
    required this.text,
    super.key,
  });

  final bool flag;
  final String text;
  final IconData iconData;

  Color getIconColor(BuildContext context, {bool? flag}) {
    return flag != null && flag
        ? Theme.of(context).colorScheme.onPrimary
        : Theme.of(context).colorScheme.surface;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          iconData,
          color: getIconColor(
            context,
            flag: flag,
          ),
        ),
        Text(
          text,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}

class CardStar extends StatelessWidget {
  const CardStar({required this.isImportant, super.key});

  final bool isImportant;

  @override
  Widget build(BuildContext context) {
    final color =
        isImportant ? yellowColor : Theme.of(context).colorScheme.surface;

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 5, 15, 0),
      child: Align(
        alignment: Alignment.topRight,
        child: Icon(
          Icons.star_rate_rounded,
          size: 20,
          color: color,
        ),
      ),
    );
  }
}
