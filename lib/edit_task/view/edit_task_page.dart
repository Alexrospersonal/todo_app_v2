import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:todo_app_v2/edit_task/bloc/edit_task_bloc.dart';
import 'package:todo_app_v2/home/widgets/custom_app_bar.dart';
import 'package:todo_app_v2/l10n/l10n.dart';
import 'package:todo_app_v2/theme/theme.dart';
import 'package:todos_repository/todos_repository.dart';

// TODO: вирішити баз з фокусом. Перенести конторолер Description сюди
//і коли заврешується завданяя то викликати подію збереження даних та передати їй Json в блок а з блоку в базу
class EditTaskPage extends StatelessWidget {
  const EditTaskPage({this.initialTask, super.key});

  final TaskEntity? initialTask;

  static Route<void> route({TaskEntity? initialTask}) {
    return MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) {
        return EditTaskPage(
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
    context.read<EditTaskBloc>().add(const EditTaskLoadCategories());
    final state = context.read<EditTaskBloc>().state;

    var document = Document.fromJson([
      {'insert': '\n'},
    ]);

    // Оновлення документа, якщо є нові дані
    if (state.notate.isNotEmpty) {
      document = Document.fromJson(jsonDecode(state.notate) as List<dynamic>);
    }

    // Ініціалізація QuillController
    _descriptionController = QuillController(
      document: document,
      selection: const TextSelection.collapsed(offset: 0),
    );
    // _descriptionController.addListener(_onDocumentChanged);
  }

  // void _onDocumentChanged() {
  //   final json = jsonEncode(_descriptionController
  // .document.toDelta().toJson());
  //   context.read<EditTaskBloc>()
  //.add(EditTaskDescriptionChanged(notate: json));
  // }

  void submitTask() {
    final jsonString =
        jsonEncode(_descriptionController.document.toDelta().toJson());

    context.read<EditTaskBloc>().add(
          EditTaskSubmitted(description: jsonString),
        );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final color = context.watch<EditTaskBloc>().state.color;

    return Scaffold(
      appBar: CustomAppBar(
        title: l10n.taskEditTitleName,
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
              color.color,
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
      // floatingActionButton: Container(
      //   margin: const EdgeInsets.only(top: 36),
      //   height: 54,
      //   width: 54,
      //   child: FloatingActionButton(
      //     backgroundColor: Theme.of(context).colorScheme.primary,
      //     shape: const CircleBorder(),
      //     heroTag: 'doneBtn',
      //     child: const Icon(Icons.add),
      //     onPressed: () {
      //       context.read<EditTaskBloc>().add(const EditTaskSubmitted());
      //     },
      //   ),
      // ),
      // floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      // floatingActionButtonLocation:
      //     FloatingActionButtonLocation.miniCenterDocked,
    );
  }
}

class DescriptionTextEditor extends StatefulWidget {
  const DescriptionTextEditor({required QuillController controller, super.key})
      : _controller = controller;

  final QuillController _controller;

  @override
  State<DescriptionTextEditor> createState() => _DescriptionTextEditorState();
}

class _DescriptionTextEditorState extends State<DescriptionTextEditor> {
  // late QuillController _controller;

  // @override
  // void initState() {
  //   super.initState();

  //   // Ініціалізація QuillController
  //   _controller = QuillController(
  //     document: Document.fromJson(
  //       [
  //         {'insert': '\n'},
  //       ],
  //     ),
  //     selection: const TextSelection.collapsed(offset: 0),
  //   );
  //   _controller.addListener(_onDocumentChanged);
  // }

  // @override
  // void dispose() {
  //   _controller
  //     ..removeListener(_onDocumentChanged)
  //     ..dispose();
  //   super.dispose();
  // }

  // void _onDocumentChanged() {
  //   final json = jsonEncode(_controller.document.toDelta().toJson());
  //   context.read<EditTaskBloc>().add(EditTaskDescriptionChanged(notate: json));
  // }

  @override
  Widget build(BuildContext context) {
    final controller = widget._controller;

    return Flexible(
      child: SizedBox(
        height: 500,
        child: Column(
          children: [
            SizedBox(
              height: 34,
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                scrollDirection: Axis.horizontal,
                children: [
                  QuillToolbarHistoryButton(
                    isUndo: true,
                    // options: conf.buttonOptions.undoHistory,
                    controller: controller,
                    options: const QuillToolbarHistoryButtonOptions(
                      iconSize: 10,
                    ),
                  ),
                  QuillToolbarHistoryButton(
                    isUndo: false,
                    // options: conf.buttonOptions.undoHistory,
                    controller: controller,
                    options: const QuillToolbarHistoryButtonOptions(
                      iconSize: 10,
                    ),
                  ),
                  QuillToolbarFontSizeButton(
                    controller: controller,
                    options: const QuillToolbarFontSizeButtonOptions(
                      iconSize: 10,
                    ),
                  ),
                  QuillToolbarToggleStyleButton(
                    attribute: Attribute.bold,
                    controller: controller,
                    options: const QuillToolbarToggleStyleButtonOptions(
                      iconSize: 10,
                    ),
                  ),
                  QuillToolbarToggleStyleButton(
                    attribute: Attribute.italic,
                    controller: controller,
                    options: const QuillToolbarToggleStyleButtonOptions(
                      iconSize: 10,
                    ),
                  ),
                  QuillToolbarClearFormatButton(
                    controller: controller,
                    options: const QuillToolbarBaseButtonOptions(
                      iconSize: 10,
                    ),
                  ),
                  QuillToolbarToggleCheckListButton(
                    controller: controller,
                    options: const QuillToolbarToggleCheckListButtonOptions(
                      iconSize: 10,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 34,
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                scrollDirection: Axis.horizontal,
                children: [
                  QuillToolbarColorButton(
                    controller: controller,
                    isBackground: false,
                    options: const QuillToolbarColorButtonOptions(
                      iconSize: 10,
                    ),
                  ),
                  QuillToolbarColorButton(
                    controller: controller,
                    isBackground: true,
                    options: const QuillToolbarColorButtonOptions(
                      iconSize: 10,
                    ),
                  ),
                  QuillToolbarSelectHeaderStyleDropdownButton(
                    controller: controller,
                    options:
                        // ignore: lines_longer_than_80_chars
                        const QuillToolbarSelectHeaderStyleDropdownButtonOptions(
                      iconSize: 10,
                    ),
                  ),
                  QuillToolbarToggleStyleButton(
                    attribute: Attribute.ol,
                    controller: controller,
                    options: const QuillToolbarToggleStyleButtonOptions(
                      iconSize: 10,
                    ),
                  ),
                  QuillToolbarToggleStyleButton(
                    attribute: Attribute.ul,
                    controller: controller,
                    options: const QuillToolbarToggleStyleButtonOptions(
                      iconSize: 10,
                    ),
                  ),
                  QuillToolbarIndentButton(
                    controller: controller,
                    isIncrease: true,
                    options: const QuillToolbarIndentButtonOptions(
                      iconSize: 10,
                    ),
                  ),
                  QuillToolbarIndentButton(
                    controller: controller,
                    isIncrease: false,
                    options: const QuillToolbarIndentButtonOptions(
                      iconSize: 10,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Theme.of(context)
                      .colorScheme
                      .secondaryContainer
                      .withAlpha(180),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: QuillEditor.basic(
                  controller: controller,
                  configurations: const QuillEditorConfigurations(),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    // return BlocBuilder<EditTaskBloc, EditTaskState>(
    //   builder: (context, state) {
    //     if (state.notate.isNotEmpty) {
    //   // Оновлення документа, якщо є нові дані
    //   final updatedDocument =
    //       Document.fromJson(jsonDecode(state.notate) as List<dynamic>);
    //   if (controller.document.toPlainText() !=
    //       updatedDocument.toPlainText()) {
    //     controller.document = updatedDocument;
    //   }
    // }
    //   },
    // );
  }
}

class SubtasksContainer extends StatefulWidget {
  const SubtasksContainer({super.key});

  @override
  State<SubtasksContainer> createState() => _SubtasksContainerState();
}

class _SubtasksContainerState extends State<SubtasksContainer> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<EditTaskBloc, EditTaskState, List<SubTask>>(
      selector: (state) => state.subtasks,
      builder: (context, subtasks) {
        final subtaskItems = subtasks
            .map(
              (subtask) => SubtaskItem(
                key: ValueKey(subtask.id),
                subtask: subtask,
              ),
            )
            .toList();

        var containerHeight =
            subtasks.length * 48.0; // Припустимо, висота одного елемента 30

        // Обмеження максимального розміру контейнера
        containerHeight = containerHeight > 288 ? 288 : containerHeight;

        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (_scrollController.hasClients && containerHeight > 256) {
            _scrollController.animateTo(
              _scrollController.position.maxScrollExtent - 30,
              duration: const Duration(milliseconds: 200),
              curve: Curves.linear,
            );
            // .jumpTo(_scrollController.position.maxScrollExtent);
          }
        });

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300), // Анімація зміни висоти
          height: containerHeight,
          child: Scrollbar(
            controller: _scrollController,
            child: ListView(
              controller: _scrollController,
              children: subtaskItems,
            ),
          ),
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
    final l10n = context.l10n;

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
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  decoration: subtask.completed
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
            decoration: InputDecoration(
              isCollapsed: true,
              border: InputBorder.none,
              hintText: l10n.taskTitleHelperText,
              hintStyle: Theme.of(context).textTheme.bodyMedium,
            ),
            onChanged: (value) {
              context.read<EditTaskBloc>().add(
                    EditTaskSubtaskChanged(id: subtask.id, title: value),
                  );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
          child: GestureDetector(
            onTap: () {
              context
                  .read<EditTaskBloc>()
                  .add(EditTaskSubtaskDeleted(id: subtask.id));
            },
            child: Icon(
              Icons.cancel_outlined,
              size: 24,
              color: Theme.of(context).colorScheme.error,
            ),
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
      builder: (context, selectedColor) {
        final colors = AccentColor.values.map(
          (e) => ColorPickerItem(
            selectedColor: selectedColor,
            color: e,
          ),
        );

        return Row(
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
            ...colors,
          ],
        );
      },
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
