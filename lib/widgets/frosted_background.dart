import 'dart:ui';

import 'package:star_home/values/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FrostedBackground extends StatelessWidget {
  final Widget child;
  const FrostedBackground({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final totalHeight = MediaQuery.of(context).size.height;
    final totalWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        SvgPicture.asset(
          "assets/ui/background.svg",
          color: AppColor.secondary,
        ),
        SizedBox(
          height: totalHeight,
          width: totalWidth,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 50, sigmaY: 30),
            child: SizedBox(
              height: totalHeight,
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: child,
        ),
      ],
    );
  }
}
