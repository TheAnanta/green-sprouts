import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:localization/localization.dart';
import 'package:stemquest/ui/responsiveness.dart';
import 'package:stemquest/ui/widgets/onboarding/character_group.dart';
import 'package:stemquest/ui/widgets/toki_elevated_button.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        Responsiveness.init(
          context,
          constraints.maxWidth,
          constraints.maxHeight,
        );
        return Scaffold(
          body: Stack(
            children: [
              //
              Image.asset(
                'assets/images/bg-sustainability.png',
                fit: BoxFit.cover,
                height: double.infinity,
                alignment: const Alignment(0.38, 0.5),
              ),

              SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SvgPicture.asset(
                          'assets/images/toki-green.svg',
                          width: getResponsiveWidth(220),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Sustainability Edition ✨".toUpperCase(),
                          style: Theme.of(
                            context,
                          ).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF61A400),
                          ),
                        ),
                      ],
                    ),
                    const CharacterGroup(),
                    SplashPageCTA(
                      onLogin: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      onStart: () {
                        Navigator.pushNamed(context, '/onboarding');
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class SplashPageCTA extends StatelessWidget {
  final Function() onLogin;
  final Function() onStart;

  const SplashPageCTA({
    super.key,
    required this.onLogin,
    required this.onStart,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TokiElevatedButton(
          onPressed: () {
            onLogin();
          },
          gradient: const LinearGradient(
            colors: [Color(0xFF00C1FF), Color(0xFF00B1FF)],
          ),
          shadowGradient: const LinearGradient(
            colors: [Color(0xFF08B1EF), Color(0xFF1E86F9)],
          ),
          label: 'login'.i18n(),
        ),
        TokiElevatedButton(
          onPressed: () {
            onStart();
          },
          isVerticalGradient: true,
          gradient: const LinearGradient(
            colors: [Color(0xFF65BB1C), Color(0xFF4EBE47)],
          ),
          shadowGradient: const LinearGradient(
            colors: [Color(0xFF55AA12), Color(0xFF37AB2A)],
          ),
          labelColor: const Color(0xFFFFFFFF),
          label: 'start'.i18n(),
        ),
      ],
    );
  }
}
