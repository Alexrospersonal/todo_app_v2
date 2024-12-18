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

    final color = context.watch<EditTaskBloc>().state.color;

    return Scaffold(
      appBar: AppBar(),
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            radius: 1,
            center: Alignment.bottomCenter,
            colors: [
              color.color,
              Theme.of(context).colorScheme.surface,
            ],
          ),
        ),
        child: Form(
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
              const SubtasksContainer(),
              Row(
                children: [
                  const DropdownCategorySelector(),
                  const SubtaskIconButton(),
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
              const ColorPicker(),
            ],
          ),
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

class SubtasksContainer extends StatelessWidget {
  const SubtasksContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<EditTaskBloc, EditTaskState, List<SubTask>>(
      selector: (state) => state.subtasks,
      builder: (context, subtasks) {
        final subtaskItems = subtasks
            .map(
              (subtask) => SubtaskItem(
                subtask: subtask,
              ),
            )
            .toList();
        return Column(
          children: subtaskItems,
        );
      },
    );
  }
}

class SubtaskItem extends StatelessWidget {
  const SubtaskItem({
    required this.subtask,
    super.key,
  });

  final SubTask subtask;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: subtask.completed,
          onChanged: (value) {
            context.read<EditTaskBloc>().add(
                  EditTaskSubtaskCompleted(
                    id: subtask.id,
                    completed: !subtask.completed,
                  ),
                );
          },
        ),
        Expanded(
          child: TextFormField(
            style: TextStyle(
              decoration: subtask.completed
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
            ),
            onChanged: (value) {
              context.read<EditTaskBloc>().add(
                    EditTaskSubtaskChanged(id: subtask.id, title: value),
                  );
            },
          ),
        ),
        GestureDetector(
          onTap: () {
            context
                .read<EditTaskBloc>()
                .add(EditTaskSubtaskDeleted(id: subtask.id));
          },
          child: const Icon(
            Icons.delete_forever,
            size: 24,
          ),
        ),
      ],
    );
  }
}

class SubtaskIconButton extends StatelessWidget {
  const SubtaskIconButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<EditTaskBloc, EditTaskState, List<SubTask>>(
      selector: (state) => state.subtasks,
      builder: (context, subtasks) => SizedBox(
        height: 34,
        child: IconButton.filled(
          onPressed: () {
            context.read<EditTaskBloc>().add(const EditTaskSubtaskCreated());
          },
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(
              subtasks.isNotEmpty
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.secondaryContainer,
            ),
          ),
          padding: EdgeInsets.zero,
          icon: Icon(
            Icons.account_tree_rounded,
            color: subtasks.isNotEmpty ? yellowColor : greyColor,
          ),
        ),
      ),
    );
  }
}

class ColorPicker extends StatelessWidget {
  const ColorPicker({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<EditTaskBloc, EditTaskState, AccentColor>(
      selector: (state) => state.color,
      builder: (context, selectedColor) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 67,
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(26),
              gradient: RadialGradient(
                colors: [
                  selectedColor.color,
                  Theme.of(context).colorScheme.secondaryContainer,
                ],
                radius: 1.3,
                center: Alignment.centerRight,
              ),
            ),
          ),
          ColorPickerItem(
            color: AccentColor.main,
            selectedColor: selectedColor,
          ),
          ColorPickerItem(
            color: AccentColor.blue,
            selectedColor: selectedColor,
          ),
          ColorPickerItem(
            color: AccentColor.green,
            selectedColor: selectedColor,
          ),
          ColorPickerItem(
            color: AccentColor.orange,
            selectedColor: selectedColor,
          ),
          ColorPickerItem(
            color: AccentColor.red,
            selectedColor: selectedColor,
          ),
          ColorPickerItem(
            color: AccentColor.pink,
            selectedColor: selectedColor,
          ),
          ColorPickerItem(
            color: AccentColor.purple,
            selectedColor: selectedColor,
          ),
          ColorPickerItem(
            color: AccentColor.seaGreen,
            selectedColor: selectedColor,
          ),
        ],
      ),
    );
  }
}

class ColorPickerItem extends StatelessWidget {
  const ColorPickerItem({
    required this.color,
    required this.selectedColor,
    super.key,
  });

  final AccentColor color;
  final AccentColor selectedColor;

  @override
  Widget build(BuildContext context) {
    final isSelected = color == selectedColor;

    return GestureDetector(
      onTap: () =>
          context.read<EditTaskBloc>().add(EditTaskColorChanged(color: color)),
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected
                ? Theme.of(context).colorScheme.onPrimary
                : Colors.transparent,
            width: isSelected ? 2 : 0,
          ),
          color: color.color,
        ),
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

// TODO: add validation
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
