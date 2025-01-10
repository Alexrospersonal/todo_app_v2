import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo_app_v2/edit_task/bloc/edit_task_bloc.dart';
import 'package:todo_app_v2/edit_task/widgets/widgets.dart';
import 'package:todo_app_v2/l10n/l10n.dart';
import 'package:todo_app_v2/theme/theme.dart';

class DateSelectDialogMenu extends StatefulWidget {
  const DateSelectDialogMenu({super.key});

  @override
  State<DateSelectDialogMenu> createState() => _DateSelectDialogMenuState();
}

class _DateSelectDialogMenuState extends State<DateSelectDialogMenu> {
  void pickTime(BuildContext ctx, DateTime? selectedDay) {
    if (selectedDay != null) {
      final selectedTime = showTimePicker(
        context: context,
        initialTime: const TimeOfDay(hour: 0, minute: 0),
      );

      context
          .read<EditTaskBloc>()
          .add(EditTaskTimeChanged(taskTime: selectedTime));
    } else {
      showSnackBar(ctx, 'Before need pick the date');
    }
  }

  void pickNotification(BuildContext ctx, {bool hasTime = false}) {
    if (hasTime) {
      showDialog<void>(
        context: ctx,
        builder: (context) {
          return BlocProvider<EditTaskBloc>.value(
            value: BlocProvider.of<EditTaskBloc>(ctx),
            child: const NotificationSelectDialogMenu(),
          );
        },
      );
    } else {
      showSnackBar(ctx, 'Before need pick the time');
    }
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).colorScheme.error,
          content: Text(
            message,
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
          ),
          elevation: 10,
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final selectedDay =
        context.select((EditTaskBloc bloc) => bloc.state.taskDate);

    final hasTime = context.select((EditTaskBloc bloc) => bloc.state.hasTime);

    final timeString = hasTime && selectedDay != null
        ? DateFormat('HH:mm').format(selectedDay)
        : l10n.noneTitle;

    final hasNotification =
        context.select((EditTaskBloc bloc) => bloc.state.hasNotification);

    final notificationReminderTime = context
        .select((EditTaskBloc bloc) => bloc.state.notificationReminderTime);

    return Dialog(
      insetPadding: const EdgeInsets.all(15),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.5, horizontal: 10.5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DateSelectCalendar(),
            Row(
              children: [
                DateSelectButton(
                  onTap: () => context
                      .read<EditTaskBloc>()
                      .add(const EditTaskDateChanged()),
                  isActive: selectedDay == null,
                  title: l10n.noDate,
                ),
                DateSelectButton(
                  onTap: () => context
                      .read<EditTaskBloc>()
                      .add(const EditTaskTimeChanged(hasTime: false)),
                  isActive: !hasTime,
                  title: l10n.noTime,
                ),
              ],
            ),
            DateSelectButton(
              onTap: () => pickTime(context, selectedDay),
              isActive: hasTime,
              icon: Icons.access_time_rounded,
              title: l10n.time,
              description: timeString,
            ),
            DateSelectButton(
              onTap: () => pickNotification(context, hasTime: hasTime),
              isActive: hasNotification,
              icon: Icons.notifications_active,
              title: l10n.notification,
              description: notificationReminderTime.formatTime(l10n),
            ),
            DateSelectButton(
              onTap: () {},
              isActive: false,
              icon: Icons.repeat,
              title: 'Повтори',
              description: 'Протягом тидня та дня',
            ),
            DateSelectConfirmButtons(
              confirm: () {},
              cancel: () {
                Navigator.of(context).pop();
              },
              clear: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class DateSelectCalendar extends StatelessWidget {
  const DateSelectCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedDay =
        context.select((EditTaskBloc bloc) => bloc.state.taskDate);

    final selectedWeekdays = context
        .select<EditTaskBloc, List<int>>((bloc) => bloc.state.repeatDuringWeek);

    return TableCalendar<void>(
      locale: Localizations.localeOf(context).toString(),
      firstDay: DateTime.utc(2010, 10, 16),
      lastDay: DateTime.utc(2030, 3, 14),
      focusedDay: selectedDay ?? DateTime.now(),
      selectedDayPredicate: (day) => isSameDay(day, selectedDay),
      onDaySelected: (selectedDay, focusedDay) {
        final now = DateTime.now();
        final today = DateTime(now.year, now.month, now.day);

        if (selectedDay.compareTo(today) >= 0) {
          context.read<EditTaskBloc>().add(
                EditTaskDateChanged(taskDate: selectedDay),
              );
        }
      },
      calendarBuilders: CalendarBuilders(
        defaultBuilder: (context, day, focusedDay) {
          if (selectedWeekdays.contains(day.weekday)) {
            return Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondaryContainer,
                shape: BoxShape.circle,
              ),
              child: Text('${day.day}'),
            );
          }
          return null;
        },
      ),
      headerStyle: const HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
      ),
      calendarStyle: CalendarStyle(
        todayDecoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withAlpha(128),
          shape: BoxShape.circle,
        ),
        selectedDecoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

class DateSelectButton extends StatelessWidget {
  const DateSelectButton({
    required this.onTap,
    required this.isActive,
    required this.title,
    this.icon,
    this.description,
    super.key,
  });

  final VoidCallback onTap;
  final bool isActive;
  final IconData? icon;
  final String title;
  final String? description;

  @override
  Widget build(BuildContext context) {
    final bgColor = isActive
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.secondaryContainer;

    final color = isActive ? Theme.of(context).colorScheme.surface : greyColor;

    final titlePadding = icon != null ? 5.0 : 0.0;

    final rowSize = description != null ? MainAxisSize.max : MainAxisSize.min;

    final textStyle = TextStyle(
      color: color,
    );

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(7.5),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          height: 31,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(26),
            color: bgColor,
          ),
          child: Row(
            mainAxisSize: rowSize,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  if (icon != null) Icon(icon, color: color),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: titlePadding),
                    child: Text(
                      title,
                      style: textStyle,
                    ),
                  ),
                ],
              ),
              if (description != null)
                Text(
                  description!,
                  style: textStyle,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class DateSelectConfirmButtons extends StatelessWidget {
  const DateSelectConfirmButtons({
    required this.confirm,
    required this.cancel,
    required this.clear,
    super.key,
  });

  final VoidCallback confirm;
  final VoidCallback cancel;
  final VoidCallback clear;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Padding(
      padding: const EdgeInsets.fromLTRB(7.5, 7.5, 7.5, 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ConfirmTextButton(
            name: l10n.clearBtnName,
            color: Theme.of(context).colorScheme.error,
            onTap: clear,
          ),
          Row(
            children: [
              ConfirmTextButton(
                name: l10n.cancelBtnName,
                color: Theme.of(context).colorScheme.secondaryContainer,
                onTap: cancel,
              ),
              const SizedBox(
                width: 15,
              ),
              ConfirmTextButton(
                name: l10n.confirmBtnName,
                color: Theme.of(context).colorScheme.primary,
                onTap: confirm,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ConfirmTextButton extends StatelessWidget {
  const ConfirmTextButton({
    required this.name,
    required this.color,
    required this.onTap,
    super.key,
  });

  final String name;
  final VoidCallback onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Text(
          name,
          style: TextStyle(color: color),
        ),
      ),
    );
  }
}
