import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_v2/todos/bloc/todos_bloc.dart';
import 'package:todo_app_v2/todos/widgets/widgets.dart';
import 'package:todos_repository/todos_repository.dart';

class TodosCategories extends StatefulWidget {
  const TodosCategories({super.key});

  @override
  State<TodosCategories> createState() => _TodosCategoriesState();
}

class _TodosCategoriesState extends State<TodosCategories> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodosBloc, TodosState>(
      builder: (context, state) {
        final categories = state.categories;

        return SizedBox(
          height: 30,
          child: ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(
              width: 15,
            ),
            itemCount: categories.length + 1,
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              if (index < categories.length) {
                return TodoCategory(
                  category: categories[index],
                  // isOverdue: false,
                  currentIndex: index,
                  callback: () {
                    context.read<TodosBloc>().add(
                          TodosSelectedCategoryChanged(
                            category: categories[index],
                          ),
                        );
                  },
                  selectedCategory: state.selectedCategory,
                );
              } else {
                return AddCategoryButton(
                  callback: () => context.read<TodosBloc>().add(
                        const TodosCreateCategoryRequested(
                          isOpen: true,
                        ),
                      ),
                );
              }
            },
            scrollDirection: Axis.horizontal,
          ),
        );
      },
    );
  }
}

class TodoCategory extends StatelessWidget {
  const TodoCategory({
    required this.category,
    required this.currentIndex,
    required this.selectedCategory,
    required this.callback,
    this.isOverdue = false,
    super.key,
  });
  final CategoryEntity category;
  final bool isOverdue;
  final int currentIndex;
  final CategoryEntity? selectedCategory;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    final color = category == selectedCategory
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.onPrimary;

    return GestureDetector(
      onTap: callback,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Text(
            category.toString(),
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
