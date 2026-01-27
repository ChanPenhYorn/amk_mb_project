import 'package:flutter_test/flutter_test.dart';

import 'package:khqr_scan_package/evm_pact_class.dart';

void main() {
  group('CRC Validation Tests', () {
    final validator = EmvSpec();

    test('should return true for a valid KHQR string', () {
      // Construct a valid packet dynamically so the CRC is always correct
      const payload = '0002010102116304'; // Ends with CRC tag (63) and length (04)
      final crc = validator.crc16ccitt(payload);
      final crcHex = crc.toRadixString(16).toUpperCase().padLeft(4, '0');
      final validQR = '$payload$crcHex';
      
      expect(validator.validateCRC(validQR), isTrue);
    });

    test('should return false for an invalid/tampered QR string', () {
      const invalidQR = "invalid_data";
      expect(validator.validateCRC(invalidQR), false);
    });
  });
}
