import 'package:star_home/values/color.dart';
import 'package:star_home/values/text_styles.dart';
import 'package:flutter/material.dart';

MaterialButton appGreenButton(onClick, text) {
  return MaterialButton(
    color: AppColor.primary,
    onPressed: onClick,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
    child: Text(
      text,
      style: mediumBoldWhite,
    ),
  );
}
