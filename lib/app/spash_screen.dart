import 'package:app_services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:imovie_ui/imovie_ui.dart';
import 'package:models/models.dart';

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
    VerifyUserStatus();
    Future(() => PushNotifications.initialize());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: IUIPalette.backgroundColor,
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IUIText.title(
                  "FindIt",
                  color: IUIPalette.primaryColor,
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
