import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/translations.dart';
import 'package:todo_app_v2/archive/archive.dart';
import 'package:todo_app_v2/common/global_app.dart';
import 'package:todo_app_v2/common/utils/navigation.dart';
import 'package:todo_app_v2/faq/faq.dart';
import 'package:todo_app_v2/feedback/feedback.dart';
import 'package:todo_app_v2/home/view/view.dart';
import 'package:todo_app_v2/l10n/l10n.dart';
import 'package:todo_app_v2/lists/view/lists_page.dart';
import 'package:todo_app_v2/settings/view/settings_page.dart';
import 'package:todo_app_v2/theme/theme.dart';
import 'package:todo_app_v2/user_profile/view/user_profile_page.dart';
import 'package:todos_repository/todos_repository.dart';

class App extends StatelessWidget {
  const App({required this.taskRepository, super.key});

  final TodosRepository taskRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: taskRepository,
      child: MaterialApp(
        initialRoute: RouteNames.home.name,
        navigatorKey: GlobalApp.navigatorKey,
        routes: {
          RouteNames.home.name: (context) => const HomePage(),
          RouteNames.userProfile.name: (context) => const UserProfilePage(),
          RouteNames.lists.name: (context) => const ListsPage(),
          RouteNames.archive.name: (context) => const ArchivePage(),
          RouteNames.settings.name: (context) => const SettingsPage(),
          RouteNames.feedback.name: (context) => const FeedbackPage(),
          RouteNames.faq.name: (context) => const FAQPage(),
        },
        theme: AppTheme.darkTheme,
        localizationsDelegates: const [
          ...AppLocalizations.localizationsDelegates,
          FlutterQuillLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        // debugShowMaterialGrid: true,
        home: const HomePage(),
      ),
    );
  }
}
