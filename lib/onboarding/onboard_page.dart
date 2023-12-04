import 'package:authentication/authentication.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:readswift_app/onboarding/onboard_slideshow.dart';
import 'package:readswift_app/onboarding/onboard_slideshow_item.dart';
import 'package:uikit/uikit.dart';

class OnboardPage extends StatelessWidget {
  const OnboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "ReadSwift",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 24),
              const SizedBox(
                width: double.infinity,
                height: 340,
                child: OnboardSlideshow(children: [
                  OnboardSlideshowItem(
                    title: "Save what really catches your attention.",
                    subtitle:
                        "Build up a curated selection of articles you love.\nExplore them anytime, across phones, tablets, or\nbrowsers.",
                    image: Image(
                      image: AssetImage("assets/illustration/onboard_1.png"),
                    ),
                  ),
                  OnboardSlideshowItem(
                      title: "Your peaceful place on the internet",
                      subtitle:
                          "Enjoy distraction-free reading with ReadSwift—articles are stored in a clean layout, free from interruptions and \npopups",
                      image: Image(
                          image: AssetImage(
                        "assets/illustration/onboard_2.png",
                      )))
                ]),
              ),
              const SizedBox(height: 32),
              UIKitButton(
                onPressed: () {
                  context.push(AuthenticationRouter.registerPage);
                },
                text: "Register Now",
                type: UIKitButtonType.elevated,
              ),
              const SizedBox(height: 8),
              UIKitButton(
                onPressed: () {
                  context.push(AuthenticationRouter.loginPage);
                },
                text: "Log In",
                type: UIKitButtonType.text,
              )
            ],
          ),
        ),
      ),
    );
  }
}
