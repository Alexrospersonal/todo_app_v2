import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_v2/l10n/l10n.dart';
import 'package:todo_app_v2/todos/bloc/todos_bloc.dart';

class CreateCategoryDialog extends StatefulWidget {
  const CreateCategoryDialog({required this.bloc, super.key});

  final TodosBloc bloc;

  @override
  State<CreateCategoryDialog> createState() => _CreateCategoryDialogState();
}

class _CreateCategoryDialogState extends State<CreateCategoryDialog> {
  final _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocProvider<TodosBloc>.value(
      value: widget.bloc,
      child: SimpleDialog(
        title: Text(l10n.createNewListTitle),
        children: [
          Form(
            child: Column(
              children: [
                TextFormField(
                  validator: (title) {
                    if (title == null || title.isEmpty) {
                      return l10n.titleValidationErrorMessage;
                    }
                    return null;
                  },
                  controller: _controller,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
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
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        l10n.cancelTitleBtn,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
// TODO: add valiadation and create a new list using TodosBloc
                        }
                      },
                      child: Text(l10n.submitTitleBtn),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
