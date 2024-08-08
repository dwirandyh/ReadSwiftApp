import 'package:flutter/material.dart';

class FontSizeAdjustment extends StatefulWidget {
  const FontSizeAdjustment({super.key});

  @override
  _FontSizeAdjustmentState createState() => _FontSizeAdjustmentState();
}

class _FontSizeAdjustmentState extends State<FontSizeAdjustment> {
  double _fontSize = 16;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: const Text(
            "Font",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.remove, color: Colors.white),
          onPressed: () {
            setState(() {
              _fontSize = (_fontSize - 1).clamp(12.0, 30.0);
            });
          },
        ),
        Text(
          'A',
          style: TextStyle(
              fontSize: _fontSize,
              color: Colors.white,
              fontWeight: FontWeight.bold),
        ),
        IconButton(
          icon: const Icon(Icons.add, color: Colors.white),
          onPressed: () {
            setState(() {
              _fontSize = (_fontSize + 1).clamp(12.0, 30.0);
            });
          },
        ),
      ],
    );
  }
}
