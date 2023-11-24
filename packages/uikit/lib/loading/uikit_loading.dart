import 'package:flutter/material.dart';

class UILoading extends StatefulWidget {
  const UILoading({Key? key, required this.child, required this.isLoading})
      : super(key: key);

  final Widget child;
  final bool isLoading;

  @override
  State<UILoading> createState() => _UILoadingState();
}

class _UILoadingState extends State<UILoading> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        if (widget.isLoading)
          const Opacity(
            opacity: 0.2,
            child: ModalBarrier(dismissible: true, color: Colors.black),
          ),
        if (widget.isLoading)
          const Center(
            child: CircularProgressIndicator(),
          )
      ],
    );
  }
}
