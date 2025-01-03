import 'package:flutter/material.dart';

class OnboardingPageStateholder {
  final String primaryActionLabel;
  final List<Widget> children;
  final double backgroundHeight;
  const OnboardingPageStateholder({
    required this.primaryActionLabel,
    required this.children,
    this.backgroundHeight = 60,
  });
}
