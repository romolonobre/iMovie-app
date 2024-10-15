import 'package:app_services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:imovie_ui/imovie_ui.dart';

class IUIButtons {
  static Widget icon({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    Color? backgroundColor,
    Color? textColor,
    double? width,
    double? height,
  }) {
    return SizedBox(
      width: width ?? MediaQuery.sizeOf(Utils.navigatorKey.currentState!.context).width,
      height: height ?? 40,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          foregroundColor: textColor,
          backgroundColor: backgroundColor,
          textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7),
          ),
        ),
        onPressed: onPressed,
        icon: Icon(icon),
        label: Text(label),
      ),
    );
  }

  static Widget text({
    required String label,
    required VoidCallback onPressed,
    Color? textColor,
    double? width,
    Color? backgroundColor,
    Color? borderColor,
  }) {
    return SizedBox(
      width: width ?? 130,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: backgroundColor,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: borderColor ?? Colors.transparent),
          ),
        ),
        onPressed: onPressed,
        child: IUIText.heading(label, color: textColor ?? IUIPalette.primaryColor, fontWeight: FontWeight.w600),
      ),
    );
  }

  static Widget solid({
    required String label,
    required Function? onPressed,
    Color? backgroundColor,
    Color? textColor,
    double? width,
    double? height,
  }) {
    return SizedBox(
      width: width ?? MediaQuery.sizeOf(Utils.navigatorKey.currentState!.context).width,
      height: height ?? 40,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: onPressed != null ? backgroundColor ?? IUIPalette.primaryColor : Colors.white24,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () => onPressed != null ? onPressed() : null,
        child: IUIText.heading(
          label,
          color: textColor ?? Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  static Widget back(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).pop(),
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.only(top: 4),
        width: 80,
        height: 40,
        child: Stack(
          children: [
            const Icon(Icons.chevron_left_rounded, color: Colors.white, size: 30),
            Positioned(
              top: 5,
              left: 25,
              child: IUIText.heading(
                'back',
                color: Colors.white,
                fontsize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget close(
    BuildContext context, {
    Function? onTap,
    Color? color,
  }) {
    return InkWell(
      onTap: () => onTap != null ? onTap() : Navigator.of(context).pop(),
      child: Container(
        height: 50,
        color: Colors.transparent,
        child: Row(
          children: [
            Icon(
              Icons.close,
              size: 15,
              color: Colors.grey.shade600,
            ).paddingOnly(top: 2),
            const SizedBox(width: 2),
            IUIText.heading('close', color: color ?? Colors.grey.shade600, fontsize: 14),
          ],
        ),
      ),
    );
  }
}
