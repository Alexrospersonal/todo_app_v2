import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:todo_app_v2/edit_task/bloc/edit_task_bloc.dart';
import 'package:todo_app_v2/edit_task/widgets/widgets.dart';
import 'package:todo_app_v2/home/widgets/custom_app_bar.dart';
import 'package:todo_app_v2/l10n/l10n.dart';
import 'package:todos_repository/todos_repository.dart';

class EditTaskPage extends StatelessWidget {
  const EditTaskPage({
    this.initialTask,
    this.initialCategory,
    super.key,
  });

  final TaskEntity? initialTask;
  final CategoryEntity? initialCategory;

  static Route<bool> route({
    TaskEntity? initialTask,
    CategoryEntity? initialCategory,
  }) {
    return MaterialPageRoute(
      fullscreenDialog: true,
      maintainState: false,
      builder: (context) {
        return EditTaskPage(
          initialTask: initialTask,
          initialCategory: initialCategory,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditTaskBloc(
        initalTask: initialTask,
        initialCategory: initialCategory,
        tasksRepository: context.read<TodosRepository>(),
      )..add(const EditTaskLoadCategories()),
      child: BlocListener<EditTaskBloc, EditTaskState>(
        listenWhen: (previous, current) =>
            previous.status != current.status &&
            current.status == EditTaskStatus.success,
        listener: (context, state) => Navigator.of(context).pop(),
        child: const EditTaskView(),
      ),
    );
  }
}

class EditTaskView extends StatefulWidget {
  const EditTaskView({super.key});

  @override
  State<EditTaskView> createState() => _EditTaskViewState();
}

class _EditTaskViewState extends State<EditTaskView> {
  final _formKey = GlobalKey<FormState>();
  late QuillController _descriptionController;

  @override
  void initState() {
    super.initState();
    final state = context.read<EditTaskBloc>().state;

    var document = Document.fromJson([
      {'insert': '\n'},
    ]);

    if (state.notate.isNotEmpty) {
      document = Document.fromJson(jsonDecode(state.notate) as List<dynamic>);
    }

    _descriptionController = QuillController(
      document: document,
      selection: const TextSelection.collapsed(offset: 0),
    );
  }

  void submitTask() {
    if (_formKey.currentState?.validate() ?? false) {
      final jsonString =
          jsonEncode(_descriptionController.document.toDelta().toJson());

      context.read<EditTaskBloc>().add(
            EditTaskSubmitted(description: jsonString),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final color = context.watch<EditTaskBloc>().state.color;
    final initialTask = context.read<EditTaskBloc>().state.initialTodo;

    return Scaffold(
      appBar: CustomAppBar(
        title: initialTask == null ? l10n.taskEditTitleName : l10n.editTask,
        titleTextStyle: Theme.of(context).textTheme.displaySmall,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: const Icon(
              Icons.arrow_back_ios,
              size: 38,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            radius: 1,
            center: Alignment.bottomCenter,
            colors: [
              Color(color),
              Theme.of(context).colorScheme.surface,
            ],
          ),
        ),
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                const TitleForm(),
                const SizedBox(
                  height: 15,
                ),
                const SubtasksContainer(),
                const Row(
                  children: [
                    DropdownCategorySelector(),
                    SubtaskIconButton(),
                    DateIconButton(),
                    ImportantIconButton(),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                const ColorPicker(),
                const SizedBox(
                  height: 15,
                ),
                DescriptionTextEditor(
                  controller: _descriptionController,
                ),
                const SizedBox(
                  height: 15,
                ),
                SafeArea(
                  child: GestureDetector(
                    onTap: submitTask,
                    child: Container(
                      height: 34,
                      width: 164,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(
                        Icons.add,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
