import 'package:article_bookmark/bloc/text_setting/text_setting_bloc.dart';
import 'package:article_bookmark/view/text_setting/brightness_slider_widget.dart';
import 'package:article_bookmark/view/text_setting/font_size_adjustment.dart';
import 'package:article_bookmark/view/text_setting/font_type_adjustment_widget.dart';
import 'package:article_bookmark/view/text_setting/mode_selection_widget.dart';
import 'package:article_bookmark/view/text_setting/text_spacing_adjustment_widget.dart';
import 'package:article_bookmark/view/text_setting/width_adjustment_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:uikit/uikit.dart';

class TextSetting extends StatelessWidget {
  const TextSetting._({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (bottomSheetContext) {
        return TextSetting.create();
      },
    );
  }

  static Widget create() {
    return BlocProvider(
      create: (context) => TextSettingBloc(repository: GetIt.I.get()),
      child: const TextSetting._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TextSettingBloc, TextSettingState>(
      listener: (context, state) {
        ThemeProvider.of(context).updateTheme(state.theme);
      },
      builder: (context, state) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Wrap(
              runSpacing: 16,
              children: [
                ModeSelectionWidget(),
                BrightnessSliderWidget(),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: FontSizeAdjustment()),
                    SizedBox(width: 8),
                    Expanded(child: FontTypeAdjustmentWidget()),
                  ],
                ),
                const Row(
                  children: [
                    Expanded(child: TextSpacingAdjustmentWidget()),
                    SizedBox(width: 8),
                    Expanded(child: WidthAdjustmentWidget()),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
