import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'custom_rect_tween.dart';
import 'hero_dialog_route.dart';
import 'pop_up_card_content.dart';

class PopupCardTile extends StatefulWidget {
  final String id;
  final String cardTitle;
  final String cardSubtitle;
  final Widget visibleContent;
  final Function(String?)? callBack;
  final bool readOnly;
  final Widget child;
  const PopupCardTile({
    super.key,
    required this.id,
    required this.cardTitle,
    required this.cardSubtitle,
    required this.child,
    required this.visibleContent,
    this.callBack,
    this.readOnly = false,
  });

  @override
  State<PopupCardTile> createState() => _PopupCardTileState();
}

class _PopupCardTileState extends State<PopupCardTile> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Open card popup
      onTap: () async {
        if (widget.readOnly) return;
        final result = await Modular.to.push(
          HeroDialogRoute(
            builder: (context) => Center(
              child: PopupCardContent(
                id: widget.id,
                cardTitle: widget.cardTitle,
                child: widget.child,
              ),
            ),
          ),
        );
        setState(() {
          selectedValue = result;
        });
        if (widget.callBack != null) {
          widget.callBack!(result);
        }
      },
      // Visible content
      child: Hero(
        tag: widget.id,
        createRectTween: (begin, end) {
          return CustomRectTween(begin: begin!, end: end!);
        },
        child: widget.visibleContent,
      ),
    );
  }
}
