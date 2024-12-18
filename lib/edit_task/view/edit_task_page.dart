import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_v2/edit_task/bloc/edit_task_bloc.dart';
import 'package:todo_app_v2/edit_task/widgets/form_header.dart';
import 'package:todo_app_v2/l10n/l10n.dart';
import 'package:todo_app_v2/theme/theme.dart';
import 'package:todos_repository/todos_repository.dart';

class ListsPage extends StatelessWidget {
  const ListsPage({this.initialTask, super.key});

  final TaskEntity? initialTask;

  static Route<void> route({TaskEntity? initialTask}) {
    return MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) {
        return ListsPage(
          initialTask: initialTask,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditTaskBloc(
        initalTask: initialTask,
        tasksRepository: context.read<TodosRepository>(),
      ),
      child: BlocListener<EditTaskBloc, EditTaskState>(
        listenWhen: (previous, current) =>
            previous.status != current.status &&
            current.status == EditTaskStatus.success,
        listener: (context, state) => Navigator.of(context).pop(),
        child: const ListView(),
      ),
    );
  }
}

class ListView extends StatefulWidget {
  const ListView({super.key});

  @override
  State<ListView> createState() => _ListViewState();
}

class _ListViewState extends State<ListView> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    context.read<EditTaskBloc>().add(const EditTaskLoadCategories());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    // final editBloc = context.read<EditTaskBloc>();
    // print(editBloc.state);

    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            FormHeader(
              title: l10n.createTaskTitle,
            ),
            const SizedBox(
              height: 10,
            ),
            const TitleForm(),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const DropdownCategorySelector(),
                SizedBox(
                  // width: 20,
                  height: 34,
                  child: IconButton.filled(
                    onPressed: () {},
                    padding: EdgeInsets.zero,
                    icon: const Icon(Icons.account_tree_rounded),
                  ),
                ),
                SizedBox(
                  // width: 20,
                  height: 34,
                  child: IconButton.filled(
                    onPressed: () {},
                    padding: EdgeInsets.zero,
                    icon: const Icon(Icons.calendar_month_sharp),
                  ),
                ),
                const ImportantIconButton(),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 67,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(26),
                    gradient: RadialGradient(
                      colors: [
                        AccentColor.blue.color,
                        Theme.of(context).colorScheme.secondaryContainer,
                      ],
                      radius: 1.3,
                      center: Alignment.centerRight,
                    ),
                  ),
                ),
                GestureDetector(
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.transparent,
                        width: 2,
                      ),
                      color: AccentColor.main.color,
                    ),
                  ),
                ),
                GestureDetector(
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Theme.of(context).colorScheme.onPrimary,
                        width: 2,
                      ),
                      color: AccentColor.blue.color,
                    ),
                  ),
                ),
                GestureDetector(
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Theme.of(context).colorScheme.onPrimary,
                        width: 0,
                      ),
                      color: AccentColor.green.color,
                    ),
                  ),
                ),
                GestureDetector(
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Theme.of(context).colorScheme.onPrimary,
                        width: 0,
                      ),
                      color: AccentColor.orange.color,
                    ),
                  ),
                ),
                GestureDetector(
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Theme.of(context).colorScheme.onPrimary,
                        width: 0,
                      ),
                      color: AccentColor.red.color,
                    ),
                  ),
                ),
                GestureDetector(
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Theme.of(context).colorScheme.onPrimary,
                        width: 0,
                      ),
                      color: AccentColor.pink.color,
                    ),
                  ),
                ),
                GestureDetector(
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Theme.of(context).colorScheme.onPrimary,
                        width: 0,
                      ),
                      color: AccentColor.purple.color,
                    ),
                  ),
                ),
                GestureDetector(
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Theme.of(context).colorScheme.onPrimary,
                        width: 0,
                      ),
                      color: AccentColor.seaGreen.color,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'doneBtn',
        child: const Icon(Icons.add),
        onPressed: () {
          context.read<EditTaskBloc>().add(const EditTaskSubmitted());
        },
      ),
    );
  }
}

class ImportantIconButton extends StatelessWidget {
  const ImportantIconButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<EditTaskBloc, EditTaskState, bool>(
      selector: (state) => state.important,
      builder: (context, important) => SizedBox(
        // width: 20,
        height: 34,
        child: IconButton.filled(
          onPressed: () {
            context
                .read<EditTaskBloc>()
                .add(EditTaskImportantStatusChanged(isImportant: !important));
          },
          padding: EdgeInsets.zero,
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(
              important
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.secondaryContainer,
            ),
          ),
          icon: Icon(
            Icons.star_rounded,
            color: important ? yellowColor : greyColor,
          ),
        ),
      ),
    );
  }
}

class DropdownCategorySelector extends StatelessWidget {
  const DropdownCategorySelector({super.key});

  @override
  Widget build(BuildContext context) {
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
          hint: const Text('Select category'),
          decoration: InputDecoration(
            filled: true,
            hintStyle: Theme.of(context).textTheme.bodyMedium,
            fillColor: Theme.of(context).colorScheme.secondaryContainer,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 5,
            ),
            isCollapsed: true,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(
                26,
              ),
            ),
          ),
          items: categories
              .map(
                (category) => DropdownMenuItem(
                  value: category,
                  child: Text(category.toString()),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

class TitleForm extends StatelessWidget {
  const TitleForm({super.key});
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocSelector<EditTaskBloc, EditTaskState, String>(
      selector: (state) => state.title,
      builder: (context, title) => TextFormField(
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
