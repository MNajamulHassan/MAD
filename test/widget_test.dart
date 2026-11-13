import 'package:flutter_test/flutter_test.dart';

import 'package:foodie_express/main.dart';

void main() {
  testWidgets('Splash screen shows, then moves to login', (tester) async {
    await tester.pumpWidget(const FoodieExpressApp());

    // Splash is visible first
    expect(find.text('Hot food at your door'), findsOneWidget);

    // After 3 seconds the timer opens the login screen
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();

    expect(find.text('Log In'), findsOneWidget);
  });
}
