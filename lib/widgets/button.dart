import 'package:star_home/values/color.dart';
import 'package:star_home/values/dimens.dart';
import 'package:star_home/values/text_styles.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final text;
  final onTap;
  const AppButton({Key? key, required this.text, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: MaterialButton(
        onPressed: onTap,
        child: Text(
          text,
          style: buttonStyle,
        ),
        color: AppColor.primary,
        height: 60,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimens.buttonRadius)),
      ),
    );
  }
}
