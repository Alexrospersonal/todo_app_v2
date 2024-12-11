import 'package:flutter/material.dart';
import 'package:todo_app_v2/common/utils/date_formatter.dart';
import 'package:todo_app_v2/theme/theme.dart';

class TodosList extends StatelessWidget {
  const TodosList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 10),
        child: Column(
          children: [
            TodoCard(
              category: 'HOME',
              title: 'Прийняти ліки',
              dateTime: DateTime.now(),
              isNotification: true,
              repeatDuringWeek: const [1, 2, 5, 7],
              repeatDuringDay: [DateTime.now(), DateTime.now()],
              color: AccentColor.blue,
            ),
            const SizedBox(
              height: 6,
            ),
            TodoCard(
              category: 'HOME',
              title: 'Прийняти ліки',
              dateTime: DateTime.now(),
              isFinish: true,
              color: AccentColor.pink,
            ),
            const SizedBox(
              height: 6,
            ),
            const TodoCard(
              category: 'HOME',
              title: 'Прийняти ліки',
              dateTime: null,
              isImportant: true,
              color: AccentColor.purple,
            ),
          ],
        ),
      ),
    );
  }
}

// TODO: add custom gradieants and create colors for gradiesnts.
class TodoCard extends StatefulWidget {
  const TodoCard({
    required this.category,
    required this.title,
    required this.dateTime,
    this.isNotification = false,
    this.repeatDuringWeek = const [],
    this.repeatDuringDay = const [],
    this.isImportant = false,
    this.isFinish = false,
    this.isOVerdute = false,
    this.color = AccentColor.main,
    super.key,
  });

  final String category;
  final String title;
  final DateTime? dateTime;
  final bool isNotification;

  final List<int> repeatDuringWeek;
  final List<DateTime> repeatDuringDay;

  final bool isImportant;

  final bool isFinish;
  final bool isOVerdute;
  final AccentColor color;

  @override
  State<TodoCard> createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  bool isFinish = false;

  WidgetStatePropertyAll<Color> getFillColor(BuildContext context) {
    Color fillColor;

    if (isFinish && !widget.isOVerdute) {
      fillColor = Theme.of(context).colorScheme.primary;
    } else if (widget.isOVerdute) {
      fillColor = Theme.of(context).colorScheme.error;
    } else {
      fillColor = Theme.of(context).colorScheme.onPrimary;
    }

    return WidgetStatePropertyAll<Color>(fillColor);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isFinish == true) {
      isFinish = true;
    }

    return Container(
      height: 87,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        color: Theme.of(context).colorScheme.secondaryContainer,
        gradient: RadialGradient(
          colors: [
            widget.color.color,
            Theme.of(context).colorScheme.secondaryContainer,
          ],
          radius: 3,
          center: const Alignment(1.4, 0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          children: [
            Checkbox(
              value: isFinish,
              fillColor: getFillColor(context),
              checkColor: getFillColor(context).value,
              onChanged: (value) {
                setState(() {
                  isFinish = !isFinish;
                });
              },
            ),
            TodoTextsColumn(
              category: widget.category,
              title: widget.title,
              date: DateFormatter.formatDateTime(
                context,
                widget.dateTime,
              ),
              isNotification: widget.isNotification,
              repeatDuringWeek: DateFormatter.formatNumberToWeekdays(
                context,
                widget.repeatDuringWeek,
              ),
              repeatDuringDay: DateFormatter.formatDateTimesToTimeString(
                widget.repeatDuringDay,
              ),
            ),
            CardStar(
              isImportant: widget.isImportant,
            ),
          ],
        ),
      ),
    );
  }
}

class TodoTextsColumn extends StatelessWidget {
  const TodoTextsColumn({
    required this.category,
    required this.title,
    required this.date,
    this.isNotification = false,
    this.repeatDuringWeek = '',
    this.repeatDuringDay = '',
    super.key,
  });

  final String category;
  final String title;
  final String date;
  final bool isNotification;

  final String repeatDuringWeek;
  final String repeatDuringDay;

  Color getIconColor(BuildContext context, {bool? flag}) {
    return flag != null && flag
        ? Theme.of(context).colorScheme.onPrimary
        : Theme.of(context).colorScheme.surface;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            category,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.labelSmall!.copyWith(height: 1),
          ),
          Text(
            date,
            style: const TextStyle(
              fontSize: 12,
            ),
          ),
          Row(
            children: [
              Icon(
                Icons.notifications_active,
                color: getIconColor(context, flag: isNotification),
              ),
              const SizedBox(
                width: 3,
              ),
              Row(
                children: [
                  Icon(
                    Icons.repeat,
                    color: getIconColor(
                      context,
                      flag: repeatDuringWeek.isNotEmpty,
                    ),
                  ),
                  Text(
                    repeatDuringWeek,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              const SizedBox(
                width: 3,
              ),
              Row(
                children: [
                  Icon(
                    Icons.av_timer_sharp,
                    color: getIconColor(
                      context,
                      flag: repeatDuringDay.isNotEmpty,
                    ),
                  ),
                  Text(
                    repeatDuringDay,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CardStar extends StatelessWidget {
  const CardStar({required this.isImportant, super.key});

  final bool isImportant;

  @override
  Widget build(BuildContext context) {
    final color =
        isImportant ? yellowColor : Theme.of(context).colorScheme.surface;

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 5, 15, 0),
      child: Align(
        alignment: Alignment.topRight,
        child: Icon(
          Icons.star_rate_rounded,
          size: 20,
          color: color,
        ),
      ),
    );
  }
}
