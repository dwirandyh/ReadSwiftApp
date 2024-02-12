import 'package:flutter/widgets.dart';
import 'package:foundation/device_info/device_info.dart';
import 'package:share_plus/share_plus.dart';

class ShareUtil {
  static Future<void> shareText(BuildContext context, String sharedText) async {
    bool isIpad = await DeviceInfo.isIpad();
    if (isIpad && context.mounted) {
      final box = context.findRenderObject() as RenderBox?;
      if (box != null) {
        await Share.share(sharedText,
            sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
      }
    } else {
      await Share.share(sharedText);
    }
  }
}
