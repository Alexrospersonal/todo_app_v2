import 'package:flutter/material.dart';
import 'package:todo_app_v2/l10n/l10n.dart';
import 'package:todo_app_v2/l10n/user_status_provider.dart';

class UserStatusBar extends StatelessWidget {
  const UserStatusBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TodayUserStatus(),
        DeterminatedTasksStatus(),
      ],
    );
  }
}

class TodayUserStatus extends StatelessWidget {
  const TodayUserStatus({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final statusProvider = UserStatusProvider(l10n: l10n);

    return Row(
      children: [
        const Text(
          '😉',
          style: TextStyle(fontSize: 28, height: 1),
        ),
        const SizedBox(width: 5),
        RichText(
          text: TextSpan(
            text: l10n.yourStatus,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  height: 1,
                ),
            children: [
              TextSpan(
                text: '\n${statusProvider.getStatus(0)}',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      height: 1,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class DeterminatedTasksStatus extends StatelessWidget {
  const DeterminatedTasksStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: 'determinated\ntasks:',
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              height: 1,
            ),
        children: [
          TextSpan(
            text: '${7}',
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(height: 1, color: Colors.red),
          ),
        ],
      ),
      textAlign: TextAlign.right,
    );
  }
}
