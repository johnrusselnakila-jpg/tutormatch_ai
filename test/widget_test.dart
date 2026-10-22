import 'package:flutter_test/flutter_test.dart';

import 'package:tutormatch_ai/app.dart';

void main() {
  testWidgets('TutorMatch A.I. app builds and shows the app title',
      (WidgetTester tester) async {
    await tester.pumpWidget(const TutorMatchApp());

    expect(find.text('TutorMatch A.I.'), findsOneWidget);
  });
}