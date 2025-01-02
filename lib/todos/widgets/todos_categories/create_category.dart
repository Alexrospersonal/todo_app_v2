import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_v2/l10n/l10n.dart';
import 'package:todo_app_v2/todos/bloc/todos_bloc.dart';

class CreateCategory extends StatefulWidget {
  const CreateCategory({super.key});

  @override
  State<CreateCategory> createState() => _CreateCategoryState();
}

class _CreateCategoryState extends State<CreateCategory> {
  final _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocSelector<TodosBloc, TodosState, bool>(
      selector: (state) => state.isOpenCreateCategory,
      builder: (context, isOpen) {
        final height = isOpen ? 50.0 : 0.0;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: height,
          child: Form(
            key: _formKey,
            child: isOpen
                ? Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          cursorHeight: 14,
                          controller: _controller,
                          maxLength: 28,
                          buildCounter: (
                            _, {
                            required currentLength,
                            required isFocused,
                            maxLength,
                          }) =>
                              null,
                          decoration: const InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.all(10),
                          ),
                          autofocus: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return l10n.titleValidationErrorMessage;
                            }
                            return null;
                          },
                        ),
                      ),
                      GestureDetector(
                        onTap: () => context.read<TodosBloc>().add(
                              const TodosCreateCategoryRequested(
                                isOpen: false,
                              ),
                            ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5,
                          ),
                          child: Icon(
                            Icons.cancel,
                            color: Theme.of(context).colorScheme.error,
                            size: 18,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            final title = _controller.text;
                            context.read<TodosBloc>().add(
                                  TodosCreateNewList(categoryTitle: title),
                                );
                            _controller.clear();
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5,
                          ),
                          child: Icon(
                            Icons.done_outline_rounded,
                            color: Theme.of(context).colorScheme.primary,
                            size: 18,
                          ),
                        ),
                      ),
                    ],
                  )
                : const SizedBox.shrink(),
          ),
        );
      },
    );
  }
}
