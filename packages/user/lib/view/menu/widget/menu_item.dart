import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  const MenuItem({
    super.key,
    required this.menu,
    required this.onTap,
  });

  final String menu;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        width: double.infinity,
        child: Text(
          menu,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
