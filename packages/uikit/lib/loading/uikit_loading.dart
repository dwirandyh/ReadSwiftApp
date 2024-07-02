import 'package:flutter/material.dart';

class UIKitLoading {
  static final UIKitLoading _instance = UIKitLoading._internal();
  factory UIKitLoading() => _instance;

  OverlayEntry? _overlayEntry;

  UIKitLoading._internal();

  OverlayEntry _createOverlayEntry() {
    return OverlayEntry(
      builder: (context) => Container(
        color: Color.fromRGBO(0, 0, 0, 0.5),
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  void show(BuildContext context) {
    if (_overlayEntry != null) return;

    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
  }

  void hide() {
    if (_overlayEntry == null) return;

    _overlayEntry!.remove();
    _overlayEntry = null;
  }
}
