## KHQR Scan Package

A Flutter package to scan, parse, and validate KHQR (Cambodia QR) codes. This package handles the EMVCo specification parsing and CRC validation required for KHQR transactions.

## Features

*   **Scan QR Codes:** Built-in UI for scanning QR codes using the camera.
*   **Parse KHQR:** Break down KHQR strings into readable tags (Merchant Info, Currency, Amount, etc.).
*   **Validate CRC:** Verify the integrity of the scanned QR code using CRC16-CCITT.
*   **Gallery Import:** Support for picking QR images from the gallery.

## Getting started

Add the dependency to your `pubspec.yaml`:

```yaml
dependencies:
  khqr_scan_package: ^0.0.1
```

## Usage

```dart
import 'package:khqr_scan_package/evm_pact_class.dart'; // Consider renaming file to emv_spec.dart

void main() {
  final parser = EmvSpec();
  
  String qrCode = '...'; // Your KHQR string
  
  // Validate
  bool isValid = parser.validateCRC(qrCode);
  print('Is Valid: $isValid');

  // Parse
  if (isValid) {
    // Note: You might need to implement a main parse method that calls parseSubTags
    // or use parseSubTags on specific tag values.
  }
}
```

## Additional information

TODO: Tell users more about the package: where to find more information, how to
contribute to the package, how to file issues, what response they can expect
from the package authors, and more.
