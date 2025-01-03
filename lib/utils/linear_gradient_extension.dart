import 'package:flutter/material.dart';

extension LinearGradientExtension on LinearGradient {
  LinearGradient copyWith({
    List<Color>? colors,
    List<double>? stops,
    TileMode? tileMode,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    GradientTransform? transform,
  }) {
    return LinearGradient(
      colors: colors ?? this.colors,
      begin: begin ?? this.begin,
      end: end ?? this.end,
      stops: stops ?? this.stops,
      tileMode: tileMode ?? this.tileMode,
      transform: transform ?? this.transform,
    );
  }
}
