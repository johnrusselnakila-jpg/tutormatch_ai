import 'package:flutter_test/flutter_test.dart';

import 'package:semester_project/app.dart';

void main() {
  testWidgets('TutorMatch A.I. app builds and shows the app title',
      (WidgetTester tester) async {
    await tester.pumpWidget(const TutorMatchApp());

    expect(find.text('TutorMatch A.I.'), findsOneWidget);
  });
}