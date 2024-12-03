import 'package:flutter/material.dart';
import 'package:todo_app_v2/common/widgets/widgets.dart';
import 'package:todo_app_v2/l10n/l10n.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const UserProfileView();
  }
}

class UserProfileView extends StatelessWidget {
  const UserProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: CommonAppBar(title: l10n.userProfile),
    );
  }
}
