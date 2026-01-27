import 'package:amk_bank_project/presentation/views/settings/theme_settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('ThemeSettingsScreen displays all sections', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const ProviderScope(child: MaterialApp(home: ThemeSettingsScreen())),
    );

    // Verify AppBar
    expect(find.text('Banking App Theme & Settings'), findsOneWidget);
    expect(
      find.byIcon(Icons.nightlight_round),
      findsOneWidget,
    ); // Assuming Light mode default

    // Verify Language Selector
    expect(find.text('Language / ភាសា / 语言'), findsOneWidget);
    expect(find.text('Khmer'), findsOneWidget);
    expect(find.text('English'), findsNWidgets(2));

    // Verify Font Scale
    expect(find.textContaining('Font Scale:'), findsOneWidget);
    expect(find.byType(Slider), findsOneWidget);

    // Verify Welcome Card
    expect(find.text('Welcome to Banking App'), findsOneWidget);

    // Verify Color Palette
    expect(find.text('Color Palette'), findsOneWidget);
    expect(find.text('Primary'), findsOneWidget);

    // Verify Typography
    expect(find.text('Typography'), findsOneWidget);
    expect(find.text('Display Large'), findsOneWidget);

    // Verify Custom Buttons
    expect(find.text('Custom Buttons'), findsOneWidget);
    expect(find.text('Primary Button'), findsOneWidget); // Just check one

    // Verify Custom Inputs
    expect(find.text('Custom Input Fields'), findsOneWidget);
  });
}
