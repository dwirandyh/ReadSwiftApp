import 'package:flutter/widgets.dart';

class TagItem extends StatelessWidget {
  final String tag;
  const TagItem({super.key, required this.tag});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      child: Text(
        tag,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
