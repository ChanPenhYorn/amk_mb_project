import 'package:flutter_test/flutter_test.dart';
import 'package:khqr_scan_package/evm_pact_class.dart';

void main() {
  group('EmvSpec Unit Tests', () {
    final emvSpec = EmvSpec();

    test('CRC16 Calculation (Standard Vector)', () {
      // Standard test vector for CRC-16/CCITT-FALSE
      // Input: "123456789" -> Result: 0x29B1
      expect(emvSpec.crc16ccitt('123456789'), 0x29B1);
    });

    test('Parse Sub Tags (Valid TLV)', () {
      // Tag 00, Len 02, Val 01
      // Tag 01, Len 02, Val 11
      const input = '000201010211';
      final result = emvSpec.parseSubTags(input);

      expect(result.length, 2);
      expect(result['00'], '01');
      expect(result['01'], '11');
    });

    test('Parse Sub Tags (Partial/Invalid ignored)', () {
      // Tag 00, Len 02, Val 01
      // Tag 01, Len 05... (only 2 chars left "11") -> Should stop parsing or ignore last tag
      const input = '000201010511';
      final result = emvSpec.parseSubTags(input);

      // Should successfully parse the first tag
      expect(result['00'], '01');
      // Should not contain the second incomplete tag
      expect(result.containsKey('01'), isFalse);
    });

    test('Validate CRC (Valid)', () {
      // Construct a valid packet
      // Payload: "000201"
      // CRC Input: "0002016304"
      // CRC Calc: 0x6669
      const payload = '0002016304';
      final crc = emvSpec.crc16ccitt(payload);
      final crcHex = crc.toRadixString(16).toUpperCase().padLeft(4, '0');
      final validQr = '$payload$crcHex';

      expect(emvSpec.validateCRC(validQr), isTrue);
    });

    test('Validate CRC (Invalid Checksum)', () {
      const invalidQr = '0002016304FFFF';
      expect(emvSpec.validateCRC(invalidQr), isFalse);
    });

    test('Validate CRC (Missing/Wrong Tag)', () {
      // Ends with something else
      const invalidQr = '0002016204FFFF';
      expect(emvSpec.validateCRC(invalidQr), isFalse);
    });
  });
}