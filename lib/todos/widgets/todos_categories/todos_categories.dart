import 'package:flutter/material.dart';
import 'package:todo_app_v2/todos/widgets/widgets.dart';

class TodosCategories extends StatefulWidget {
  const TodosCategories({super.key});

  @override
  State<TodosCategories> createState() => _TodosCategoriesState();
}

class _TodosCategoriesState extends State<TodosCategories> {
  int selectedIndex = -1;

  final categories = [
    ('🌞TODAY', false),
    ('🏠HOME', true),
    ('🏋🏼GYM', false),
  ];

  Widget? buildCategoryList(
    BuildContext context,
    int index,
  ) {
    if (index < categories.length) {
      return TodoCategory(
        name: categories[index].$1,
        isOverdue: categories[index].$2,
        currentIndex: index,
        callback: () {
          setState(() {
            selectedIndex = index;
          });
        },
        selectedIndex: selectedIndex,
      );
    } else {
      return AddCategoryButton(
        callback: () {},
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(
          width: 15,
        ),
        itemCount: categories.length + 1,
        padding: EdgeInsets.zero,
        itemBuilder: buildCategoryList,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}

class TodoCategory extends StatelessWidget {
  const TodoCategory({
    required this.name,
    required this.currentIndex,
    required this.selectedIndex,
    required this.callback,
    this.isOverdue = false,
    super.key,
  });
  final String name;
  final bool isOverdue;
  final int currentIndex;
  final int selectedIndex;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    final color = currentIndex == selectedIndex
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.onPrimary;

    return GestureDetector(
      onTap: callback,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Text(
            name,
            style: TextStyle(
              color: color,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (isOverdue) const OverdueTaskIndicator(),
        ],
      ),
    );
  }
}

class AddCategoryButton extends StatelessWidget {
  const AddCategoryButton({required this.callback, super.key});

  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: callback,
      child: const Icon(Icons.add),
    );
  }
}
