import 'package:app_services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:imovie_app/app/_commons/imovie_ui/iui_text.dart';

class ImovieTextformField extends StatefulWidget {
  final String? hintText;
  final bool capitalizeFirstWord;
  final Function(String)? onChanged;
  final TextInputType keyboardType;
  final bool isPasswordField;
  final String? initialValue;
  final bool isReadOnly;
  final String label;

  const ImovieTextformField({
    super.key,
    this.hintText,
    required this.label,
    this.capitalizeFirstWord = false,
    this.onChanged,
    this.keyboardType = TextInputType.text,
    this.isPasswordField = false,
    this.initialValue,
    this.isReadOnly = false,
  });

  @override
  State<ImovieTextformField> createState() => _ImovieTextformFieldState();
}

class _ImovieTextformFieldState extends State<ImovieTextformField> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IUIText.heading(
          widget.label,
          fontsize: 14,
          color: const Color(0xff444242),
        ),
        const SizedBox(height: 5),
        TextFormField(
          initialValue: widget.initialValue,
          keyboardType: widget.keyboardType,
          obscureText: widget.isPasswordField ? _obscureText : false,
          readOnly: widget.isReadOnly,
          textCapitalization: widget.capitalizeFirstWord ? TextCapitalization.words : TextCapitalization.none,
          onChanged: widget.onChanged,
          style: TextStyle(color: widget.isReadOnly ? Colors.white24 : Colors.white),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            hintText: widget.hintText,
            filled: true,
            fillColor: Colors.white12,
            suffixIcon: suffixIcon(),
            hintStyle: const TextStyle(
              color: Colors.white30,
              fontSize: 14,
            ),
            border: InputBorder.none,
          ),
        ).borderRadius(10)
      ],
    );
  }

  Widget? suffixIcon() {
    if (widget.isPasswordField) {
      return IconButton(
        icon: Icon(
          _obscureText ? Icons.visibility : Icons.visibility_off,
          color: Colors.white12,
        ),
        onPressed: () => setState(() => _obscureText = !_obscureText),
      );
    }
    if (widget.isReadOnly) {
      return const Icon(Icons.lock);
    }
    return null;
  }
}
