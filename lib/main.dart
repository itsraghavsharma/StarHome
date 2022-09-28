// ignore_for_file: prefer_const_constructors

import 'package:star_home/routes.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:star_home/pages/about_page.dart';
import 'package:star_home/pages/home_page.dart';
import 'package:star_home/pages/loading.dart';
import 'package:star_home/pages/onboarding_page.dart';
import 'package:star_home/pages/profile_page.dart';

import 'package:star_home/values/color.dart';
import 'package:star_home/values/dimens.dart';
import 'package:star_home/values/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:io' show Platform;
import 'dart:developer';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';

Future<void> main(context) async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: AppColor.primary));
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Firebase.initializeApp();
  runApp(const MyApp());
}
Map<String, dynamic> dataa = {
  'name': 'Captain!',
  'url': '',
};
String namer = "Captain!";


final firestoreInstance = FirebaseFirestore.instance;
User? firebaseUser = FirebaseAuth.instance.currentUser;

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    String app = OnboardingPage.route;

    try {
      User? firebaseUserr = FirebaseAuth.instance.currentUser;
      var user = firebaseUserr ?? null;

      if (user?.uid != null) {
        app = LoadingPage.route;
      }
    } catch (e) {
      log(e.toString());
    }


    return ScreenUtilInit(

        builder: (BuildContext context,child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Star Home",
        theme: ThemeData(
            primaryColor: AppColor.primary,
            secondaryHeaderColor: AppColor.secondary,
            textTheme:
            GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)),
        initialRoute: app,
        routes: getRoutes(),
      )
    );

  }
}

class Navigation extends StatefulWidget {
  static String route = 'navigation';
  const Navigation({Key? key}) : super(key: key);

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _selectedIndex = 0;

  static final List<Widget> _pages = [
    const HomePage(),
    //const RegisteredEventPage(),
    const AboutPage(),
  ];

  void _onItemTapped(int index) {
    if (index != 2) {
      setState(() {
        _selectedIndex = index;
      });
    } else {
      Navigator.of(context).push(PageTransition(
          child: AboutPage(),
          type: PageTransitionType.rightToLeft,
          curve: Curves.easeOutSine,
          reverseDuration: Duration(milliseconds: 150),
          duration: Duration(milliseconds: 200)));
    }
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    var totalHeight;
    var totalWidth;
    if (Platform.isAndroid) {
      totalHeight = MediaQuery.of(context).size.height;
      totalWidth = MediaQuery.of(context).size.width;
    } else if (Platform.isIOS) {
      totalHeight = MediaQuery.of(context).size.height + 20;
      totalWidth = MediaQuery.of(context).size.width + 20;
    }

    // Profile Icon on AppBar
    Widget profileIcon() {
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ProfilePage(),
            ),
          );
          //do what you want here
        },
        child: Container(
          margin: const EdgeInsets.all(0),
          padding: const EdgeInsets.all(0),
          height: totalHeight * 0.075,
          width: totalHeight * 0.075,
          child: FutureBuilder<DocumentSnapshot>(
            future: users.doc(firebaseUser!.uid).get(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {

              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
                dataa = data;
                namer = data['name'];
                return Hero(
                  tag: "profileIcon",
                  child: CircleAvatar(
                    radius: 70.0,
                    foregroundImage:
                    CachedNetworkImageProvider('${dataa['profilePic']}'),
                    backgroundImage:
                    CachedNetworkImageProvider('${dataa['profilePic']}'),
                    backgroundColor: Colors.black45,
                  ),
                );
              }
              return CircleAvatar(
                radius: 70.0,
                foregroundImage: CachedNetworkImageProvider('${dataa['profilePic']}'),
                backgroundImage: AssetImage("assets/images/profile-icon.png"),
                backgroundColor: Colors.transparent,
              );
            },
          ),
        ),
      );
    }

    // Main
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Platform.isAndroid
            ? SafeArea(
            child: theApp(totalHeight, totalWidth, users, profileIcon))
            : theApp(totalHeight, totalWidth, users, profileIcon));
  }

  Scaffold theApp(totalHeight, totalWidth, CollectionReference<Object?> users,
      Widget Function() profileIcon) {
    return Scaffold(
      body: Stack(
        children: [
          _pages.elementAt(_selectedIndex),
          Align(
              alignment: Alignment.bottomCenter,
              child: bottomNav(totalHeight * 0.01, totalWidth * 0.1)),
          if (_selectedIndex <= 1) ...[
            Hero(
              tag: "app_bar",
              child: SvgPicture.asset(
                'assets/ui/app_bar.svg',
                semanticsLabel: 'App Bar',
                color: AppColor.primary,
                alignment: Alignment.topCenter,
              ),
            ),
            Positioned(
              top: 30.w,
              left: 30.w,
              child: Text(
                "Hello!",
                style: mediumTextWhite,
              ),
            ),
            Positioned(
              top: 50.w,
              left: 30.w,
              child: FutureBuilder<DocumentSnapshot>(
                future: users.doc(firebaseUser!.uid).get(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {

                  if (snapshot.connectionState == ConnectionState.done) {
                    Map<String, dynamic> data =
                    snapshot.data!.data() as Map<String, dynamic>;
                    dataa = data;
                    return Text(dataa['name'].split(' ')[0],
                        style: headingStyleWhite);
                  }
                  return Text(dataa['name'].split(' ')[0],
                      style: headingStyleWhite);

                },
              ),

            ),
            Positioned(
              top: 15.w,
              right: 30.w,
              child: profileIcon(),
            )
          ]
        ],
      ),
    );
  }

  // Bottom Nav
  Widget bottomNav(height, width) {
    return Container(
      height: AppDimens.bottomNavHeight,
      //margin: EdgeInsets.symmetric(horizontal: width, vertical: height),
      decoration: const BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(250),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
      topRight: Radius.circular(30),topLeft: Radius.circular(30),
    ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          backgroundColor: Colors.brown,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white.withOpacity(.60),
          selectedFontSize: 10,
          unselectedFontSize: 10,
          onTap: _onItemTapped,
          currentIndex: _selectedIndex,
          items: const [
            BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(Icons.home_rounded),
            ),
            // BottomNavigationBarItem(
            //   label: 'Events',
            //   icon: Icon(Icons.event_available_rounded),
            // ),
            BottomNavigationBarItem(
              label: 'About',
              icon: Icon(Icons.feed),
            ),
          ],
        ),
      ),
    );
  }
}
