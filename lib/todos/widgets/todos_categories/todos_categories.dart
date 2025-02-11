import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_v2/l10n/l10n.dart';
import 'package:todo_app_v2/todos/bloc/todos_bloc.dart';
import 'package:todo_app_v2/todos/widgets/widgets.dart';
import 'package:todos_repository/todos_repository.dart';

class TodosCategories extends StatefulWidget {
  const TodosCategories({super.key});

  @override
  State<TodosCategories> createState() => _TodosCategoriesState();
}

class _TodosCategoriesState extends State<TodosCategories> {
  Widget? buildCategoriesButtons(BuildContext context, int index) {
    final state = context.read<TodosBloc>().state;
    final categories = state.categories;

    if (index == 0) {
      return buildAllCategoriesButton(state.selectedCategory);
    } else if (index < categories.length + 1) {
      return buildTodoCategoryButton(
        categories,
        index - 1,
        state.selectedCategory,
      );
    } else {
      return buildCreateCategoryButton();
    }
  }

  Widget buildAllCategoriesButton(CategoryEntity? selectedCategory) {
    return AllCategories(
      selectedCategory: selectedCategory,
      callback: () => context.read<TodosBloc>().add(
            const TodosSelectedCategoryChanged(
              category: null,
            ),
          ),
    );
  }

  Widget buildCreateCategoryButton() {
    return AddCategoryButton(
      callback: () => context.read<TodosBloc>().add(
            const TodosCreateCategoryRequested(
              isOpen: true,
            ),
          ),
    );
  }

  Widget buildTodoCategoryButton(
    List<CategoryEntity> categories,
    int index,
    CategoryEntity? selectedCategory,
  ) {
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
      selectedCategory: selectedCategory,
    );
  }

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
            itemCount: categories.length + 2,
            padding: EdgeInsets.zero,
            itemBuilder: buildCategoriesButtons,
            scrollDirection: Axis.horizontal,
          ),
        );
      },
    );
  }
}

class AllCategories extends StatelessWidget {
  const AllCategories({
    required this.selectedCategory,
    required this.callback,
    this.isOverdue = false,
    super.key,
  });

  final bool isOverdue;
  final VoidCallback callback;
  final CategoryEntity? selectedCategory;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final color = selectedCategory == null
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.onPrimary;

    return CategoryButton(
      title: l10n.allTitle,
      callback: callback,
      color: color,
      isOverdue: isOverdue,
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

    return CategoryButton(
      title: category.toString(),
      callback: callback,
      color: color,
      isOverdue: isOverdue,
    );
  }
}

class CategoryButton extends StatelessWidget {
  const CategoryButton({
    required this.title,
    required this.callback,
    required this.color,
    required this.isOverdue,
    super.key,
  });

  final String title;
  final VoidCallback callback;
  final Color color;
  final bool isOverdue;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Text(
            title,
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
