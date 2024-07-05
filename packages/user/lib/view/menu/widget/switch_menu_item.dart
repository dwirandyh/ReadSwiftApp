import 'package:flutter/material.dart';
import 'package:uikit/uikit.dart';

class SwitchMenuItem extends StatelessWidget {
  const SwitchMenuItem({
    super.key,
    required this.menu,
    this.description,
    required this.onChanged,
    required this.isSelected,
  });

  final String menu;
  final String? description;
  final ValueChanged<bool>? onChanged;
  final bool isSelected;

  void _toggle() {
    if (onChanged != null) {
      onChanged!(!isSelected);
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = context.theme.uikit;
    return InkWell(
      onTap: _toggle,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        width: double.infinity,
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    menu,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  if (description != null) Text(description ?? "")
                ],
              ),
            ),
            const SizedBox(width: 24),
            SizedBox(
              width: 40,
              height: 30,
              child: FittedBox(
                fit: BoxFit.fill,
                child: IgnorePointer(
                  child: Switch(
                    value: isSelected,
                    activeColor: color.accent,
                    onChanged: (value) {},
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
