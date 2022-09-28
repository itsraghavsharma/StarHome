import 'package:star_home/values/color.dart';
import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {
  final onTap;
  final icon;
  const SocialButton({Key? key, required this.onTap, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 70,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.brown, width: 3)),
      child: MaterialButton(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Icon(
            icon,
            size: 35,
            color: AppColor.primary,
          ),
          onPressed: onTap),
    );
  }
}
