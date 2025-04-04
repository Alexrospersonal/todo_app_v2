import 'package:flutter/material.dart';
import 'package:todo_app_v2/common/widgets/widgets.dart';
import 'package:todo_app_v2/l10n/l10n.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SettingsView();
  }
}

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: CommonAppBar(title: l10n.settings),
    );
  }
}
