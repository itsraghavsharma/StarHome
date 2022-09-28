import 'package:star_home/main.dart';
import 'package:star_home/pages/login.dart';
import 'package:star_home/values/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'home_page.dart';
import 'package:star_home/modal/user_data_modal.dart';
class LoadingPage extends StatelessWidget {
  static String route = 'loading';
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    loader(context);

    return const AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AppColor.primary,
        body: Center(
          child: SpinKitSpinningLines(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
