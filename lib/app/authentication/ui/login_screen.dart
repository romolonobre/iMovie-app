import 'package:app_services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:imovie_app/app/authentication/ui/register_screen.dart';

import '../../_commons/flutter_widgets/imovie_textform_field.dart';
import '../../_commons/imovie_ui/iui_buttons.dart';
import '../../_commons/imovie_ui/iui_text.dart';
import '../interactor/login_controller.dart';
import '../interactor/login_state.dart';
import 'platform_login_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final controller = Modular.get<LoginController>();
  bool isLoading = false;
  String? errorMessage;
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            const SizedBox(height: 100),
            IUIText.title(
              "Sign in",
              fontWeight: FontWeight.w500,
              fontsize: 39,
            ),
            const SizedBox(height: 20),

            // Email input
            ImovieTextformField(
              label: "Email",
              hintText: "eg: jhon@gmail.com",
              onChanged: (value) => setState(() => email = value),
            ),
            const SizedBox(height: 15),

            // Password input
            ImovieTextformField(
              label: "Password",
              hintText: 'Type your password',
              isPasswordField: true,
              onChanged: (value) => setState(() => password = value),
            ),
            const SizedBox(height: 30),

            // Login button
            IUIButtons.solid(
              label: isLoading ? "Processing..." : "Sign in",
              height: 50,
              onPressed: password.isNotEmpty && email.isNotEmpty ? () async => onLogin() : null,
            ),

            // Error message
            if (errorMessage != null)
              IUIText.heading(
                errorMessage!,
                color: Colors.red,
              ),
            const SizedBox(height: 20),

            // Register button
            GestureDetector(
              onTap: () {
                Modular.to.push(MaterialPageRoute(builder: (context) => const RegisterScreen()));
              },
              child: Row(
                children: [
                  IUIText.heading("Dont have an account?", color: Colors.white24, fontsize: 14),
                  const SizedBox(width: 10),
                  SizedBox(
                      width: 100,
                      child: IUIText.heading(
                        "Sign up",
                        color: primaryColor,
                        fontWeight: FontWeight.w700,
                        fontsize: 14,
                      ))
                ],
              ),
            ),
            const SizedBox(height: 50),

            // Divider
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  width: 150,
                  child: Divider(
                    color: Colors.white24,
                    height: 1,
                  ),
                ),
                IUIText.heading(
                  "Or",
                  color: Colors.white24,
                  fontsize: 15,
                ),
                const SizedBox(
                  width: 150,
                  child: Divider(
                    color: Colors.white24,
                    height: 1,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 45),

            // GOOGLE Sign in button
            PlatformLoginButton(
              "assets/images/google.png",
              ontap: () async {
                final state = await controller.signInWithGoogle();
                if (state is AuthErrorState) {
                  errorMessage = state.errorMessage;
                  return;
                }
                if (state is LoginSuccessState) {
                  Modular.to.navigate('/home');
                }
              },
            ),
          ],
        ).paddingOnly(left: 20, right: 20),
      ),
    );
  }

  Future<void> onLogin() async {
    setState(() => isLoading = true);
    final state = await controller.login(email: email, password: password);
    if (state is AuthErrorState) {
      errorMessage = state.errorMessage;
      setState(() => isLoading = false);
      return;
    }
    if (state is LoginSuccessState) {
      setState(() => isLoading = false);
      Modular.to.navigate('/home');
    }
  }
}
