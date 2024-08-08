import 'package:flutter/material.dart';
import 'package:uikit/uikit.dart';

class BrightnessSliderWidget extends StatefulWidget {
  @override
  _BrightnessSliderWidgetState createState() => _BrightnessSliderWidgetState();
}

class _BrightnessSliderWidgetState extends State<BrightnessSliderWidget> {
  double _brightness = 0.5;

  @override
  Widget build(BuildContext context) {
    final color = context.theme.uikit;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.brightness_low, color: Colors.grey),
            Expanded(
              child: Slider(
                value: _brightness,
                onChanged: (newBrightness) {
                  setState(() {
                    _brightness = newBrightness;
                  });
                },
                activeColor: color.accent,
                inactiveColor: Colors.grey[600],
              ),
            ),
            const Icon(Icons.brightness_high, color: Colors.grey),
          ],
        ),
      ],
    );
  }
}
