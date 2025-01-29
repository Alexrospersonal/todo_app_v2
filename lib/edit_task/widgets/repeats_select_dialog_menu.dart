import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo_app_v2/edit_task/bloc/edit_task_bloc.dart';
import 'package:todo_app_v2/edit_task/widgets/widgets.dart';
import 'package:todo_app_v2/l10n/l10n.dart';

class RepeatsSelectDialogMenu extends StatelessWidget {
  const RepeatsSelectDialogMenu({super.key});

  List<String> _getWeekdaysTitle(BuildContext context) {
    return List<String>.generate(7, (index) {
      final date = DateTime.now()
          .add(Duration(days: index - DateTime.now().weekday + 1));
      return DateFormat('E', Localizations.localeOf(context).languageCode)
          .format(date)[0]
          .toUpperCase();
    }).toList();
  }

  void pickEndDate(BuildContext ctx, {bool hasRepeats = false}) {
    if (hasRepeats) {
      showDialog<DateTime>(
        context: ctx,
        builder: (context) {
          return BlocProvider<EditTaskBloc>.value(
            value: BlocProvider.of<EditTaskBloc>(ctx),
            child: const EndDateCalendarDialog(),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final weekdaysTitle = _getWeekdaysTitle(context);

    final hasRepeats =
        context.select<EditTaskBloc, bool>((bloc) => bloc.state.hasRepeats);

    final endDateOfRepeats = context.select<EditTaskBloc, DateTime?>(
      (bloc) => bloc.state.endDateOfRepeatedly,
    );

    return Dialog(
      insetPadding: const EdgeInsets.all(25),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.repeat),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  l10n.repeatsDuringWeek,
                ),
              ],
            ),
            const SizedBox(height: 10),
            BlocSelector<EditTaskBloc, EditTaskState, List<int>>(
              selector: (state) => state.repeatDuringWeek,
              builder: (context, weekdays) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List<Widget>.generate(7, (index) {
                    final weekday = index + 1;

                    return WeekdayPickButton(
                      id: weekday,
                      isSelected: weekdays.contains(weekday),
                      dayTitle: weekdaysTitle[index],
                      onTap: () {
                        context
                            .read<EditTaskBloc>()
                            .add(EditTaskWeekdayChanged(weekday: weekday));
                      },
                    );
                  }).toList(),
                );
              },
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DialogSubHeader(
                  iconData: Icons.calendar_month_outlined,
                  header: l10n.repeatEndsOn,
                ),
                RepeatsEndDatePickButton(
                  endDate: endDateOfRepeats,
                  onTap: () => pickEndDate(context, hasRepeats: hasRepeats),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class EndDateCalendarDialog extends StatelessWidget {
  const EndDateCalendarDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Dialog(
      insetPadding: const EdgeInsets.all(15),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.5, horizontal: 10.5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: DialogSubHeader(
                iconData: Icons.date_range,
                header: l10n.endDateOfRepeats,
              ),
            ),
            const EndDateCalendar(),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ConfirmTextButton(
                    name: l10n.clearBtnName,
                    color: Theme.of(context).colorScheme.error,
                    onTap: () => context.read<EditTaskBloc>().add(
                          const EditTaskEndDateOfRepeatedly(
                            endDateOfRepeatedly: null,
                          ),
                        ),
                  ),
                  ConfirmTextButton(
                    name: l10n.confirmBtnName,
                    color: Theme.of(context).colorScheme.primary,
                    onTap: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EndDateCalendar extends StatelessWidget {
  const EndDateCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedDay = context.select(
      (EditTaskBloc bloc) => bloc.state.endDateOfRepeatedly,
    );

    final startDate =
        context.select((EditTaskBloc bloc) => bloc.state.taskDate);

    final selectedWeekdays = context
        .select<EditTaskBloc, List<int>>((bloc) => bloc.state.repeatDuringWeek);

    return TableCalendar(
      focusedDay: selectedDay ?? DateTime.now(),
      firstDay: DateTime.utc(2010, 10, 16),
      lastDay: DateTime.utc(2030, 3, 14),
      locale: Localizations.localeOf(context).toString(),
      selectedDayPredicate: (day) => isSameDay(day, selectedDay),
      onDaySelected: (selectedDay, focusedDay) {
        final now = DateTime.now();
        final today = DateTime(now.year, now.month, now.day);

        if (selectedDay.compareTo(today) >= 0) {
          context.read<EditTaskBloc>().add(
                EditTaskEndDateOfRepeatedly(
                  endDateOfRepeatedly: selectedDay,
                ),
              );
        }
      },
      calendarBuilders: CalendarBuilders<void>(
        defaultBuilder: (context, day, focusedDay) {
          if (startDate != null && startDate.compareTo(day) == 0) {
            return Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                shape: BoxShape.circle,
              ),
              child: Text(
                '${day.day}',
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onPrimary),
              ),
            );
          }

          if (selectedWeekdays.contains(day.weekday) &&
              day.isAfter(startDate!) &&
              selectedDay != null &&
              day.isBefore(selectedDay)) {
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
          color: Theme.of(context).colorScheme.error,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

class DialogSubHeader extends StatelessWidget {
  const DialogSubHeader({
    required this.iconData,
    required this.header,
    super.key,
  });

  final IconData iconData;
  final String header;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(iconData),
        const SizedBox(width: 5),
        Text(header),
      ],
    );
  }
}

class RepeatsEndDatePickButton extends StatelessWidget {
  const RepeatsEndDatePickButton({
    required this.onTap,
    required this.endDate,
    super.key,
  });

  final VoidCallback onTap;
  final DateTime? endDate;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final isActive = endDate != null;

    final color = isActive
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.secondaryContainer;

    final textColor = isActive
        ? Theme.of(context).colorScheme.onPrimary
        : Theme.of(context).colorScheme.onSecondary;

    final text =
        isActive ? DateFormat('M.dd.y').format(endDate!) : l10n.neverTitle;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 34,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: color,
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(color: textColor),
          ),
        ),
      ),
    );
  }
}

class WeekdayPickButton extends StatelessWidget {
  const WeekdayPickButton({
    required this.id,
    required this.isSelected,
    required this.dayTitle,
    required this.onTap,
    super.key,
  });

  final int id;
  final bool isSelected;
  final String dayTitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = isSelected
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.secondaryContainer;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        width: 33,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            dayTitle,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
      ),
    );
  }
}
