import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_v2/edit_task/bloc/edit_task_bloc.dart';
import 'package:todo_app_v2/l10n/l10n.dart';
import 'package:todos_repository/todos_repository.dart';

class DropdownCategorySelector extends StatelessWidget {
  const DropdownCategorySelector({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final state = context.read<EditTaskBloc>().state;
    final initCategory = state.category;

    return BlocSelector<EditTaskBloc, EditTaskState, List<CategoryEntity>>(
      selector: (state) => state.categories,
      builder: (context, categories) => Expanded(
        child: DropdownButtonFormField<CategoryEntity>(
          value: initCategory,
          style: Theme.of(context).textTheme.bodyMedium,
          onChanged: (category) {
            if (category != null) {
              context.read<EditTaskBloc>().add(
                    EditTaskCategoryChanged(category: category),
                  );
            }
          },
          hint: Text(l10n.taskSelectCategoryHelperText),
          decoration: InputDecoration(
            filled: true,
            hintStyle: Theme.of(context).textTheme.bodyMedium,
            fillColor: Theme.of(context).colorScheme.secondaryContainer,
            contentPadding: const EdgeInsets.fromLTRB(20, 5, 5, 5),
            isCollapsed: true,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(
                26,
              ),
            ),
          ),
          items: [
            DropdownMenuItem(
              child: Text(l10n.taskSelectCategoryUncategorizedName),
            ),
            ...categories.map(
              (category) => DropdownMenuItem(
                value: category,
                child: Text(category.toString()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
