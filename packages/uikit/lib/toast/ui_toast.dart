import 'package:flutter/material.dart';
import 'package:uikit/uikit.dart';

enum ToastType { info, error }

class UIToast extends StatefulWidget {
  final String message;
  final ToastType type;

  const UIToast({super.key, required this.message, required this.type});

  static void showToast(
      {required BuildContext context,
      required String message,
      ToastType type = ToastType.info}) {
    OverlayEntry overlay;
    overlay = OverlayEntry(
      builder: (context) => Positioned(
        top: 50,
        left: 16,
        child: UIToast(
          message: message,
          type: type,
        ),
      ),
    );

    Overlay.of(context).insert(overlay);

    Future.delayed(const Duration(seconds: 4), () {
      overlay.remove();
    });
  }

  @override
  UIToastState createState() => UIToastState();
}

class UIToastState extends State<UIToast> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, -2.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    ));

    // Start the animation
    _controller.forward();

    // Auto-close the toast after a delay
    Future.delayed(const Duration(seconds: 2), () {
      _controller.reverse();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: Material(
        color: Colors.transparent,
        child: SizedBox(
          width: MediaQuery.of(context).size.width - 32,
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: backgroundColor(widget.type),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Text(
              widget.message,
              style: const TextStyle(color: Colors.white, fontSize: 16.0),
            ),
          ),
        ),
      ),
    );
  }

  Color backgroundColor(ToastType type) {
    final color = context.theme.uikit;
    switch (type) {
      case ToastType.info:
        return color.accent;
      case ToastType.error:
        return color.danger;
    }
  }
}
