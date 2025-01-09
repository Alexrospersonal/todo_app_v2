import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_v2/edit_task/bloc/edit_task_bloc.dart';
import 'package:todo_app_v2/edit_task/models/reminder_time.dart';
import 'package:todo_app_v2/edit_task/widgets/date_select_dialog_menu.dart';
import 'package:todo_app_v2/edit_task/widgets/widgets.dart';
import 'package:todo_app_v2/l10n/l10n.dart';

class NotificationSelectDialogMenu extends StatefulWidget {
  const NotificationSelectDialogMenu({super.key});

  @override
  State<NotificationSelectDialogMenu> createState() =>
      _NotificationSelectDialogMenuState();
}

class _NotificationSelectDialogMenuState
    extends State<NotificationSelectDialogMenu> {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocSelector<EditTaskBloc, EditTaskState, ReminderTime>(
      selector: (state) => state.notificationReminderTime,
      builder: (context, selectedReminder) {
        return Dialog(
          insetPadding: const EdgeInsets.all(15),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 2.5, horizontal: 10.5),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(7.5),
                  child: Row(
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.notifications_active),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            l10n.notification,
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: DropdownButtonFormField(
                          value: selectedReminder,
                          decoration: InputDecoration(
                            filled: true,
                            hintStyle: Theme.of(context).textTheme.bodyMedium,
                            fillColor: Theme.of(context)
                                .colorScheme
                                .secondaryContainer,
                            contentPadding:
                                const EdgeInsets.fromLTRB(20, 5, 5, 5),
                            isCollapsed: true,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(
                                10,
                              ),
                            ),
                          ),
                          items: ReminderTime.values
                              .map(
                                (reminderTime) =>
                                    DropdownMenuItem<ReminderTime>(
                                  value: reminderTime,
                                  child: Text(
                                    reminderTime.formatTime(l10n),
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            if (value != null) {
                              context.read<EditTaskBloc>().add(
                                    EditTaskNotificationTimeChanged(
                                      reminderTime: value,
                                    ),
                                  );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                DateSelectConfirmButtons(
                  confirm: () {
                    Navigator.of(context).pop();
                  },
                  cancel: () {
                    Navigator.of(context).pop();
                  },
                  clear: () {
                    context.read<EditTaskBloc>().add(
                          const EditTaskNotificationTimeChanged(
                            reminderTime: ReminderTime.none,
                          ),
                        );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
