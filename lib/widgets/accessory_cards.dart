import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_home/widgets/animated_switch.dart';

import 'package:firebase_database/firebase_database.dart';

class SmartSystem extends StatelessWidget {

  final Color color;
  final int index;
  final String title;
  final String imageUrl;
  final VoidCallback onTap;
  final bool isToggle;
  final VoidCallback onToggleTap;

  SmartSystem({
    Key? key,
    required this.color,
    required this.index,
    required this.title,
    required this.imageUrl,
    required this.onTap,
    required this.isToggle,
    required this.onToggleTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: Get.width * 0.414,
        width: Get.width * 0.4,
        margin: EdgeInsets.only(bottom: 10),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: Get.width * 0.06,
                width: Get.width * 0.34,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: color.withOpacity(0.45)),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: Get.width * 0.4,
                width: Get.width * 0.4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: color,
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      top: 15,
                      left: Get.width * 0.032,
                      child: Image(
                        image: AssetImage(imageUrl),
                        fit: BoxFit.fill,
                        height: Get.width * 0.16,
                      ),
                    ),
                    Positioned(
                      top: 20,
                      right: 15,
                      child: AnimatedSwitch(
                        isToggled: isToggle,
                        index: index,
                        onTap: onToggleTap,
                      ),
                    ),
                    Positioned(
                      bottom: 25,
                      left: 18,
                      child: Text(
                        title,
                        ),
                      ),

                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
