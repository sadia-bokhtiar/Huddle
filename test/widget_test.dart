import 'package:flutter_test/flutter_test.dart';
import 'package:huddle/main.dart';

void main() {
  testWidgets('App shows login screen', (WidgetTester tester) async {
    await tester.pumpWidget(const HuddleApp());

    expect(find.text('Huddle'), findsOneWidget);
    expect(find.text('Sign in'), findsOneWidget);
  });
}