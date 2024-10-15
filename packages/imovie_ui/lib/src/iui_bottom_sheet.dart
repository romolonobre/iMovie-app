import 'package:flutter/material.dart';
import 'package:imovie_ui/imovie_ui.dart';

class IUIBottomSheet {
  static Future show(
    BuildContext context, {
    required Widget content,
    Widget? trailing,
    bool enableDrag = true,
    bool isDismissible = true,
    bool floatted = false,
    bool fullHeight = false,
    bool hideHead = false,
    double borderRadius = 35,
    Color? barrierColor,
  }) async {
    return await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isDismissible: isDismissible,
      isScrollControlled: true,
      enableDrag: enableDrag,
      barrierColor: barrierColor ?? Colors.black87,
      builder: (BuildContext context) {
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            color: floatted ? Colors.transparent : Colors.white,
          ),
          margin: EdgeInsets.fromLTRB(
            floatted ? 10.0 : 0.0,
            0.0,
            floatted ? 10.0 : 0.0,
            floatted ? 24.0 : 0,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius),
            child: Container(
              width: double.infinity,
              color: floatted ? Colors.white : Colors.transparent,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!hideHead)
                    SizedBox(
                      height: 50,
                      child: Stack(
                        children: [
                          ///
                          /// SWIPE INDICATOR
                          ///
                          Align(
                            alignment: Alignment.topCenter,
                            child: _swipeIndicator,
                          ),

                          ///
                          /// TRAILING
                          ///
                          Positioned(
                            right: 20,
                            top: 4,
                            child: trailing ?? IUIButtons.close(context),
                          ),
                        ],
                      ),
                    ),

                  ///
                  /// CONTENT
                  ///
                  Container(
                    width: double.infinity,
                    padding: MediaQuery.of(context).viewInsets,
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.8,
                    ),
                    child: content,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

Container get _swipeIndicator => Container(
      height: 5.0,
      width: 80.0,
      margin: const EdgeInsets.only(
        top: 16.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.black26,
      ),
    );
