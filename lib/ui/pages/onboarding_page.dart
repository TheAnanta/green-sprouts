import 'package:flutter/material.dart';
import 'package:stemquest/constants/onboarding_stateholders.dart';
import 'package:stemquest/ui/responsiveness.dart';
import 'package:stemquest/ui/widgets/onboarding/onboarding_layout.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController(initialPage: 0);
    return LayoutBuilder(
      builder: (context, constraints) {
        Responsiveness.init(
          context,
          constraints.maxWidth,
          constraints.maxHeight,
        );
        return PageView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return OnboardingLayout(
              pageIndex: index + 1,
              children: onboardingStates[index].children,
              primaryActionLabel: onboardingStates[index].primaryActionLabel,
              backgroundHeight: onboardingStates[index].backgroundHeight,
              navigateToPreviousPage: () {
                if (index > 0) {
                  pageController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                  );
                } else {
                  Navigator.of(context).pop();
                }
              },
              navigateToNextPage: () {
                if (index < onboardingStates.length - 1) {
                  pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                  );
                } else {
                  Navigator.of(context).pushNamed("/login");
                }
              },
            );
          },
          itemCount: onboardingStates.length,
          controller: pageController,
        );
      },
    );
  }
}
