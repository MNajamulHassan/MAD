import 'package:flutter_test/flutter_test.dart';

import 'package:foodie_express/main.dart';

void main() {
  testWidgets('Login screen shows on start', (WidgetTester tester) async {
    await tester.pumpWidget(const FoodieExpressApp());

    expect(find.text('Foodie Express'), findsOneWidget);
    expect(find.text('Log In'), findsOneWidget);
  });
}
