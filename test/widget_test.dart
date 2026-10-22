// test/widget_test.dart - Widget test. Pumps the TutorMatchApp and verifies the app title appears on screen.
import 'package:flutter_test/flutter_test.dart';
import 'package:tutormatch_ai/app.dart';

void main() {
  testWidgets('TutorMatchApp shows title', (WidgetTester tester) async {
    await tester.pumpWidget(const TutorMatchApp());
    expect(find.text('TutorMatch A.I.'), findsWidgets);
  });
}
