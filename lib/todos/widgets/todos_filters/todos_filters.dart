import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_v2/l10n/l10n.dart';
import 'package:todo_app_v2/todos/bloc/todos_bloc.dart';
import 'package:todo_app_v2/todos/models/tasks_filters.dart';

class TodosFilters extends StatefulWidget {
  const TodosFilters({super.key});

  @override
  State<TodosFilters> createState() => _TodosFiltersState();
}

class _TodosFiltersState extends State<TodosFilters> {
  int selectedIndex = -1;

  final filters = ['newest', 'oldest', 'is coming', 'important', 'fixel'];

  final tasksFilters = TasksFilters.values;

  @override
  Widget build(BuildContext context) {
    final selectedFilter = context.watch<TodosBloc>().state.filter;

    return SizedBox(
      height: 37,
      child: ListView.separated(
        clipBehavior: Clip.none,
        padding: EdgeInsets.zero,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => Align(
          child: TodoFilter(
            filter: tasksFilters[index],
            currentIndex: index,
            selectedFilter: selectedFilter,
            callback: () {
              context.read<TodosBloc>().add(
                    TodosOverviewFilterChanged(tasksFilters[index]),
                  );
              setState(() {
                selectedIndex = index;
              });
            },
          ),
        ),
        separatorBuilder: (context, index) => const SizedBox(
          width: 15,
        ),
        itemCount: filters.length,
      ),
    );
  }
}

class TodoFilter extends StatelessWidget {
  const TodoFilter({
    required this.filter,
    required this.currentIndex,
    required this.selectedFilter,
    required this.callback,
    super.key,
  });

  final TasksFilters filter;
  final int currentIndex;
  final TasksFilters selectedFilter;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final name = switch (filter) {
      TasksFilters.all => l10n.taskFilterAll,
      TasksFilters.isComing => l10n.taskFilterIsComing,
      TasksFilters.important => l10n.taskFilterImportant,
      TasksFilters.dateless => l10n.taskFilterDateless,
      TasksFilters.withDate => l10n.taskFilterWithDate,
    };

    final isSelected = filter == selectedFilter;
    final color = isSelected
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.onPrimary;

    final backgroundColor = isSelected
        ? Theme.of(context).colorScheme.surface
        : Theme.of(context).colorScheme.secondaryContainer;

    final border = isSelected
        ? Border.all(
            color: Theme.of(context).colorScheme.primary,
            strokeAlign: BorderSide.strokeAlignOutside,
          )
        : null;

    final shadow = isSelected
        ? BoxShadow(
            color: Theme.of(context).colorScheme.primary,
            blurRadius: 10,
            spreadRadius: 3,
          )
        : null;

    return GestureDetector(
      onTap: callback,
      child: Container(
        height: 20,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: backgroundColor,
          border: border,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [shadow ?? const BoxShadow()],
        ),
        child: Text(
          name,
          style: TextStyle(
            fontSize: 12,
            color: color,
          ),
        ),
      ),
    );
  }
}
