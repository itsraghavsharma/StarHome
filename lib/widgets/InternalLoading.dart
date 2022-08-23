//import 'package:star_home/modal/event_data.dart';
import 'package:star_home/pages/login.dart';
import 'package:star_home/values/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class InternalLoadingPage extends StatelessWidget {
  //final EventModal eventy;
  //const InternalLoadingPage({Key? key, required this.eventy}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //logLoader(context, eventy);
    return const AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AppColor.bottomBar,
        body: Center(
          child: SpinKitSpinningLines(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
