import 'package:logger/logger.dart';

class AppLogger {
  static void logTrack(String message) {
    Logger().t(" [LOG] : $message");
  }

  static void logError(String message) {
    Logger().e(" [ERROR] : $message");
  }

  static void logWarning(String message) {
    Logger().w(" [WARNING] : $message");
  }

  static void logInfo(String message) {
    Logger().i(" [INFO] : $message");
  }

  static void logDebug(String message) {
    Logger().d(" [DEBUG] : $message");
  }

  static void logFatal(String message) {
    Logger().f(" [FATAL] : $message");
  }
}
