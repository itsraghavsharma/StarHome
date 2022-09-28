import 'package:star_home/pages/login.dart';
import 'package:star_home/routes.dart';
import 'package:star_home/pages/register_page.dart';
import 'package:star_home/values/color.dart';
import 'package:star_home/values/dimens.dart';
import 'package:star_home/values/text_styles.dart';
import 'package:star_home/widgets/button.dart';
import 'package:star_home/widgets/frosted_background.dart';
import 'package:star_home/widgets/titles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnboardingPage extends StatelessWidget {
  static String route = 'onboarding';
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final totalHeight = MediaQuery.of(context).size.height;
    final totalWidth = MediaQuery.of(context).size.width;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: SafeArea(
        child: Scaffold(
          body: FrostedBackground(
            child: Stack(
              children: [
                Positioned(
                  bottom: 50.h,
                  right: 40.h,
                  child: MaterialButton(
                      onPressed: () {
                        Navigator.pushNamed(context, LoginPage.route);
                      },
                      height: 50.w,
                      minWidth: 50.w,
                      color: AppColor.primary,
                      shape: CircleBorder(),
                      child: const Icon(Icons.arrow_forward_ios,
                          color: Colors.white)
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: totalWidth,
                    ),
                    SvgPicture.asset(
                      "assets/ui/onboarding.svg",
                      height: 150.w,
                      alignment: Alignment.topCenter,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      "Welcome to\nStar Home",
                      textAlign: TextAlign.center,
                      style: headingStyle,
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                    Text(
                      "Star Home provides best IOT automation solution for your home.",
                      style: lightText,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
