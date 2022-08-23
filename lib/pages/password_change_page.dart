import 'package:star_home/values/color.dart';
import 'package:star_home/values/text_styles.dart';
import 'package:star_home/widgets/back_button.dart';
import 'package:star_home/widgets/button.dart';
import 'package:star_home/widgets/frosted_background.dart';
import 'package:star_home/widgets/titles.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/input_field_container.dart';
import 'package:star_home/pages/profile_page.dart';

TextEditingController oldPass = TextEditingController();
TextEditingController newPass = TextEditingController();
TextEditingController reNewPass = TextEditingController();

class PasswordChangePage extends StatelessWidget {
  static String route = 'passwordChange';
  const PasswordChangePage({Key? key}) : super(key: key);

  void showMessage(String message, context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Hey!"),
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

  void _changePassword(
      String currentPassword, String newPassword, context) async {
    final user = await FirebaseAuth.instance.currentUser;
    final cred = EmailAuthProvider.credential(
        email: AllData['email'], password: currentPassword);

    user!.reauthenticateWithCredential(cred).then((value) {
      user.updatePassword(newPassword).then((_) {
        showMessage('Your Password is changed successfully', context);
      }).catchError((error) {
        showMessage(error.toString(), context);
      });
    }).catchError((err) {
      showMessage(err.toString(), context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FrostedBackground(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Stack(
              children: [
                const AppBackButton(),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 120.h,
                      ),
                      Text(
                        "Change your password",
                        style: headingStyle,
                        textAlign: TextAlign.center,
                      ),
                      InputContainer(
                        child: TextField(
                          controller: oldPass,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            floatingLabelStyle:
                            TextStyle(color: AppColor.primary),
                            labelText: 'Old Password',
                          ),
                        ),
                      ),
                      InputContainer(
                        child: TextField(
                          controller: newPass,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            floatingLabelStyle:
                            TextStyle(color: AppColor.primary),
                            labelText: 'New Password',
                          ),
                        ),
                      ),
                      InputContainer(
                        child: TextField(
                          controller: reNewPass,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            floatingLabelStyle:
                            TextStyle(color: AppColor.primary),
                            labelText: 'Re-enter New Password',
                          ),
                        ),
                      ),
                      AppButton(
                          text: "Change Password",
                          onTap: () {
                            if (oldPass.text.toString().isNotEmpty &&
                                newPass.text.toString().isNotEmpty &&
                                reNewPass.text.toString().isNotEmpty) {
                              if (newPass.text.toString() ==
                                  reNewPass.text.toString()) {
                                _changePassword(oldPass.text.toString(),
                                    newPass.text.toString(), context);
                              } else {
                                showMessage("Passwords don't match", context);
                              }
                            }
                          })
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
