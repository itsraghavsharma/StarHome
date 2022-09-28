import 'package:star_home/values/color.dart';
import 'package:star_home/values/text_styles.dart';
import 'package:star_home/widgets/button.dart';
import 'package:star_home/widgets/frosted_background.dart';
import 'package:star_home/widgets/input_field_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../widgets/titles.dart';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:star_home/main.dart';


TextEditingController nameC = TextEditingController();
TextEditingController phoneC = TextEditingController();
TextEditingController regNoC = TextEditingController();

final firestoreInstance = FirebaseFirestore.instance;
var firebaseUser = FirebaseAuth.instance.currentUser;

class AdditionalRegister extends StatefulWidget {
  static String route = 'additionalRegister';
  const AdditionalRegister({Key? key}) : super(key: key);

  @override
  State<AdditionalRegister> createState() => _AddRegister();
}

bool _switchValue = false;

class _AddRegister extends State<AdditionalRegister> {
  Future uploadData(context) async {
    await firestoreInstance.collection("users").doc(firebaseUser!.uid).set({
      "name": nameC.text.toString(),
      "phone": phoneC.text.toString(),
      "email": firebaseUser!.email,
      "regNo": regNoC.text.toString().toUpperCase(),
      "profilePic": firebaseUser!.photoURL,
      "allRegisteredEvents": [],
    }).then((_) {
      loader(context);
    });
  }

  loader(context) async {
    log('Loading Data');
    //await initRetrieval();
    log('Almost there!');
    //await initRetrievalTeam();
    log('Getting You to Home page');
    Navigator.of(context).pushNamedAndRemoveUntil(
      Navigation.route,
          (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    nameC.text = firebaseUser!.displayName.toString();
    Future _onLoading(context) async {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                SpinKitSpinningLines(
                  color: AppColor.primary,
                ),
                SizedBox(
                  width: 15,
                ),
                Text("Loading"),
              ],
            ),
          );
        },
      );

      await uploadData(context);

      //pop dialog
    }

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: FrostedBackground(
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 60,
                  ),
                  const Title1(text: "Additional Info!"),
                  Text(
                    "You are just a few steps away...",
                    style: lightText,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  InputContainer(
                    child: TextField(
                      controller: nameC,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: '',
                        labelText: 'Display Name',
                      ),
                    ),
                  ),
                  InputContainer(
                    child: TextField(
                      controller: phoneC,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: '',
                        labelText: 'Phone Number',
                      ),
                    ),
                  ),
                  // Row(
                  //   children: [
                  //     const SizedBox(
                  //       width: 40,
                  //     ),
                  //   const Text("Are you a vitian?"),
                  //     Switch(
                  //       activeColor: AppColor.primary,
                  //       value: _switchValue,
                  //       onChanged: (value) {
                  //         setState(() {
                  //           //print("VALUE : $value");
                  //           _switchValue = value;
                  //         });
                  //       },
                  //     )
                  //   ],
                  // ),
                  if (_switchValue == true)
                    InputContainer(
                      child: TextField(
                        controller: regNoC,
                        enabled: _switchValue,
                        textInputAction: TextInputAction.done,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Hello Fellow VITian!!!',
                          labelText: 'Registration Number',
                        ),
                      ),
                    ),
                  AppButton(
                      text: "Continue!",
                      onTap: () {
                        if (nameC.text.toString() != "" &&
                            phoneC.text.toString() != "") {
                          if (_switchValue == true) {
                            if (regNoC.text.toString() == "") {
                              log('Please enter registration number');
                              return;
                            }
                          }
                          if (phoneC.text.toString().length < 10) {
                            if (phoneC.text.toString().isEmpty) {
                              log('Are you sure you want to continue without phone number');
                              return;
                            } else {
                              log('Please enter a correct phone number');
                            }
                          }
                          _onLoading(context);
                        } else {
                          log('Please fill all fields to continue');
                        }
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
