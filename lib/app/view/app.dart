import 'package:flutter/material.dart';
import 'package:todo_app_v2/home/view/view.dart';
import 'package:todo_app_v2/l10n/l10n.dart';
import 'package:todo_app_v2/theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.darkTheme,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const HomePage(),
    );
  }
}
