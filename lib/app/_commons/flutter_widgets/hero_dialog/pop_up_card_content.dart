import 'package:flutter/material.dart';
import 'package:imovie_ui/imovie_ui.dart';

import 'custom_rect_tween.dart';

class PopupCardContent extends StatelessWidget {
  final String id;
  final String cardTitle;

  final Widget child;

  const PopupCardContent({
    super.key,
    required this.id,
    required this.cardTitle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: id,
      createRectTween: (begin, end) {
        return CustomRectTween(begin: begin!, end: end!);
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Material(
          borderRadius: BorderRadius.circular(20),
          color: const Color(0xff242226),
          child: SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Card title

                    IUIText.heading(cardTitle),

                    const SizedBox(height: 20),

                    // Card content
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: child,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
