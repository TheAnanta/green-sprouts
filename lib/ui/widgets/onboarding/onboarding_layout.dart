import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as svg_provider;
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:localization/localization.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:stemquest/ui/responsiveness.dart';
import 'package:stemquest/ui/widgets/toki_button.dart';

class OnboardingLayout extends StatelessWidget {
  final int pageIndex;
  final String primaryActionLabel;
  final List<Widget> children;
  final Function() navigateToPreviousPage;
  final Function() navigateToNextPage;
  final double backgroundHeight;
  const OnboardingLayout({
    super.key,
    this.pageIndex = 1,
    this.primaryActionLabel = "\n",
    this.backgroundHeight = 60,
    this.children = const [Spacer()],
    required this.navigateToPreviousPage,
    required this.navigateToNextPage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              width: double.infinity,
              height: getResponsiveHeight(backgroundHeight + 80),
              color: Color(0xFFE5FFCD),
            ),
          ),
          Positioned(
            top: getResponsiveHeight(-27),
            width: getResponsiveWidth(86),
            height: getResponsiveHeight(125),
            right: getResponsiveWidth(-14),
            child: Text(
              pageIndex.toString(),
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color:
                    backgroundHeight > 600
                        ? Color(0xFFE2F0FF)
                        : const Color(0xFFEDF6FF),
                fontSize: getResponsiveHeight(120),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: getResponsiveHeight(56)),
                Text(
                  primaryActionLabel.i18n().split("\n")[0],
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFFB8CDA5),
                    fontSize: getResponsiveHeight(14),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  primaryActionLabel.i18n().split("\n")[1].toUpperCase(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFF61A400),
                    fontSize: getResponsiveHeight(20),
                    fontWeight: FontWeight.w500,
                    letterSpacing: getResponsiveWidth(-0.05),
                  ),
                ),
                ...children,
                Row(
                  children: [
                    ...(pageIndex == 1
                        ? []
                        : [
                          Expanded(
                            child: TokiIconButton(
                              isFullWidth: pageIndex == 1,
                              icon: Icons.chevron_left_rounded,
                              onPressed: navigateToPreviousPage,
                              color: Colors.white,
                              iconColor: const Color(0xFF97B0CF),
                              shadow: BoxShadow(
                                color: const Color(
                                  0xFF000000,
                                ).withValues(alpha: 0.05),
                                offset: Offset(0, getResponsiveHeight(4)),
                                blurRadius: getResponsiveHeight(8),
                                spreadRadius: getResponsiveWidth(3),
                              ),
                            ),
                          ),
                          SizedBox(width: getResponsiveWidth(24)),
                        ]),
                    Expanded(
                      flex: 3,
                      child: TokiTextButton(
                        isFullWidth: pageIndex == 1,
                        label: "Next".toUpperCase(),
                        onPressed: navigateToNextPage,
                        gradient: const LinearGradient(
                          colors: [Color(0xFF8EE048), Color(0xFF64CC5D)],
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
  }
}

class SelectionCarousel extends StatelessWidget {
  final Widget Function(BuildContext, int) itemBuilder;
  final int index;
  final int itemCount;
  final Function(int) onItemSelected;
  final double height;
  final double viewportFraction;
  final bool shouldDrawBorder;
  final Clip clip;

  const SelectionCarousel({
    super.key,
    required this.index,
    required this.itemCount,
    required this.itemBuilder,
    required this.onItemSelected,
    this.height = 109,
    this.viewportFraction = 0.3,
    this.shouldDrawBorder = false,
    this.clip = Clip.antiAlias,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.none,
      height: getResponsiveHeight(height * 1.2),
      child: Swiper(
        itemCount: itemCount,
        itemBuilder: (context, index) {
          return Container(
            clipBehavior: Clip.none,
            padding: EdgeInsets.only(
              bottom: getResponsiveHeight(21),
              top: getResponsiveHeight(height) * 0.2,
            ),
            child: SelectionItemWidget(
              selected: index == this.index,
              size: height - 21,
              child: itemBuilder(context, index),
              clip: clip,
              shouldDrawBorder: shouldDrawBorder,
            ),
          );
        },
        onIndexChanged: onItemSelected,
        index: index,
        scrollDirection: Axis.horizontal,
        viewportFraction: viewportFraction,
        scale: 0.2,
      ),
    );
  }
}

class SelectionItemWidget extends StatelessWidget {
  final Clip clip;
  final Widget child;
  final bool selected;
  final double size;
  final bool shouldDrawBorder;
  const SelectionItemWidget({
    super.key,
    this.clip = Clip.antiAlias,
    required this.child,
    required this.selected,
    this.size = 80,
    this.shouldDrawBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    print("123");
    return Stack(
      clipBehavior: Clip.none,
      children: [
        FutureBuilder(
          future: calculatePallete(),
          builder: (context, future) {
            return Container(
              decoration: BoxDecoration(
                boxShadow:
                    shouldDrawBorder
                        ? [
                          selected
                              ? BoxShadow(
                                color: const Color(
                                  0xFF000000,
                                ).withValues(alpha: 0.08),
                                offset: Offset(0, getResponsiveHeight(6)),
                                blurRadius: getResponsiveHeight(8),
                                spreadRadius: getResponsiveWidth(3),
                              )
                              : BoxShadow(
                                color: const Color(
                                  0xFF000000,
                                ).withValues(alpha: 0.05),
                                offset: Offset(0, getResponsiveHeight(4)),
                                blurRadius: 2,
                              ),
                        ]
                        : [],
                color:
                    shouldDrawBorder
                        ? future.data ?? Colors.transparent
                        : Colors.transparent,
                shape: BoxShape.circle,
                border:
                    shouldDrawBorder
                        ? Border.all(
                          width: getResponsiveHeight((4 * size) / 80),
                          color: Colors.white,
                        )
                        : null,
              ),
              height: getResponsiveHeight(size * 1.2),
              width: getResponsiveHeight(size),
              child: ClipOval(clipBehavior: clip, child: child),
            );
          },
        ),
        selected && isSmallScreen()
            ? Positioned(
              top: 0,
              right: getResponsiveHeight(28),
              child: Container(
                width: getResponsiveHeight((36 * size) / 80),
                height: getResponsiveHeight((36 * size) / 80),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check_outlined,
                  color: const Color(0xFF83E647),
                  size: getResponsiveHeight(24),
                  weight: 700,
                ),
              ),
            )
            : SizedBox(),
      ],
    );
  }

  Future<Color?> calculatePallete() async {
    if (((child as Container).child as Transform).child is SvgPicture) {
      final pallete = await PaletteGenerator.fromImageProvider(
        svg_provider.Svg(
          ((((child as Container).child as Transform).child as SvgPicture)
                      .bytesLoader
                  as SvgAssetLoader)
              .assetName,
        ),
        size: Size(size, size),
        maximumColorCount: 20,
      );
      return pallete.colors.toList()[2];
    }
    return null;
  }
}
