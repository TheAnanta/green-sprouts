import 'package:flutter/material.dart';
import 'package:stemquest/ui/responsiveness.dart';
import 'package:stemquest/utils/linear_gradient_extension.dart';

class TokiElevatedButton extends StatefulWidget {
  final LinearGradient gradient;
  final LinearGradient shadowGradient;
  final String label;
  final Color labelColor;
  final double? labelSize;
  final Function() onPressed;
  final bool isVerticalGradient;
  final double width;
  const TokiElevatedButton({
    super.key,
    required this.gradient,
    required this.shadowGradient,
    this.width = 147,
    this.label = "Button",
    this.labelColor = Colors.white,
    this.labelSize,
    required this.onPressed,
    this.isVerticalGradient = false,
  });

  @override
  State<TokiElevatedButton> createState() => _TokiElevatedButtonState();
}

class _TokiElevatedButtonState extends State<TokiElevatedButton>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late CurvedAnimation _curvedAnimation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _curvedAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    )..addListener(() {
      setState(() {});
    });
    _animation = Tween<double>(begin: 6, end: 2).animate(_curvedAnimation);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _controller.forward();
        Future.delayed(const Duration(milliseconds: 150), () {
          _controller.reverse().then((value) {
            widget.onPressed();
          });
        });
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: getResponsiveWidth(widget.width),
            height: getResponsiveHeight(65),
            decoration: BoxDecoration(
              gradient: widget.shadowGradient,
              borderRadius: BorderRadius.circular(getResponsiveHeight(20)),
            ),
          ),
          Positioned(
            bottom: getResponsiveHeight(_animation.value),
            width: getResponsiveWidth(widget.width),
            height: getResponsiveHeight(65),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(getResponsiveHeight(20)),
                gradient:
                    widget.isVerticalGradient
                        ? widget.gradient.copyWith(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        )
                        : widget.gradient,
              ),
              child: Center(
                child: Text(
                  widget.label,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: widget.labelColor,
                    fontSize:
                        widget.labelSize != null
                            ? getResponsiveHeight(widget.labelSize!)
                            : widget.label.length > 8
                            ? getResponsiveHeight(12)
                            : getResponsiveHeight(24),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
