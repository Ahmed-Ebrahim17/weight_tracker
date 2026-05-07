import 'package:flutter_test/flutter_test.dart';
import 'package:weight_tracker/core/routing/app_router.dart';
import 'package:weight_tracker/weight_tracker_app.dart';

void main() {
  testWidgets('Shows splash call-to-action', (WidgetTester tester) async {
    await tester.pumpWidget(
      WeightTrackerApp(appRouter: AppRouter(), initialRoute: '/'),
    );
    await tester.pumpAndSettle();

    expect(find.text('ENTER THE FLOW'), findsOneWidget);
  });
}
