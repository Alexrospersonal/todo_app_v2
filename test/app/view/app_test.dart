import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app_v2/app/app.dart';
import 'package:todo_app_v2/counter/counter.dart';

void main() {
  group('App', () {
    testWidgets('renders CounterPage', (tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(CounterPage), findsOneWidget);
    });
  });
}
