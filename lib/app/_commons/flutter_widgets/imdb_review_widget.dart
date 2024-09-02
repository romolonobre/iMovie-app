import 'package:flutter/material.dart';

import '../imovie_ui/iui_text.dart';

class ImdbReviewWidget extends StatelessWidget {
  final double review;
  const ImdbReviewWidget({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          "assets/images/imdb-icon.png",
          height: 12,
        ),
        const SizedBox(width: 5),
        IUIText.heading(
          "${review.toStringAsFixed(1)}/10",
          fontsize: 12,
          color: Colors.amber,
        ),
      ],
    );
  }
}
