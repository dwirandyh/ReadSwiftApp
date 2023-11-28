import 'package:flutter/material.dart';
import 'package:uikit/uikit.dart';

class OnboardSlideshow extends StatefulWidget {
  final List<Widget> children;

  const OnboardSlideshow({super.key, required this.children});

  @override
  State<OnboardSlideshow> createState() => _OnboardSlideshowState();
}

class _OnboardSlideshowState extends State<OnboardSlideshow> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.children.length,
            physics: const ClampingScrollPhysics(),
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return widget.children[index];
            },
          ),
        ),
        const SizedBox(height: 16),
        DotIndicator(
          itemCount: widget.children.length,
          currentPage: _currentPage,
        )
      ],
    );
  }
}

class DotIndicator extends StatelessWidget {
  final int itemCount;
  final int currentPage;
  const DotIndicator(
      {super.key, required this.itemCount, required this.currentPage});

  @override
  Widget build(BuildContext context) {
    final color = context.theme.uikit;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(itemCount, (index) {
        return Container(
          width: 8,
          height: 8,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: index == currentPage ? color.accent : color.softAccent,
          ),
        );
      }),
    );
  }
}
