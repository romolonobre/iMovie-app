import 'package:flutter/material.dart';
import 'package:imovie_ui/imovie_ui.dart';

Future IUIModal(
  BuildContext context, {
  required Widget child,
  Function? onConfirm,
  Function? onCancel,
  String? confirmText,
  String? cancelText,
  EdgeInsets? padding,
  Color? backgroundColor,
  Color? barrierColor,
  bool hideCancel = false,
  bool barrierDismissible = true,
  bool preventAutoPopOnConfirm = false,
  bool preventAutoPopOnCancel = false,
}) {
  return showGeneralDialog(
    barrierLabel: 'Modal',
    barrierDismissible: barrierDismissible,
    barrierColor: Colors.black.withOpacity(0.8),
    transitionDuration: const Duration(milliseconds: 200),
    context: context,
    pageBuilder: (context, anim1, anim2) {
      return Material(
        type: MaterialType.transparency,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width - 64,
              child: Container(
                decoration: BoxDecoration(
                    color: backgroundColor ?? Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromRGBO(100, 100, 100, 0),
                        blurRadius: 0,
                      ),
                    ]),
                padding: padding ?? const EdgeInsets.all(16),
                child: Column(
                  children: [
                    child,
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ///
                        /// Cancel button
                        ///
                        if (!hideCancel)
                          Flexible(
                            child: IUIButtons.text(
                              label: cancelText ?? "Cancel",
                              textColor: Colors.red,
                              onPressed: () {
                                if (onCancel != null) {
                                  onCancel();
                                }
                                if (!preventAutoPopOnCancel) Navigator.of(context).pop();
                              },
                            ),
                          ),

                        ///
                        /// Confirm button
                        ///
                        if (onConfirm != null)
                          Flexible(
                            child: IUIButtons.solid(
                              label: confirmText ?? "Confirm",
                              onPressed: () {
                                onConfirm();
                                if (!preventAutoPopOnConfirm) Navigator.of(context).pop();
                              },
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    },
    transitionBuilder: _buildNewTransition,
  );
}

Widget _buildNewTransition(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  return ScaleTransition(
    scale: CurvedAnimation(
      parent: animation,
      curve: Curves.decelerate,
      reverseCurve: Curves.easeIn,
    ),
    child: child,
  );
}
