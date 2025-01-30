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
      showSnackBar(ctx, ctx.l10n.beforePickDate);
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
      showSnackBar(ctx, ctx.l10n.beforePickTime);
    }
  }

  void pickRepeats(BuildContext ctx, {bool hasDate = false}) {
    if (hasDate) {
      showDialog<void>(
        context: ctx,
        builder: (context) {
          return BlocProvider<EditTaskBloc>.value(
            value: BlocProvider.of<EditTaskBloc>(ctx),
            child: const RepeatsSelectDialogMenu(),
          );
        },
      );
    } else {
      showSnackBar(ctx, ctx.l10n.beforePickDate);
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

  String getWeekdaysTitle(BuildContext context, List<int> weekdays) {
    if (weekdays.length == 7) {
      return context.l10n.repeatsDuringWeek;
    }

    if (weekdays.isEmpty) {
      return context.l10n.noneTitle;
    }

    return weekdays.map((day) {
      final date =
          DateTime.now().add(Duration(days: day - DateTime.now().weekday));
      return DateFormat('E', Localizations.localeOf(context).languageCode)
          .format(date)
          .toUpperCase();
    }).toString();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final selectedDay =
        context.select((EditTaskBloc bloc) => bloc.state.taskDate);

    final hasTime = context.select((EditTaskBloc bloc) => bloc.state.hasTime);

    final repeatsOfWeek =
        context.select((EditTaskBloc bloc) => bloc.state.repeatDuringWeek);

    final hasNotification =
        context.select((EditTaskBloc bloc) => bloc.state.hasNotification);

    final hasRepeats =
        context.select((EditTaskBloc bloc) => bloc.state.hasRepeats);

    final timeString = hasTime && selectedDay != null
        ? DateFormat('HH:mm').format(selectedDay)
        : l10n.noneTitle;

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
            DateSelectCalendar(
              selectedDay:
                  context.select((EditTaskBloc bloc) => bloc.state.taskDate),
              onDaySelected: (newDate) => context.read<EditTaskBloc>().add(
                    EditTaskDateChanged(taskDate: newDate),
                  ),
            ),
            Row(
              children: [
                SelectButton(
                  onTap: () => context
                      .read<EditTaskBloc>()
                      .add(const EditTaskDateChanged()),
                  isActive: selectedDay == null,
                  title: l10n.noDate,
                ),
                SelectButton(
                  onTap: () => context
                      .read<EditTaskBloc>()
                      .add(const EditTaskTimeChanged(hasTime: false)),
                  isActive: !hasTime,
                  title: l10n.noTime,
                ),
              ],
            ),
            SelectButton(
              onTap: () => pickTime(context, selectedDay),
              isActive: hasTime,
              icon: Icons.access_time_rounded,
              title: l10n.time,
              description: timeString,
            ),
            SelectButton(
              onTap: () => pickNotification(context, hasTime: hasTime),
              isActive: hasNotification,
              icon: Icons.notifications_active,
              title: l10n.notification,
              description: notificationReminderTime.formatTime(l10n),
            ),
            SelectButton(
              onTap: () => pickRepeats(context, hasDate: selectedDay != null),
              isActive: hasRepeats,
              icon: Icons.repeat,
              title: l10n.repeatsTitle,
              description: getWeekdaysTitle(
                context,
                repeatsOfWeek,
              ),
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
  const DateSelectCalendar({
    required this.selectedDay,
    required this.onDaySelected,
    super.key,
  });

  final DateTime? selectedDay;
  final void Function(DateTime?) onDaySelected;

  Widget? _dayBuilder(BuildContext context, DateTime day, DateTime focusedDay) {
    return _buildRepeatMarkers(
      endDateOfRepeatedly:
          context.select((EditTaskBloc bloc) => bloc.state.endDateOfRepeatedly),
      day: day,
      context: context,
      selectedWeekdays:
          context.select((EditTaskBloc bloc) => bloc.state.repeatDuringWeek),
      focusedDay: focusedDay,
    );
  }

  Widget? _buildRepeatMarkers({
    required DateTime? endDateOfRepeatedly,
    required DateTime day,
    required BuildContext context,
    required List<int> selectedWeekdays,
    required DateTime focusedDay,
  }) {
    if (_isEndDay(endDateOfRepeatedly, day)) {
      return _buildEndDayMarker(day, context);
    } else if (_isRepeatedDay(
      selectedWeekdays,
      day,
      focusedDay,
      endDateOfRepeatedly,
    )) {
      return _buildRepeatedDayMarker(day, context);
    }
    return null;
  }

  bool _isEndDay(DateTime? endDateOfRepeatedly, DateTime day) {
    return endDateOfRepeatedly != null &&
        endDateOfRepeatedly.compareTo(day) == 0;
  }

  Widget _buildEndDayMarker(
    DateTime day,
    BuildContext context,
  ) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.error,
        shape: BoxShape.circle,
      ),
      child: Text('${day.day}'),
    );
  }

  Widget _buildRepeatedDayMarker(
    DateTime day,
    BuildContext context,
  ) {
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

  bool _isRepeatedDay(
    List<int> selectedWeekdays,
    DateTime day,
    DateTime focusedDay,
    DateTime? endDate,
  ) {
    return selectedWeekdays.contains(day.weekday) &&
        day.isAfter(focusedDay) &&
        (endDate == null || day.isBefore(endDate));
  }

  void _selectDay(DateTime selectedDay) {
    final today = DateTime.now().copyWith(
      hour: 0,
      minute: 0,
      second: 0,
      millisecond: 0,
      microsecond: 0,
    );
    if (selectedDay.isAfter(today) || selectedDay.isAtSameMomentAs(today)) {
      onDaySelected(selectedDay);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar<void>(
      startingDayOfWeek: StartingDayOfWeek.monday,
      locale: Localizations.localeOf(context).toString(),
      firstDay: DateTime.utc(2010, 10, 16),
      lastDay: DateTime.utc(2030, 3, 14),
      focusedDay: selectedDay ?? DateTime.now(),
      selectedDayPredicate: (day) => isSameDay(day, selectedDay),
      onDaySelected: (selectedDay, focusedDay) => _selectDay(selectedDay),
      calendarBuilders: CalendarBuilders(
        outsideBuilder: _dayBuilder,
        defaultBuilder: _dayBuilder,
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

class SelectButton extends StatelessWidget {
  const SelectButton({
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
