import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

class DeviceInfo {
  static final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();

  static bool get isIOS => Platform.isIOS;
  static bool get isAndroid => Platform.isAndroid;
  static bool get isWindows => Platform.isWindows;
  static bool get isMacOS => Platform.isMacOS;
  static bool get isLinux => Platform.isLinux;

  static bool get isMobile => isIOS || isAndroid;
  static bool get isDesktop => isWindows || isMacOS || isLinux;

  static Future<bool> isIpad() async {
    try {
      if (Platform.isIOS) {
        IosDeviceInfo iosDeviceInfo = await _deviceInfoPlugin.iosInfo;
        return iosDeviceInfo.model.toLowerCase().contains("ipad");
      }
      return false;
    } catch (_) {
      return false;
    }
  }

  DeviceInfo._();
}
