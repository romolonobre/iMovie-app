import 'package:flutter_modular/flutter_modular.dart';
import 'package:imovie_app/app/_commons/app_services/env.dart';
import 'package:imovie_app/app/authentication/interactor/login_controller.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../app_services/cache.dart';

class PushNotifications {
  static Future<void> initialize() async {
    final controller = Modular.get<LoginController>();

    bool isLogged = controller.isLogged();
    OneSignal.Debug.setLogLevel(OSLogLevel.verbose);

    OneSignal.initialize(Env.oneSignalAPIKey);
    OneSignal.Notifications.requestPermission(true);

    // Send tags to create 2 different segments
    // The notificaion will be send based on the tags
    OneSignal.User.addTags({
      "logged_in": isLogged,
      "logged_out": !isLogged,
    });

    bool isBiometricsAuthEnabled = Cache().isBiometricsEnabled() ?? false;

    OneSignal.Notifications.addClickListener(
      (event) async {
        final data = event.notification.additionalData;
        String? value = data?["path"];

        if (value == null) {
          Modular.to.pushNamed("/home");
          return;
        }

        if (isBiometricsAuthEnabled) {
          // Navigate to biometric authentication with the desired path as an argument
          // after autheticate with the biometric we naviagte to the path from the notification
          await Modular.to.pushNamedAndRemoveUntil("/biometrics", (route) => false, arguments: value);
        } else {
          // Directly navigate to the desired path if biometric authentication is not enabled
          Modular.to.pushNamedAndRemoveUntil("/$value", (route) => false);
        }
      },
    );
  }
}
