import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_home/widgets/animated_switch.dart';


class TumidBanner extends StatelessWidget {

  final double? horizontalPadding;
  final String? img;
  final String? title;
  final Widget? child;

  TumidBanner({
    required this.img,
    required this.title,
    required this.horizontalPadding,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.102,
      width: Get.width * 0.42,
      padding:
      EdgeInsets.symmetric(horizontal: horizontalPadding!, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border.all(
          color: Theme.of(context).primaryColor,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image(
            image: AssetImage(
              img!,
            ),
            height: 28,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Spacer(flex: 4),
              child!,
              Spacer(flex: 2),
              Padding(
                padding: const EdgeInsets.fromLTRB(6.0, 0.0, 0.0, 0.0),
                child: Text(title!),
              ),
              ],
              ),
              Spacer(flex: 4),
            ],
          ),
    );

  }
}

