import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tip_calculator/main.dart';

void main() {
  testWidgets('updates bill split live and keeps at least one person', (tester) async {
    tester.view.physicalSize = const Size(800, 1000);
    tester.view.devicePixelRatio = 1;
    await tester.pumpWidget(const TipCalculatorApp());

    expect(find.text('\$275.00'), findsOneWidget);

    await tester.enterText(find.byType(TextField), '1200');
    await tester.pump();
    expect(find.text('\$330.00'), findsOneWidget);

    for (var i = 0; i < 3; i++) {
      await tester.tap(find.byTooltip('Fewer people'));
      await tester.pump();
    }
    expect(find.text('1'), findsOneWidget);

    await tester.enterText(find.byType(TextField), '');
    await tester.pump();
    expect(find.text('\$0.00'), findsNWidgets(3));

    tester.view.resetPhysicalSize();
    tester.view.resetDevicePixelRatio();
  });
}
