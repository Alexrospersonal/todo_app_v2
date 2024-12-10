import 'package:flutter/material.dart';
import 'package:todo_app_v2/theme/theme.dart';

class TodosList extends StatelessWidget {
  const TodosList({super.key});

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 1),
        child: Column(
          children: [
            TodoCard(),
          ],
        ),
      ),
    );
  }
}

class TodoCard extends StatelessWidget {
  const TodoCard({this.isFinish = false, this.isOVerdute = false, super.key});

  final bool isFinish;
  final bool isOVerdute;

  WidgetStatePropertyAll<Color> getFillColor(BuildContext context) {
    Color fillColor;

    if (isFinish && !isOVerdute) {
      fillColor = Theme.of(context).colorScheme.primary;
    } else if (isOVerdute) {
      fillColor = Theme.of(context).colorScheme.error;
    } else {
      fillColor = Theme.of(context).colorScheme.onPrimary;
    }

    return WidgetStatePropertyAll<Color>(fillColor);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 87,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        color: Theme.of(context).colorScheme.secondaryContainer,
        gradient: RadialGradient(
          colors: [
            Theme.of(context).colorScheme.primary,
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
              onChanged: (value) {},
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'HOME',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                  ),
                  Text(
                    'Прийняти ліки',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  Text('38 JANUARY 2024 13:45'),
                  Row(
                    children: [
                      Icon(
                        Icons.notifications_active,
                        size: 14,
                      ),
                      Row(
                        children: [
                          Icon(Icons.repeat),
                          Text(
                            'Sun Mon Thu Fri Sat',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.av_timer_sharp),
                          Text(
                            '09:21 13:33 16:28 20:45',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const CardStar(
              isImportant: false,
            ),
          ],
        ),
      ),
    );
  }
}

class CardStar extends StatelessWidget {
  const CardStar({required this.isImportant, super.key});

  final bool isImportant;

  @override
  Widget build(BuildContext context) {
    final color = isImportant
        ? yellowColor
        : Theme.of(context).colorScheme.secondaryContainer;

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
