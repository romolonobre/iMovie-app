import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:imovie_app/app/_commons/app_services/cache.dart';
import 'package:imovie_app/app/_commons/extensions/extensions.dart';

import '../../_commons/app_services/utils.dart';
import '../../_commons/flutter_widgets/imovie_textform_field.dart';
import '../../_commons/imovie_ui/iui_buttons.dart';
import '../../_commons/imovie_ui/iui_modal.dart';
import '../../_commons/imovie_ui/iui_text.dart';
import '../../_commons/user/entities/app_user.dart';
import '../../authentication/interactor/login_controller.dart';
import '../../authentication/interactor/login_state.dart';
import 'widgets/profile_image.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final controller = Modular.get<LoginController>();
  late AppUser? user;

  @override
  Widget build(BuildContext context) {
    user = controller.getUser();

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SizedBox(
        height: MediaQuery.sizeOf(context).height,
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 220,
                  decoration: const BoxDecoration(color: primaryColor),
                ),
                Positioned(
                  bottom: -60,
                  right: 0,
                  left: 0,
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      CircleAvatar(
                        radius: 73,
                        child: CircleAvatar(
                          radius: 70,
                          child: ProfileAvatar(controller),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 80),

            // TODO: ADD FEATURE DO EDIT
            // Read only User name
            ImovieTextformField(
              label: "Full name",
              initialValue: user?.name ?? '',
              isReadOnly: true,
            ).paddingOnly(left: 20, right: 20),

            const SizedBox(height: 15),

            // Read only Email
            ImovieTextformField(
              label: "Email",
              isReadOnly: true,
              initialValue: user?.email ?? '',
            ).paddingOnly(left: 20, right: 20),

            // Enable Biometric button
            SwitchListTile.adaptive(
              value: Cache().isBiometricsEnabled() ?? false,
              activeColor: Colors.green,
              title: IUIText.heading(
                "Use Biometrics for Security",
                color: primaryColor,
              ),
              subtitle: IUIText.heading(
                "Face ID or Fingerprint",
                color: Colors.grey.shade800,
                fontsize: 12,
              ),
              onChanged: (a) {
                Cache().setBiometrics(a);
                setState(() {});
              },
            ).paddingOnly(left: 10),

            const Spacer(),
            IUIButtons.text(
              width: MediaQuery.sizeOf(context).width - 200,
              label: "Logout",
              onPressed: () => confirmLogoutModal(),
            ).paddingOnly(bottom: 20)
          ],
        ),
      ),
    );
  }

  confirmLogoutModal() {
    IUIModal(navigatorKey.currentContext!,
        child: IUIText.heading(
          "Are you sure you want to logout?",
          color: Colors.black54,
          fontWeight: FontWeight.bold,
        ), onConfirm: () async {
      final state = await controller.signOut();
      if (state is SignOutState) {
        Modular.to.pushNamedAndRemoveUntil('/splashscreen', (p0) => true);
      }
    });
  }
}
