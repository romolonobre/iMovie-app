import 'package:app_services/app_services.dart';
import 'package:flutter/material.dart';

import '../../_commons/imovie_ui/iui_text.dart';

class PlatformLoginButton extends StatelessWidget {
  final String icon;
  final Function ontap;
  const PlatformLoginButton(this.icon, {required this.ontap, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => ontap(),
      child: Container(
          height: 60,
          width: MediaQuery.sizeOf(context).width,
          decoration: BoxDecoration(
            color: Colors.white12,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              Image.asset(
                icon,
              ).paddingAll(20),
              IUIText.heading("Use Google Account", color: Colors.white24, fontsize: 14)
            ],
          ).paddingOnly(left: 40)),
    );
  }
}
