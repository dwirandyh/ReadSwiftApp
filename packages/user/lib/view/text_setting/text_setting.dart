import 'package:flutter/material.dart';

class TextSetting extends StatelessWidget {
  const TextSetting({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (bottomSheetContext) {
        return TextSetting();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Setting"),
      ],
    );
  }
}
