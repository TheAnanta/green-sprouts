import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:localization/localization.dart';
import 'package:stemquest/firebase_options.dart';
import 'package:stemquest/ui/pages/home_page.dart';
import 'package:stemquest/ui/pages/onboarding_page.dart';
import 'package:stemquest/ui/pages/splash_page.dart';
import 'package:stemquest/ui/responsiveness.dart';
import 'package:stemquest/ui/widgets/toki_button.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    LocalJsonLocalization.delegate.directories = ['lib/i18n'];
    return MaterialApp(
      supportedLocales: [
        Locale('en', 'US'),
        Locale('hi', 'IN'),
        Locale("te", "IN"),
        Locale("kn", "IN"),
        Locale("ta", "IN"),
        Locale("sa", "IN"),
        Locale("ml", "IN"),
      ],
      localizationsDelegates: [
        // delegate from localization package.
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        //json-file
        LocalJsonLocalization.delegate,
      ],
      // locale: Locale("kn", "IN"),
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        fontFamily: 'GothamSSm',
      ),
      initialRoute: '/onboarding',
      routes: {
        '/': (context) => const SplashPage(),
        "/onboarding": (context) => const OnboardingPage(),
        "/login": (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
      },
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  width: double.infinity,
                  height: getResponsiveHeight(696),
                  color: Color(0x20FFF9BF),
                ),
              ),
              Positioned(
                child: SvgPicture.asset("assets/images/characters/sloth.svg"),
                top: getResponsiveHeight(-40),
                left: getResponsiveWidth(-40),
                width: getResponsiveWidth(450),
              ),
              SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: getResponsiveHeight(391)),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Text(
                              "login".i18n(),
                              textAlign: TextAlign.center,
                              style: Theme.of(
                                context,
                              ).textTheme.bodyMedium?.copyWith(
                                color: const Color(0xFFDC9346),
                                fontSize: getResponsiveHeight(24),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "username-password-continue".i18n(),
                              textAlign: TextAlign.center,
                            ),
                            Spacer(),
                            TextField(
                              decoration: InputDecoration(
                                fillColor: Color(0xFF20A2C1C4),
                                filled: true,
                                hintText: "Username",
                              ),
                            ),
                            SizedBox(height: getResponsiveHeight(24)),
                            TextField(
                              decoration: InputDecoration(
                                fillColor: Color(0xFF20A2C1C4),
                                filled: true,
                                hintText: "Password",
                              ),
                            ),
                            Spacer(),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TokiIconButton(
                            icon: Icons.chevron_left_rounded,
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            color: Colors.white,
                            iconColor: const Color(0xFF97B0CF),
                            shadow: BoxShadow(
                              color: const Color(0xFF000000).withOpacity(0.05),
                              offset: Offset(0, getResponsiveHeight(4)),
                              blurRadius: getResponsiveHeight(8),
                              spreadRadius: getResponsiveWidth(3),
                            ),
                          ),
                        ),
                        SizedBox(width: getResponsiveWidth(24)),
                        Expanded(
                          flex: 3,
                          child: TokiTextButton(
                            label: "Next",
                            onPressed: () {
                              Navigator.of(context).pushNamed("/home");
                            },
                            gradient: const LinearGradient(
                              colors: [Color(0xFFFFDF33), Color(0xFFFFBE2E)],
                            ),
                          ),
                        ),
                      ],
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
