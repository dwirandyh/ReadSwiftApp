import 'package:flutter/material.dart';
import 'package:uikit/uikit.dart';

class SwitchMenuItem extends StatefulWidget {
  SwitchMenuItem({
    super.key,
    required this.menu,
    this.description,
    required this.onChanged,
    required this.isSelected,
  });

  final String menu;
  final String? description;
  final ValueChanged<bool>? onChanged;
  bool isSelected;

  @override
  State<SwitchMenuItem> createState() => _SwitchMenuItemState();
}

class _SwitchMenuItemState extends State<SwitchMenuItem> {
  @override
  Widget build(BuildContext context) {
    final color = context.theme.uikit;
    return InkWell(
      onTap: () {
        setState(() {
          widget.isSelected = !widget.isSelected;
        });
      },
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
                    widget.menu,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  if (widget.description != null) Text(widget.description ?? "")
                ],
              ),
            ),
            const SizedBox(width: 24),
            SizedBox(
              width: 40,
              height: 30,
              child: FittedBox(
                fit: BoxFit.fill,
                child: Switch(
                  value: widget.isSelected,
                  activeColor: color.accent,
                  onChanged: (value) {},
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
