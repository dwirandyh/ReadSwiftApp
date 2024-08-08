import 'package:flutter/material.dart';

class TextSpacingAdjustmentWidget extends StatefulWidget {
  const TextSpacingAdjustmentWidget({super.key});

  @override
  State<TextSpacingAdjustmentWidget> createState() =>
      _TextSpacingAdjustmentWidgetState();
}

class _TextSpacingAdjustmentWidgetState
    extends State<TextSpacingAdjustmentWidget> {
  double _lineHeight = 1.5;
  final Map<String, double> _lineHeightOptions = {
    'Small': 1.2,
    'Medium': 1.5,
    'Large': 1.8
  };
  final double _rotateDegree = 270 * 3.1415927 / 180;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Expanded(
          child: Text(
            "Spacing",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: DropdownButton<String>(
            icon: Transform.rotate(
              angle: _rotateDegree,
              child: const Icon(Icons.chevron_left),
            ),
            iconEnabledColor: Colors.white,
            isDense: true,
            underline: const SizedBox(),
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            isExpanded: true,
            padding: const EdgeInsets.only(top: 1),
            value: _lineHeightOptions.entries
                .firstWhere((entry) => entry.value == _lineHeight)
                .key,
            items: _lineHeightOptions.entries.map((entry) {
              return DropdownMenuItem<String>(
                value: entry.key,
                child: Text(entry.key), // Display "Small", "Medium", "Large"
              );
            }).toList(),
            onChanged: (String? newValue) {
              if (newValue != null) {
                setState(() {
                  _lineHeight = _lineHeightOptions[newValue]!;
                });
              }
            },
          ),
        ),
      ],
    );
  }
}
