// Basic smoke test for the 노노링크 app.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:nonolink_front/main.dart';

void main() {
  testWidgets('StartPage renders role cards', (WidgetTester tester) async {
    await tester.pumpWidget(const NonoLinkApp());

    expect(find.text('노노링크'), findsOneWidget);
    expect(find.text('직원 / 봉사자'), findsOneWidget);
    expect(find.text('어르신'), findsOneWidget);
    expect(find.text('이웃 / 스캐너'), findsOneWidget);
  });
}
