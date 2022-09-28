// ignore_for_file: prefer_const_constructors

import 'package:star_home/pages/profile_edit_page.dart';
import 'package:star_home/values/color.dart';
import 'package:star_home/values/text_styles.dart';
import 'package:star_home/widgets/GithubAuth.dart';
import 'package:star_home/widgets/back_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer';
import 'package:star_home/routes.dart';
import 'package:star_home/main.dart';
import 'package:star_home/pages/onboarding_page.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:star_home/widgets/authentication.dart';
import 'package:star_home/widgets/googleAuth.dart';

final firestoreInstance = FirebaseFirestore.instance;
var firebaseUser = FirebaseAuth.instance.currentUser;
final FirebaseAuth _auth = FirebaseAuth.instance;

String name = "Loading...";
String email = "Loading...";
String phone = "Loading...";
String registerNo = "Loading...";
String URL = "Loading...";

Map<String, dynamic> AllData = {
  'regNo': 'Loading...',
  'name': 'Loading...',
  'email': 'Loading...',
  'profilePic': '',
  'phone': 'Loading...'
};
void _onPressed() {
  var firebaseUser = FirebaseAuth.instance.currentUser;
  firestoreInstance
      .collection("users")
      .doc(firebaseUser!.uid)
      .get()
      .then((value) {
    print(value.data());
    AllData = value.data()!;
  });

}

class ProfilePage extends StatelessWidget {
  static String route = 'profilePage';
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    _onPressed();
    final totalWidth = MediaQuery.of(context).size.width;
    final totalHeight = MediaQuery.of(context).size.height;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: SafeArea(
        child: Scaffold(
          body: Stack(children: [
            Hero(
              tag: "app_bar",
              child: SvgPicture.asset(
                "assets/ui/app-shape-large.svg",
                alignment: Alignment.topCenter,
                color: AppColor.primary,
              ),
            ),
            const AppBackButton(),
            Positioned(
                right: totalWidth * 0.04,
                top: totalWidth * 0.05,
                child: IconButton(
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.white70,
                    size: 28,
                  ),
                  onPressed: () {
                    List user = firebaseUser!.providerData;
                    UserInfo userr = user.elementAt(0);

                    log(userr.providerId);
                    if (userr.providerId == "password") {
                      enabler = true;
                    } else {
                      enabler = false;
                    }

                    if (AllData !=
                        {
                          'regNo': 'Loading...',
                          'name': 'Loading...',
                          'email': 'Loading...',
                          'profilePic': '',
                          'phone': 'Loading...'
                        }) {
                      nameEdit.text = AllData['name'];
                      phoneEdit.text = AllData['phone'];
                      regNoEdit.text = AllData['regNo'];
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ProfileEdit()));
                    }
                  },
                )),
            Center(
              child: Column(
                children: [
                  SizedBox(
                    height: totalHeight * 0.05,
                  ),
                  FutureBuilder<DocumentSnapshot>(
                    future: users.doc(firebaseUser!.uid).get(),
                    builder: (BuildContext context,
                        AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return const Text("Something went wrong");
                      }
                      if (snapshot.hasData && !snapshot.data!.exists) {
                        return const Text("Document does not exist");
                      }
                      if (snapshot.connectionState == ConnectionState.done) {
                        Map<String, dynamic> data =
                        snapshot.data!.data() as Map<String, dynamic>;
                        return Hero(
                          tag: "profileIcon",
                          child: CircleAvatar(
                            radius: totalHeight * 0.1,
                            foregroundImage: CachedNetworkImageProvider('${AllData['profilePic']}'),
                            backgroundImage: CachedNetworkImageProvider('${AllData['profilePic']}'),
                          ),
                        );
                      } else {
                        return Hero(
                          tag: "profileIcon",
                          child: CircleAvatar(
                            radius: totalHeight * 0.1,
                            foregroundImage: CachedNetworkImageProvider('${AllData['profilePic']}'),
                            backgroundImage:
                            AssetImage('assets/images/profile-icon.png'),
                          ),
                        );
                      }
                    },
                  ),
                  SizedBox(
                    height: totalHeight * 0.02,
                  ),
                  Text(AllData['name'],style: lightTextWhite,),
                  SizedBox(
                    height: totalHeight * 0.015,
                  ),
                  Text(AllData['email'],style: lightTextWhite,),
                  SizedBox(
                    height: totalHeight * 0.01,
                  ),
                  Text(AllData['phone'],style: lightTextWhite,),
                  SizedBox(
                    height: totalHeight * 0.01,
                  ),

                  if (AllData['regNo'] == "") ...[
                    Text(
                      "You're not a VITian",
                      style: lightTextWhite,
                    ),
                  ] else ...[
                    Text(
                      "${AllData['regNo']}",
                      style: lightTextWhite,
                    ),
                  ],
                  MaterialButton(
                    onPressed: () async {
                      await logOut(context);
                    },
                    color: AppColor.secondary,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text("Logout"),
                        SizedBox(width: 10),
                        Icon(Icons.logout),
                      ],
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(17)),
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: CircleAvatar(
                  radius: totalHeight * 0.1,
                  backgroundImage:
                  AssetImage('assets/images/logo.jpeg'),
                ),
              ),
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child:
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("© 2022 Star Home. All Rights Reserved"),
              ),
            )
          ]),
        ),
      ),
    );
  }

  logOut(context) async {
    List user = firebaseUser!.providerData;
    UserInfo userr = user.elementAt(0);

    log(userr.providerId);
    if (userr.providerId == "password") {
      log('Email Logout');
      AuthenticationHelper().signOut();
      firebaseUser?.reload();
      dataa = {
        'name': 'Captain!',
        'url': '',
      };
      await Navigator.of(context).pushNamedAndRemoveUntil(
        OnboardingPage.route,
            (Route<dynamic> route) => false,
      );
    } else if (userr.providerId == "google.com") {
      FirebaseService service = new FirebaseService();
      await service.signOutFromGoogle();
      firebaseUser?.reload();
      dataa = {
        'name': 'Captain!',
        'url': '',
      };
      await Navigator.of(context).pushNamedAndRemoveUntil(
        OnboardingPage.route,
            (Route<dynamic> route) => false,
      );
    } else if (userr.providerId == "github.com") {
      log('Github Logout');



      GithubService service1 = GithubService();
      await service1.signOut();
      firebaseUser?.reload();
      dataa = {
        'name': 'Captain!',
        'url': '',
      };
      await Navigator.of(context).pushNamedAndRemoveUntil(
        OnboardingPage.route,
            (Route<dynamic> route) => false,
      );
    }
    log('Not Logged Out!');
  }
}
