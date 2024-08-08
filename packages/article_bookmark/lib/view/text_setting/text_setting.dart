import 'package:article_bookmark/view/text_setting/brightness_slider_widget.dart';
import 'package:article_bookmark/view/text_setting/font_size_adjustment.dart';
import 'package:article_bookmark/view/text_setting/font_type_adjustment_widget.dart';
import 'package:article_bookmark/view/text_setting/mode_selection_widget.dart';
import 'package:article_bookmark/view/text_setting/text_spacing_adjustment_widget.dart';
import 'package:article_bookmark/view/text_setting/width_adjustment_widget.dart';
import 'package:flutter/material.dart';

class TextSetting extends StatelessWidget {
  const TextSetting({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (bottomSheetContext) {
        return const TextSetting();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Wrap(
          runSpacing: 16,
          children: [
            ModeSelectionWidget(),
            BrightnessSliderWidget(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: FontSizeAdjustment()),
                const SizedBox(width: 8),
                const Expanded(child: FontTypeAdjustmentWidget()),
              ],
            ),
            Row(
              children: [
                Expanded(child: TextSpacingAdjustmentWidget()),
                const SizedBox(width: 8),
                Expanded(child: WidthAdjustmentWidget()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
