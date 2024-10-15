import 'package:app_services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:imovie_ui/imovie_ui.dart';

import '../../_commons/flutter_widgets/imovie_textform_field.dart';
import '../interactor/login_controller.dart';
import '../interactor/login_state.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final controller = Modular.get<LoginController>();
  bool isLoading = false;
  String? errorMessage;
  String email = '';
  String name = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: IUIPalette.backgroundColor,
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 150),
                IUIText.title(
                  "Sign up",
                  fontWeight: FontWeight.w500,
                  fontsize: 30,
                ),
                const SizedBox(height: 40),

                // Name input
                ImovieTextformField(
                  label: "Full name",
                  hintText: 'eg: Jhon smith',
                  onChanged: (value) {
                    setState(() => name = value);
                  },
                ),
                const SizedBox(height: 10),

                // Email input
                ImovieTextformField(
                  label: "Email",
                  hintText: "eg: jhon@gmail.com",
                  onChanged: (value) {
                    setState(() => email = value);
                  },
                ),
                const SizedBox(height: 10),

                // Password input
                ImovieTextformField(
                  label: "Password",
                  hintText: "Use a strong password",
                  isPasswordField: true,
                  onChanged: (value) {
                    setState(() => password = value);
                  },
                ),
                const SizedBox(height: 30),

                // Register button
                IUIButtons.solid(
                  label: isLoading ? "Processing..." : "Sign up",
                  height: 50,
                  onPressed: hasEmptyFields ? null : () async => onRegister(),
                ),

                if (errorMessage != null)
                  IUIText.heading(
                    errorMessage!,
                    color: Colors.red,
                  )
              ],
            ),
          ).paddingOnly(left: 20, right: 20),

          // Back button
          Positioned(
            top: 40,
            left: 10,
            child: IUIButtons.back(context),
          ),
        ],
      ),
    );
  }

  Future<void> onRegister() async {
    setState(() => isLoading = true);
    final state = await controller.register(usrname: email, password: password);

    if (state is AuthErrorState) {
      errorMessage = state.errorMessage;
      setState(() => isLoading = false);
      return;
    }
    await controller.updateUsername(name);
    setState(() => isLoading = false);
    Modular.to.pop();
  }

  bool get hasEmptyFields => email.isEmpty || name.isEmpty || password.isEmpty;
}
