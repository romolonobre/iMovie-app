import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imovie_app/app/_commons/app_services/cache.dart';
import 'package:imovie_app/app/_commons/app_services/error_handle.dart';
import 'package:imovie_app/app/app.dart';
import 'package:imovie_app/app/app_module.dart';
import 'package:imovie_app/firebase_options.dart';

import 'app/_commons/app_services/utils.dart';
import 'app/_commons/firebase_crashlitcs/custom_firebase_crashlitics.dart';
import 'app/_commons/remote_config/remote_config.dart';

void main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    Modular.setNavigatorKey(navigatorKey);
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    await CustomRemoteConfig().initialize();
    await CustomFirebaseCrashlitics().initialize();

    await Cache().init();

    runApp(
      ProviderScope(
        child: ModularApp(
          module: AppModule(),
          child: const App(),
        ),
      ),
    );
  }, (error, stack) {
    Errorhandler.report(error, stack);
  });
}
