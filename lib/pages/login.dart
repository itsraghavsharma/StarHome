
import 'package:star_home/pages/loading.dart';
import 'package:star_home/values/color.dart';
import 'package:star_home/values/text_styles.dart';
import 'package:star_home/widgets/button.dart';
import 'package:star_home/widgets/frosted_background.dart';
import 'package:star_home/widgets/input_field_container.dart';
import 'package:star_home/widgets/social_button.dart';
import 'package:star_home/widgets/titles.dart';
import 'package:flutter/material.dart';
import 'package:star_home/widgets/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'dart:developer';
import 'package:star_home/widgets/googleAuth.dart';
import 'package:star_home/widgets/GithubAuth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:star_home/routes.dart';
import '../main.dart';
import 'AdditionalRegiterationPage.dart';
import 'package:star_home/pages/register_page.dart';

TextEditingController emailController = TextEditingController();
TextEditingController passController = TextEditingController();

var firebaseUser = FirebaseAuth.instance.currentUser;

class LoginPage extends StatelessWidget {
  static String route = 'login';
  const LoginPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    void showMessage(String message) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Alert!"),
              content: Text(message),
              actions: [
                TextButton(
                  child: const Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    }

    void showMessager(String message) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Alert!"),
              content: Text(message),
              actions: [
                TextButton(
                  child: const Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text("Resend Link"),
                  onPressed: () async {
                    await firebaseUser!.sendEmailVerification();
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    }

    Future _onLoading(context) async {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Container(
              height: 100,
              padding: const EdgeInsets.all(24),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  SpinKitSpinningLines(
                    color: AppColor.primary,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text("please wait"),
                ],
              ),
            ),
          );
        },
      );
      log('Logging You In');
    }

    final totalHeight = MediaQuery.of(context).size.height;
    final totalWidth = MediaQuery.of(context).size.width;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: SafeArea(
        child: Scaffold(
          body: FrostedBackground(
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Stack(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: totalHeight * 0.15,
                      ),
                      const Title1(text: "Hey There!"),
                      Text(
                        "Welcome,",
                        style: lightText,
                      ),
                      Text(
                        "Login to continue further",
                        style: lightText,
                      ),
                      SizedBox(
                        height: totalHeight * 0.05,
                      ),
                      InputContainer(
                        child: TextField(
                          controller: emailController,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Email',
                            floatingLabelStyle:
                            TextStyle(color: AppColor.primary),
                          ),
                        ),
                      ),
                      InputContainer(
                        child: TextField(
                          controller: passController,
                          obscureText: true,
                          textInputAction: TextInputAction.done,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Password',
                            floatingLabelStyle:
                            TextStyle(color: AppColor.primary),
                          ),
                        ),
                      ),
                      AppButton(
                          text: "Login",
                          onTap: () {
                            _onLoading(context);
                            AuthenticationHelper()
                                .signIn(
                                email: emailController.text.toString(),
                                password: passController.text.toString())
                                .then((error) {
                              if (error == null) {
                                log('User Logging In...');
                                if (AuthenticationHelper().user.emailVerified) {
                                  log('Email Verified!');
                                  log('Proceeding...');
                                  //loader(context);
                                  Navigator.pop(context);
                                  Navigator.of(context)
                                      .pushNamedAndRemoveUntil(
                                    LoadingPage.route,
                                        (Route<dynamic> route) => false,
                                  );
                                } else {
                                  Navigator.pop(context);
                                  log('Please verify email'); //Pop up required
                                  //showMessager("A verification link was sent to your email. Click on it to continue login. If you have not received the link, kindly press resend.");
                                  //Ok Button
                                  //Resend verification with on click methods
                                  Navigator.of(context)
                                      .pushNamedAndRemoveUntil(
                                    LoadingPage.route,
                                        (Route<dynamic> route) => false,
                                  );
                                }
                              } else {
                                Navigator.pop(context);
                                showMessage(
                                    error.toString()); // Pop up required
                              }
                            });
                          }),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have an account?"),
                          TextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, RegisterPage.route);
                              },
                              child: const Text(
                                "Register Now",
                                style: TextStyle(color: AppColor.primary),
                              ))
                        ],
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                                width: totalWidth * 0.3,
                                child: const Divider()),
                            const Text("Or continue with"),
                            SizedBox(
                              height: totalHeight * 0.1,
                            ),
                            SizedBox(
                                width: totalWidth * 0.3,
                                child: const Divider()),
                          ]),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SocialButton(
                              icon: FontAwesome.google,
                              onTap: () async {
                                log('Google Login');
                                FirebaseService service = new FirebaseService();
                                try {
                                  _onLoading(context);
                                  String? Check =
                                  await service.signInwithGoogle();

                                  log('\n\nCheck is ${Check.toString()}\n\n');
                                  if (Check == "New User") {
                                    Navigator.pop(context);
                                    Navigator.pushNamed(
                                        context, AdditionalRegister.route);
                                  } else if (Check == "Old User") {
                                    Navigator.of(context)
                                        .pushNamedAndRemoveUntil(
                                      LoadingPage.route,
                                          (Route<dynamic> route) => false,
                                    );
                                  }
                                } catch (e) {
                                  Navigator.pop(context);
                                  if (e is FirebaseAuthException) {
                                    showMessage(e.message!);
                                  }
                                }
                              }),
                          SocialButton(
                              icon: FontAwesome.github,
                              onTap: () async {
                                GithubService service1 = GithubService();
                                try {
                                  _onLoading(context);
                                  final result =
                                  await service1.signInWithGitHub(context);

                                  if (result == "New User") {
                                    Navigator.pop(context);
                                    Navigator.pushNamed(
                                        context, AdditionalRegister.route);
                                  } else if (result == "Old User") {
                                    Navigator.of(context)
                                        .pushNamedAndRemoveUntil(
                                      LoadingPage.route,
                                          (Route<dynamic> route) => false,
                                    );
                                  }
                                } catch (e) {
                                  Navigator.pop(context);
                                  if (e is FirebaseAuthException) {
                                    showMessage(e.message!);
                                  }
                                }
                              }),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// loader(context) async {
//   log('Loading Data');
//   await initRetrieval();
//   log('Almost there!');
//   await initRetrievalTeam();
//   log('Getting You to Home page');
//   Navigator.of(context).pushNamedAndRemoveUntil(
//     Navigation.route,
//         (Route<dynamic> route) => false,
//   );
// }

// logLoader(context, EventModal event) async {
//   log('Loading Data');
//   await initRetrieval();
//   log('Data Loaded');
//   EventModal newEvent = event;
//   for (var i = 0; i < allEvents.length; i++) {
//     if (allEvents[i].tag == event.tag) {
//       newEvent = allEvents[i];
//     }
//   }
//
//   Navigator.of(context).pushNamedAndRemoveUntil(
//     Navigation.route,
//         (Route<dynamic> route) => false,
//   );
//   await Navigator.push(
//       context,
//       MaterialPageRoute(
//           builder: (context) => EventDetailPage(
//             event: newEvent,
//           )));
// }
