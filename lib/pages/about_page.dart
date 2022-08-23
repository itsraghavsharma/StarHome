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
                    Center(child: Image.asset("assets/ui/logo_bg.png"))
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
                        "We at Android Club are driven to achieve excellence and solve problems while at it. Dedicated to educating and creating awareness about modern Mobile App development, we host workshops,",
                        softWrap: true,
                        textAlign: TextAlign.justify,
                        style: TextStyle(height: totalHeight * 0.002),
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
                              "hackathons, webinars, and all possible events under the sun, that help us build an inclusive community of like-minded people who explore and learn together. So, wear your thinking caps, put on some creativity, and let's develop some amazing apps!",
                              softWrap: true,
                              textAlign: TextAlign.justify,
                              style: TextStyle(height: totalHeight * 0.002),
                            ),
                          ),
                        ),
                        Image.asset(
                          "assets/images/about1.png",
                          height: totalHeight * 0.36,
                          width: totalHeight * 0.2,
                        ),
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
