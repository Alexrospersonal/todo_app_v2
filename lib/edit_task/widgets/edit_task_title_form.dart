import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_v2/edit_task/bloc/edit_task_bloc.dart';
import 'package:todo_app_v2/l10n/l10n.dart';

class TitleForm extends StatelessWidget {
  const TitleForm({super.key});
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocSelector<EditTaskBloc, EditTaskState, String>(
      selector: (state) => state.title,
      builder: (context, title) => TextFormField(
        validator: (title) {
          if (title == null || title.isEmpty) {
            return 'Поле не може бути порожнім';
          }
          return null;
        },
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          filled: true,
          fillColor: Theme.of(context).colorScheme.secondaryContainer,
          hintText: l10n.taskTitleHelperText,
          hintStyle: Theme.of(context).textTheme.bodyMedium,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(
              26,
            ),
          ),
        ),
        initialValue: title,
        onChanged: (value) => context.read<EditTaskBloc>().add(
              EditTaskTitleChanged(title: value),
            ),
      ),
    );
  }
}
