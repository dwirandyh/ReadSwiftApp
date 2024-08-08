import 'package:flutter/material.dart';
import 'package:uikit/uikit.dart';

class ModeSelectionWidget extends StatefulWidget {
  @override
  _ModeSelectionWidgetState createState() => _ModeSelectionWidgetState();
}

class _ModeSelectionWidgetState extends State<ModeSelectionWidget> {
  int _selectedMode = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildModeButton(Icons.wb_sunny, 0),
              _buildModeButton(Icons.brightness_auto, 1),
              _buildModeButton(Icons.nights_stay, 2),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildModeButton(IconData icon, int index) {
    final color = context.theme.uikit;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedMode = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _selectedMode == index ? color.accent : Colors.grey[800],
          boxShadow: _selectedMode == index
              ? [BoxShadow(color: color.accent, blurRadius: 10)]
              : [],
        ),
        child: Icon(icon, color: Colors.white),
      ),
    );
  }
}
