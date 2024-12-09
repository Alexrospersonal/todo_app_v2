import 'package:flutter/material.dart';

class TodosFilters extends StatefulWidget {
  const TodosFilters({super.key});

  @override
  State<TodosFilters> createState() => _TodosFiltersState();
}

class _TodosFiltersState extends State<TodosFilters> {
  int selectedIndex = -1;

  final filters = ['newest', 'oldest', 'is coming', 'important', 'fixel'];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 37,
      child: ListView.separated(
        clipBehavior: Clip.none,
        padding: EdgeInsets.zero,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => Align(
          child: TodoFilter(
            name: filters[index],
            currentIndex: index,
            selectedIndex: selectedIndex,
            callback: () {
              setState(() {
                selectedIndex = index;
              });
            },
          ),
        ),
        separatorBuilder: (context, index) => const SizedBox(
          width: 10,
        ),
        itemCount: filters.length,
      ),
    );
  }
}

class TodoFilter extends StatelessWidget {
  const TodoFilter({
    required this.name,
    required this.currentIndex,
    required this.selectedIndex,
    required this.callback,
    super.key,
  });

  final String name;
  final int currentIndex;
  final int selectedIndex;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    final isSelected = currentIndex == selectedIndex;
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
