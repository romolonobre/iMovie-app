import 'package:flutter/material.dart';
import 'package:imovie_ui/imovie_ui.dart';

class IUILoader extends StatelessWidget {
  final String? message;
  final double? size;
  final double strokeWidth;
  const IUILoader({
    super.key,
    this.message,
    this.size,
    this.strokeWidth = 4,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: size ?? 40,
            height: size ?? 40,
            child: CircularProgressIndicator(
              strokeWidth: strokeWidth,
              strokeCap: StrokeCap.round,
              valueColor: const AlwaysStoppedAnimation<Color>(primaryColor),
              backgroundColor: primaryColor.withOpacity(0.2),
            ),
          ),
          const SizedBox(height: 20),
          //
          // Optional message
          if (message != null)
            Text(
              message!,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
        ],
      ),
    );
  }
}
