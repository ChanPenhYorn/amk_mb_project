/// Helper class for parsing and validating EMVCo/KHQR data.
class EmvSpec {
  static const String tagMerchantAccountInfo = '30';
  static const String tagMerchantCategoryCode = '52';
  static const String tagTransactionCurrency = '53';
  static const String tagCountryCode = '58';
  static const String tagMerchantName = '59';
  static const String tagMerchantCity = '60';
  static const String tagAdditionalData = '62';
  static const String tagCRC = '63';

  /// Parses a TLV (Tag-Length-Value) string into a Map.
  Map<String, String> parseSubTags(String value) {
    Map<String, String> subResult = {};
    int i = 0;
    while (i < value.length) {
      if (i + 4 > value.length) break;

      String subTag = value.substring(i, i + 2);
      i += 2;
      int subLength = int.tryParse(value.substring(i, i + 2)) ?? 0;
      i += 2;

      if (i + subLength > value.length) break;
      String subValue = value.substring(i, i + subLength);
      i += subLength;
      subResult[subTag] = subValue;
    }
    return subResult;
  }

  /// Calculates the CRC-16/CCITT-FALSE checksum (Polynomial 0x1021).
  int crc16ccitt(String data) {
    int crc = 0xFFFF;

    for (int i = 0; i < data.length; i++) {
      int ch = data.codeUnitAt(i);
      crc ^= (ch << 8);
      for (int j = 0; j < 8; j++) {
        if ((crc & 0x8000) != 0) {
          crc = (crc << 1) ^ 0x1021;
        } else {
          crc <<= 1;
        }
        crc &= 0xFFFF; // trim to 16-bit
      }
    }

    return crc;
  }

  /// Validates the CRC of a KHQR/EMVCo string.
  bool validateCRC(String qrString) {
    // Standard EMVCo/KHQR: CRC must be tag '63', length '04', and it must be the last element.
    // The CRC value itself is 4 characters. Total suffix for CRC is "6304XXXX" (8 chars).
    if (qrString.length < 8) return false;

    // Check if the string ends with Tag 63 and length 04 followed by 4 chars
    String tagLength = qrString.substring(
      qrString.length - 8,
      qrString.length - 4,
    );
    if (tagLength != '6304') {
      // If it doesn't end exactly with 6304, it might still have Tag 63 but it's not at the end (invalid per spec)
      return false;
    }

    String crcValue = qrString.substring(qrString.length - 4);
    String dataToCheck = qrString.substring(0, qrString.length - 4);

    int calculated = crc16ccitt(dataToCheck);
    String calculatedHex = calculated
        .toRadixString(16)
        .toUpperCase()
        .padLeft(4, '0');

    return calculatedHex == crcValue.toUpperCase();
  }
}
