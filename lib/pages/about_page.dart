import 'package:star_home/values/color.dart';
import 'package:star_home/values/text_styles.dart';
import 'package:star_home/widgets/back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AboutPage extends StatelessWidget {
  static String route = 'about';
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final totalHeight = MediaQuery.of(context).size.height;
    final totalWidth = MediaQuery.of(context).size.width;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              SvgPicture.asset(
                'assets/ui/app-shape-small.svg',
                color: AppColor.primary,
                alignment: Alignment.topCenter,
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(20.h),
                      child: Text(
                        "About us",
                        style: headingStyleWhite,
                      ),
                    ),
                   // Center(child: Image.asset("assets/images/logo.jpeg"))
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Column(children: [
                    Padding(
                      padding:
                      EdgeInsets.symmetric(horizontal: totalWidth * 0.07),
                      child: Text(
                        "Under Construction, Star Home Team",
                        softWrap: true,
                        textAlign: TextAlign.justify,
                        style: TextStyle(height: totalHeight * 0.01),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: totalWidth * 0.07),
                            child: Text(
                              "Project Exhibition, Under Dr. Gopal Singh Tandel",
                              softWrap: true,
                              textAlign: TextAlign.justify,
                              style: TextStyle(height: totalHeight * 0.03),
                            ),
                          ),
                        ),
                        // Image.asset(
                        //   "assets/images/about1.png",
                        //   height: totalHeight * 0.36,
                        //   width: totalHeight * 0.2,
                        // ),
                      ],
                    ),
                  ])
                ],
              ),
              const AppBackButton(),
            ],
          ),
        ),
      ),
    );
  }
}
