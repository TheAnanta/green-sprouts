import 'package:bubbles_selection/bubbles_selection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:localization/localization.dart';
import 'package:stemquest/data/models/onboarding_page_stateholder.dart';
import 'package:stemquest/ui/responsiveness.dart';
import 'package:stemquest/ui/widgets/onboarding/onboarding_layout.dart';
import 'package:stemquest/ui/widgets/toki_elevated_button.dart';

List<OnboardingPageStateholder> onboardingStates = [
  OnboardingPageStateholder(
    primaryActionLabel: "choose-your-character",
    children: [
      Builder(
        builder: (context) {
          var characters = [
            "Beaver-straight",
            "Deer",
            "Fox",
            "sloth-straight",
            "Rabbit_straight",
          ];
          var circles = [
            "beaver-circled",
            "deer-circled",
            "Fox",
            "sloth-straight",
            "rabbit-circled",
          ];
          int character = 0;
          var pageController = PageController(initialPage: character);
          return StatefulBuilder(
            builder: (context, setCharacterState) {
              return Expanded(
                child: Column(
                  children: [
                    SizedBox(height: getResponsiveHeight(48)),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(48.0),
                        child: PageView.builder(
                          controller: pageController,
                          itemBuilder: (context, index) {
                            return SvgPicture.asset(
                              "assets/images/characters/${characters[index]}.svg",
                            );
                          },
                          itemCount: 5,
                        ),
                      ),
                    ),
                    SizedBox(height: getResponsiveHeight(48)),
                    SelectionCarousel(
                      clip: Clip.none,
                      index: character,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Container(
                          clipBehavior: Clip.none,
                          child: Transform.scale(
                            scale: 1,
                            child: SvgPicture.asset(
                              clipBehavior: Clip.none,
                              "assets/images/characters/${circles[index]}.svg",
                            ),
                          ),
                        );
                      },

                      onItemSelected: (index) {
                        setCharacterState(() {
                          character = index;
                          pageController.animateToPage(
                            character,
                            curve: Curves.easeInOut,
                            duration: Duration(milliseconds: 500),
                          );
                          print(index);
                        });
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    ],
    backgroundHeight: 64,
  ),
  OnboardingPageStateholder(
    primaryActionLabel: "choose-your-native-language",
    children: [
      SizedBox(height: getResponsiveHeight(36)),
      Builder(
        builder: (context) {
          int character = 3;
          var languages = [
            "Hindi",
            "Sanskrit",
            "Telugu",
            "English",
            "Kannada",
            "Malayalam",
          ];
          return StatefulBuilder(
            builder: (context, setCharacterState) {
              return SelectionCarousel(
                shouldDrawBorder: true,
                index: character,
                itemCount: 6,
                itemBuilder: (context, index) {
                  return Container(
                    color: Color(0xFF85DB4C),
                    child: Center(
                      child: Text(
                        languages[index],
                        style: Theme.of(
                          context,
                        ).textTheme.titleMedium?.copyWith(color: Colors.white),
                      ),
                    ),
                  );
                },
                onItemSelected: (index) {
                  setCharacterState(() {
                    character = index;
                    print(index);
                  });
                },
                height: 141,
                viewportFraction: 0.35,
              );
            },
          );
        },
      ),
      SizedBox(height: getResponsiveHeight(42)),
      Builder(
        builder: (context) {
          return Text(
            "choose-your-motivation".i18n().split("\n")[0],
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: const Color(0xFFB8CDA5),
              fontSize: getResponsiveHeight(14),
              fontWeight: FontWeight.w500,
            ),
          );
        },
      ),
      Builder(
        builder: (context) {
          return Text(
            "choose-your-motivation".i18n().split("\n")[1].toUpperCase(),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: const Color(0xFF61A400),
              fontSize: getResponsiveHeight(20),
              fontWeight: FontWeight.w500,
              letterSpacing: getResponsiveWidth(-0.05),
            ),
          );
        },
      ),
      Expanded(
        child: BubbleSelection(
          onSelect: (_) {},
          onRemoved: (_) {},
          size: Size(900, 300),
          bubbles:
              ["Love", "Cricket", "Stuffed"].map((e) {
                return Bubble(text: e);
              }).toList(),
          selectedBubbles: [],
        ),
      ),
      SizedBox(height: 48),
      // Expanded(
      //   child: Image.asset(
      //     "assets/images/motivation.png",
      //     fit: BoxFit.cover,
      //     width: double.infinity,
      //   ),
      // ),
    ],
    backgroundHeight: 563,
  ),
  OnboardingPageStateholder(
    primaryActionLabel: "choose-your-academic-level",
    children: [
      SizedBox(height: getResponsiveHeight(16)),
      Builder(
        builder: (context) {
          return Text(
            "if-dont-know-your-level".i18n(),
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontSize: getResponsiveHeight(16),
              color: const Color(0xFF5E5E5E),
              fontWeight: FontWeight.w400,
              letterSpacing: getResponsiveWidth(0.05),
            ),
          );
        },
      ),
      SizedBox(height: getResponsiveHeight(25)),
      TokiElevatedButton(
        gradient: const LinearGradient(
          colors: [Color(0xFF8EE048), Color(0xFF64CC5D)],
        ),
        shadowGradient: const LinearGradient(
          colors: [Color(0xFF7CCB38), Color(0xFF50C243)],
        ),
        onPressed: () {},
        label: "Begin the test".toUpperCase(),
        // width: 300,
        // labelSize: 20,
      ),
      SizedBox(height: getResponsiveHeight(64)),
      Flexible(
        child: PageView.builder(
          itemBuilder: (context, index) {
            return index <= 1
                ? SvgPicture.asset(
                  "assets/icons/${index == 0 ? "beginner" : "sophomore"}.svg",
                )
                : Image.asset(
                  "assets/images/${index == 2 ? "junior" : "senior"}.png",
                );
          },
          itemCount: 4,
        ),
      ),
      SizedBox(height: getResponsiveHeight(64)),
    ],
    backgroundHeight: 563,
  ),
  OnboardingPageStateholder(
    primaryActionLabel: "choose-your-goal",
    children: [
      Expanded(
        child: Builder(
          builder: (context) {
            return Column(
              children: [
                Container(
                  width: getResponsiveWidth(344),
                  height: getResponsiveHeight(86),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF1CCBFA), Color(0xFF519FFA)],
                    ),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Center(
                    child: Text(
                      "Simple",
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Colors.white,
                        fontSize:
                            "Simple".length > 8
                                ? getResponsiveHeight(12)
                                : getResponsiveHeight(24),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12),
                Container(
                  width: getResponsiveWidth(344),
                  height: getResponsiveHeight(86),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFF1CCBFA), width: 2),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Center(
                    child: Text(
                      "Normal",
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontSize:
                            "Normal".length > 8
                                ? getResponsiveHeight(12)
                                : getResponsiveHeight(24),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12),
                Container(
                  width: getResponsiveWidth(344),
                  height: getResponsiveHeight(86),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFF1CCBFA), width: 2),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Center(
                    child: Text(
                      "Intensive",
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontSize:
                            "Intensive".length > 8
                                ? getResponsiveHeight(12)
                                : getResponsiveHeight(24),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    ],
    backgroundHeight: 764,
  ),
];
