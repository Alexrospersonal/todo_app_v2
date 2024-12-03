import 'package:flutter/material.dart';
import 'package:todo_app_v2/common/widgets/widgets.dart';
import 'package:todo_app_v2/l10n/l10n.dart';

class ListsPage extends StatelessWidget {
  const ListsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ListsView();
  }
}

class ListsView extends StatelessWidget {
  const ListsView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: CommonAppBar(title: l10n.lists),
    );
  }
}
