import 'package:flutter/material.dart';
import 'package:todo_app_v2/l10n/l10n.dart';
import 'package:todo_app_v2/theme/theme.dart';

class DateSelectDialogMenu extends StatelessWidget {
  const DateSelectDialogMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(15),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.5, horizontal: 7.5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DateSelectCalendar(),
            DateSelectButton(
              onTap: () {},
              isActive: true,
              title: 'Без дати',
            ),
            DateSelectButton(
              onTap: () {},
              isActive: true,
              icon: Icons.access_time_rounded,
              title: 'Час',
              description: '17:34',
            ),
            DateSelectButton(
              onTap: () {},
              isActive: false,
              icon: Icons.notifications_active,
              title: 'Нагадування',
              description: 'Ні',
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
              cancel: () {},
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
    return Container();
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
          )
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
