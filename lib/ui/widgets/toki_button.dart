import 'package:flutter/material.dart';
import 'package:stemquest/ui/responsiveness.dart';

class TokiButton extends StatelessWidget {
  final Function() onPressed;
  final Widget child;
  final Color? color;
  final LinearGradient? gradient;
  final bool isFullWidth;
  final AlignmentGeometry alignment;
  final BoxShadow? shadow;

  const TokiButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.color,
    this.gradient,
    this.isFullWidth = false,
    this.alignment = Alignment.centerRight,
    this.shadow,
  });

  @override
  Widget build(BuildContext context) {
    assert(color != null || gradient != null);
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: isFullWidth ? double.infinity : null,
        padding: EdgeInsets.symmetric(vertical: getResponsiveHeight(30)),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          gradient: gradient,
          boxShadow: shadow != null ? [shadow!] : [],
          borderRadius:
              !isFullWidth
                  ? BorderRadius.only(
                    topRight:
                        alignment == Alignment.centerLeft
                            ? Radius.circular(getResponsiveWidth(36))
                            : Radius.zero,
                    topLeft:
                        alignment == Alignment.centerRight
                            ? Radius.circular(getResponsiveWidth(36))
                            : Radius.zero,
                  )
                  : BorderRadius.zero,
        ),
        child: child,
      ),
    );
  }
}

class TokiTextButton extends StatelessWidget {
  final Function() onPressed;
  final String label;
  final Color? color;
  final LinearGradient? gradient;
  final bool isFullWidth;
  final Color labelColor;
  final AlignmentGeometry alignment;
  final BoxShadow? shadow;

  const TokiTextButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.color,
    this.gradient,
    this.isFullWidth = false,
    this.labelColor = Colors.white,
    this.alignment = Alignment.centerRight,
    this.shadow,
  });

  @override
  Widget build(BuildContext context) {
    return TokiButton(
      onPressed: onPressed,
      color: color,
      gradient: gradient,
      isFullWidth: isFullWidth,
      shadow: shadow,
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
          fontSize: getResponsiveHeight(18),
          fontWeight: FontWeight.bold,
          color: labelColor,
        ),
      ),
      alignment: alignment,
    );
  }
}

class TokiIconButton extends StatelessWidget {
  final Function() onPressed;
  final IconData icon;
  final Color iconColor;
  final Color? color;
  final LinearGradient? gradient;
  final bool isFullWidth;
  final AlignmentGeometry alignment;
  final BoxShadow? shadow;

  const TokiIconButton({
    super.key,
    required this.icon,
    this.iconColor = Colors.white,
    required this.onPressed,
    this.color,
    this.gradient,
    this.isFullWidth = false,
    this.alignment = Alignment.centerLeft,
    this.shadow,
  });

  @override
  Widget build(BuildContext context) {
    return TokiButton(
      onPressed: onPressed,
      color: color,
      gradient: gradient,
      isFullWidth: isFullWidth,
      child: Icon(icon, color: iconColor),
      alignment: alignment,
      shadow: shadow,
    );
  }
}
