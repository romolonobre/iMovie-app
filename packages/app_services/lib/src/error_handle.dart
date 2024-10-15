import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

class Errorhandler {
  static Future<void> report(dynamic exception, StackTrace stackTrace, {String? tag}) async {
    debugPrintStack(label: exception.toString(), stackTrace: stackTrace);
    await FirebaseCrashlytics.instance.log(exception.toString());
    await FirebaseCrashlytics.instance.recordError(exception, stackTrace, reason: 'a non-fatal error');
  }
}
