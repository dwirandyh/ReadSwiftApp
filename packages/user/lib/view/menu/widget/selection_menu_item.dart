import 'package:flutter/material.dart';

class SelectionMenuItem extends StatelessWidget {
  const SelectionMenuItem({
    super.key,
    required this.menu,
    required this.onTap,
    this.selectedItem,
  });

  final String menu;
  final VoidCallback onTap;
  final String? selectedItem;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        width: double.infinity,
        child: Row(
          children: [
            Text(
              menu,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Spacer(),
            if (selectedItem != null)
              Text(selectedItem!,
                  style: const TextStyle(fontWeight: FontWeight.w300)),
          ],
        ),
      ),
    );
  }
}
