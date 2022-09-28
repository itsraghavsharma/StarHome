import 'package:star_home/values/text_styles.dart';
import 'package:flutter/material.dart';

/// ===== Titles ======
/// Title1 - Used In - Main heading of homepage

class Title1 extends StatelessWidget {
  final String text;
  const Title1({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final totalHeight = MediaQuery.of(context).size.height;
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.only(bottom: totalHeight * 0.0),
        child: Text(
          text,
          style: headingStyle,
        ),
      ),
    );
  }
}
