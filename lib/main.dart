import 'dart:async';

import 'package:app_services/app_services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:imovie_app/app/app.dart';
import 'package:imovie_app/app/app_module.dart';
import 'package:imovie_app/firebase_options.dart';

void main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    Modular.setNavigatorKey(navigatorKey);
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    await CustomRemoteConfig().initialize();
    await CustomFirebaseCrashlitics().initialize();

    await Cache().init();

    runApp(
      ModularApp(
        module: AppModule(),
        child: const App(),
      ),
    );
  }, (error, stack) {
    Errorhandler.report(error, stack);
  });
}

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
