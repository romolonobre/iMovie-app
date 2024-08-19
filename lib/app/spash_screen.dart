import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '_commons/app_services/utils.dart';
import '_commons/imovie_ui/iui_text.dart';
import '_commons/push_notifications/push_notifications.dart';
import '_commons/user_status/verify_user_status.dart';
import 'authentication/interactor/login_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final controller = Modular.get<LoginController>();

  @override
  void initState() {
    super.initState();
    VerifyUserStatus(controller: controller);
    Future(() => PushNotifications.initialize());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IUIText.title(
                  "FindIt",
                  color: primaryColor,
                  fontsize: 55,
                  fontWeight: FontWeight.w700,
                ).animate().animate().fade().scale(delay: 500.ms)
              ],
            ),
          )
        ],
      ),
    );
  }
}
