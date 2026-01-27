import 'package:amk_bank_project/core/utils/app_logger.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'flavors.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  F.appFlavor = Flavor.values.firstWhere(
    (element) => element.name == appFlavor,
  );

  WidgetsFlutterBinding.ensureInitialized();
  FirebaseApp firebaseApp = await Firebase.initializeApp();
  await logAppInfo(firebaseApp);
  runApp(const ProviderScope(child: App()));

} 

//! use app logger


//! log app info
Future<void> logAppInfo(FirebaseApp firebaseApp) async {
  final info = await PackageInfo.fromPlatform();
  AppLogger.logInfo("🔥 App info:");
  AppLogger.logInfo("  - App Name: ${info.appName}");
  AppLogger.logInfo("  - Package Name / Bundle ID: ${info.packageName}");
  


  // AppLogger.logInfo("  - Version: ${info.version}");
  // AppLogger.logInfo("  - Build Number: ${info.buildNumber}");

  // AppLogger.logInfo("🔥 Firebase info:");
  // AppLogger.logInfo("  - App ID: ${firebaseApp.options.appId}");
  // AppLogger.logInfo("  - Project ID: ${firebaseApp.options.projectId}");
  // AppLogger.logInfo("  - API Key: ${firebaseApp.options.apiKey}");
  // AppLogger.logInfo(
  //   "  - Messaging Sender ID: ${firebaseApp.options.messagingSenderId}",
  // );
  
}
