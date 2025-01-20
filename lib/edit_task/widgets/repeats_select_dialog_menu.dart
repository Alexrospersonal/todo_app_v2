import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app_v2/edit_task/bloc/edit_task_bloc.dart';
import 'package:todo_app_v2/home/view/home_page.dart';
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

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final weekdaysTitle = _getWeekdaysTitle(context);

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
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DialogSubHeader(
                  iconData: Icons.calendar_month_outlined,
                  header: 'Кінець повтору',
                ),
                RepeatsEndPickButton(
                  isActive: false,
                ),
              ],
            ),
          ],
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

class RepeatsEndPickButton extends StatelessWidget {
  const RepeatsEndPickButton({
    required this.isActive,
    super.key,
  });

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final color = isActive
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.secondaryContainer;

    return Container(
      height: 34,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: color,
      ),
      child: const Center(child: Text('Немає')),
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
