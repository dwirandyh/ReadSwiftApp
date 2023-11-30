import 'package:flutter/widgets.dart';
import 'package:uikit/uikit.dart';

class OnboardSlideshowItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final Image image;

  const OnboardSlideshowItem(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.image});

  @override
  Widget build(BuildContext context) {
    final color = context.theme.uikit;
    return Column(
      children: [
        SizedBox(
          width: 200,
          height: 200,
          child: image,
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            color: color.title,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 14,
            color: color.caption,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
