import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:imovie_app/app/_commons/extensions/extensions.dart';
import 'package:lottie/lottie.dart';

import '../_commons/app_services/utils.dart';
import '../_commons/imovie_ui/iui_buttons.dart';
import '../_commons/imovie_ui/iui_snackbar.dart';
import '../_commons/imovie_ui/iui_text.dart';
import 'biometric_auth_state.dart';
import 'handle_biometric_auth.dart';

class BiometricAuthScreen extends StatefulWidget {
  final String? naviagtionPath;
  const BiometricAuthScreen({super.key, this.naviagtionPath});

  @override
  State<BiometricAuthScreen> createState() => _BiometricAuthScreenState();
}

class _BiometricAuthScreenState extends State<BiometricAuthScreen> {
  final _auth = HandleBiometricAuthetication();

  @override
  void initState() {
    super.initState();
    Future(() => _authenticateWithBiometrics());
  }

  _authenticateWithBiometrics() async {
    final state = await _auth.authenticateWithBiometrics();
    if (!mounted) return;
    if (state is BiometricsAuthErrorState) {
      IUISnackbar.show(
        context,
        message: state.errorMessage,
        isError: true,
      );
      return;
    }

    // If naviagtionPath is not null it means we are opening the app by tapping on push notification
    // so we will need the correct navigation path to navigate to the correct screen
    if (state is BiometricsAuthSucessState) {
      Modular.to.navigate('/${widget.naviagtionPath ?? 'home'}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 100),

            // Lottie animation
            LottieBuilder.asset(
              'assets/images/biometric.json',
              height: 200,
            ),
            const Spacer(),

            // Button to manually authenticate using Biometrics if automatic authentication fails
            IUIButtons.text(
              label: "Tap to Log in with Biometrics",
              width: MediaQuery.sizeOf(context).width - 100,
              onPressed: () async => await _authenticateWithBiometrics(),
            ),

            // Button to navigate to the login screen if there is an issue with Biometrics
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IUIText.heading("Or Sign in again", fontsize: 13),
                const SizedBox(width: 10),
                InkWell(
                  onTap: () async => Modular.to.navigate('/login'),
                  child: IUIText.heading(
                    "Sign in",
                    color: primaryColor,
                    fontsize: 15,
                  ),
                ),
              ],
            ).paddingOnly(bottom: 40)
          ],
        ),
      ),
    );
  }
}
