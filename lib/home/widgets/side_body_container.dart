import 'dart:math';

import 'package:flutter/material.dart';
import 'package:todo_app_v2/l10n/l10n.dart';

class SideBodyContainer extends StatelessWidget {
  const SideBodyContainer({
    required bool isOpen,
    required Widget child,
    super.key,
  })  : _isOpen = isOpen,
        _nestedContainer = child;

  final Widget _nestedContainer;
  final bool _isOpen;

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 200),
      curve: Curves.fastOutSlowIn,
      width: 220,
      left: _isOpen ? 0 : -220,
      height: MediaQuery.of(context).size.height,
      child: _nestedContainer,
    );
  }
}

class SidePanel extends StatelessWidget {
  const SidePanel({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'LOGO',
            style: Theme.of(context).textTheme.displaySmall,
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView(
              children: [
                CustomListTile(
                  leadingIcon: Icons.account_circle,
                  title: l10n.userProfile,
                ),
                CustomListTile(
                  leadingIcon: Icons.list_alt_outlined,
                  title: l10n.lists,
                ),
                CustomListTile(
                  leadingIcon: Icons.folder_delete,
                  title: l10n.archive,
                ),
                CustomListTile(
                  leadingIcon: Icons.settings,
                  title: l10n.settings,
                ),
                CustomListTile(
                  leadingIcon: Icons.feedback_rounded,
                  title: l10n.feedback,
                ),
                CustomListTile(
                  leadingIcon: Icons.chat_rounded,
                  title: l10n.faq,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    required this.leadingIcon,
    required this.title,
    this.callback,
    super.key,
  });

  final IconData leadingIcon;
  final String title;
  final VoidCallback? callback;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Icon(leadingIcon),
            const SizedBox(width: 5),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}
