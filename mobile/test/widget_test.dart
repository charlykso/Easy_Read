// This is a simple test

import 'package:easy_read/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Simple home widget test', (WidgetTester tester) async {
    // Build my app and trigger a frame.
    await tester.pumpWidget(const ProviderScope(child: MyApp()));

    // Verify that my home widget is on.
    expect(find.text('Easy Read'), findsOneWidget);
  });
}
