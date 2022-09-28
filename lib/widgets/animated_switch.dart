import 'package:flutter/material.dart';



class AnimatedSwitch extends StatelessWidget {
  final bool isToggled;
  final int index;
  final void Function() onTap;

  const AnimatedSwitch({
    Key? key,
    required this.isToggled,
    required this.index,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 38,
        width: 60,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(19),
            border: Border.all(
              width: 1,
              color: Theme.of(context).primaryColor,
            )),
        child: Stack(
          children: [
            AnimatedCrossFade(
              firstChild: Container(
                height: 38,
                width: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: Colors.transparent,
                ),
              ),
              secondChild: Container(
                height: 38,
                width: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: Theme.of(context).primaryColor,
                ),
              ),
              crossFadeState: isToggled
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: Duration(
                milliseconds: 200,
              ),
            ),
            AnimatedAlign(
              duration: Duration(
                milliseconds: 300,
              ),
              alignment: isToggled
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              child: Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 4,
                ),
                height: 42 * 0.5,
                width: 42 * 0.5,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
