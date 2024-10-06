import 'package:cryptonia/src/features/auth/screens/sign_in.dart';
import 'package:cryptonia/src/features/auth/screens/sign_up.dart';
import 'package:cryptonia/src/shared/theming/page_navigation.dart';
import 'package:cryptonia/src/shared/utils/app_constants.dart';
import 'package:cryptonia/src/shared/widgets/container_bg.dart';
import 'package:cryptonia/src/shared/widgets/custom_button.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final PageController _pageController = PageController(initialPage: 0);
  int index = 0;
  final List<Map> _onboardingText = [
    {
      "title": "Personalised Service",
      "image": "assets/images/onboarding/briefcase.png",
      "body": "Experience the gold standard of crypto trading."
    },
    {
      "title": "Best Market Rate",
      "image": "assets/images/onboarding/clipboard.png",
      "body": "Get the most out of every trade with our unbeatable rates."
    },
    {
      "title": "Safe Transactions",
      "image": "assets/images/onboarding/safe.png",
      "body": "Trade with confidence, knowing your funds are protected."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ContainerBg(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _onboardingText.length,
                onPageChanged: (position) => setState(() => index = position),
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Image.asset(_onboardingText[index]['image'],
                          width: 225, height: 225),
                      const SizedBox(height: 30),
                      Text(
                        _onboardingText[index]['title'],
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        _onboardingText[index]['body'],
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(height: 30),
                    ],
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: AppConstants.kScaffoldPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DotsIndicator(
                  dotsCount: _onboardingText.length,
                  position: index,
                  onTap: (position) async {
                    await _pageController.animateToPage(index,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.bounceIn);

                    setState(() {
                      index = position;
                    });
                  },
                  decorator: DotsDecorator(
                    size: const Size(10, 6),
                    activeSize: const Size(40, 9.0),
                    activeShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                ),
                const SizedBox(height: 80),
                CustomButton(
                  onPressed: () =>
                      PageNavigation.pushPage(context, const SignUp()),
                  text: 'Sign Up',
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account?'),
                    TextButton(
                      onPressed: () =>
                          PageNavigation.pushPage(context, const SignIn()),
                      child: const Text('Sign In'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
