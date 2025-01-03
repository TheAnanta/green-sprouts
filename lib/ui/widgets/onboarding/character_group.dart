import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stemquest/ui/responsiveness.dart';

class CharacterGroup extends StatelessWidget {
  const CharacterGroup({Key? key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getResponsiveWidth(318.96),
      height: getResponsiveHeight(391.94),
      child: Stack(
        children: [
          Positioned(
            bottom: getResponsiveHeight(66.15),
            left: 0,
            child: SvgPicture.asset('assets/images/characters/Deer.svg'),
          ),
          Positioned(
            bottom: getResponsiveHeight(163),
            left: getResponsiveWidth(102),
            child: SvgPicture.asset('assets/images/characters/Frog.svg'),
          ),
          Positioned(
            bottom: 0,
            left: getResponsiveWidth(55),
            child: SvgPicture.asset('assets/images/characters/Beaver.svg'),
          ),
          Positioned(
            bottom: getResponsiveHeight(233),
            left: getResponsiveWidth(53),
            child: SvgPicture.asset('assets/images/characters/Fox.svg'),
          ),
          Positioned(
            left: getResponsiveWidth(164),
            bottom: getResponsiveHeight(159),
            child: SvgPicture.asset('assets/images/characters/Rabbit.svg'),
          ),
        ],
      ),
    );
  }
}