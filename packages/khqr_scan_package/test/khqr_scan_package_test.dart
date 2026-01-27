import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:khqr_scan_package/scan_qrcode.dart'; // Adjust path

void main() {
  testWidgets('ScanScreen displays basic UI elements', (
    WidgetTester tester,
  ) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MaterialApp(home: ScanQRCode()));

    // Verify Title exists
    expect(find.text('Scan & Pay'), findsOneWidget);

    // Verify Toggle buttons exist
    expect(find.text('Scan QR Code'), findsOneWidget);
    expect(find.text('Show QR Code'), findsOneWidget);

    // Verify Action buttons exist
    expect(find.text('Flash'), findsOneWidget);
    expect(find.text('Upload QR'), findsOneWidget);
  });

  testWidgets('Tapping Show QR Code changes state', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: ScanQRCode()));

    // Tap the 'Show QR Code' tab
    await tester.tap(find.text('Show QR Code'));
    await tester.pump(); // Re-render

    // You can add logic here to check if the UI changed
    // (e.g., specific colors or icons appearing)
  });
}
