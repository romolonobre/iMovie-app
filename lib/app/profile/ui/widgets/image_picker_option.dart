import 'package:app_services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../_commons/imovie_ui/iui_text.dart';

class ImagePickerOption extends StatelessWidget {
  final ImageSource source;
  final IconData icon;
  final String label;
  final Future<void> Function(String) onImageSelected;

  const ImagePickerOption({
    super.key,
    required this.source,
    required this.icon,
    required this.label,
    required this.onImageSelected,
  });

  @override
  Widget build(BuildContext context) {
    final ImagePicker picker = ImagePicker();

    return GestureDetector(
      onTap: () async {
        final result = await picker.pickImage(source: source);
        if (result != null) {
          await onImageSelected(result.path);
        }
      },
      child: Column(
        children: [
          Container(
            height: 100,
            width: 100,
            color: primaryColor,
            child: Icon(
              icon,
              size: 50,
              color: Colors.white,
            ),
          ).borderRadius(8),
          IUIText.heading(label, color: primaryColor)
        ],
      ),
    );
  }
}
