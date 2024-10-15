import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:imovie_ui/imovie_ui.dart';

class SelectItem extends StatelessWidget {
  final String label;
  const SelectItem({
    Key? key,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width - 40,
      child: ListTile(
        title: IUIText.heading(label, fontWeight: FontWeight.w600, fontsize: 18),
        onTap: () {
          Modular.to.pop(label);
        },
      ),
    );
  }
}
