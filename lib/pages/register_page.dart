import 'package:star_home/values/color.dart';
import 'package:star_home/values/text_styles.dart';
import 'package:star_home/widgets/button.dart';
import 'package:star_home/widgets/frosted_background.dart';
import 'package:star_home/widgets/input_field_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../widgets/titles.dart';
import 'dart:developer';
import 'package:flutter/services.dart';
import 'package:star_home/widgets/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart';

TextEditingController emailC = TextEditingController();
TextEditingController nameC = TextEditingController();
TextEditingController phoneC = TextEditingController();
TextEditingController passC = TextEditingController();
TextEditingController rePassC = TextEditingController();
TextEditingController regNoC = TextEditingController();

final firestoreInstance = FirebaseFirestore.instance;
var firebaseUser = FirebaseAuth.instance.currentUser;

class RegisterPage extends StatefulWidget {
  static String route = 'registerPage';
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

bool _switchValue = false;
final ImagePicker picker = ImagePicker();

class _RegisterPageState extends State<RegisterPage> {
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  File image = File('');

  Future pickImage() async {
    try {
      final image = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 10);

      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future pickImageC() async {
    try {
      final image = await ImagePicker()
          .pickImage(source: ImageSource.camera, imageQuality: 10);

      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  void _showOptions(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
              height: 150,
              child: Column(children: <Widget>[
                ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      pickImageC();
                    },
                    leading: const Icon(Icons.photo_camera),
                    title: const Text("Take a picture from camera")),
                ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      pickImage();
                    },
                    leading: const Icon(Icons.photo_library),
                    title: const Text("Choose from photo library"))
              ]));
        });
  }

  var downloadUrl = "";
  Future uploadFile(context) async {
    if (image == null) {
      await firestoreInstance.collection("users").doc(firebaseUser!.uid).set({
        "name": nameC.text.toString(),
        "phone": phoneC.text.toString(),
        "email": emailC.text.toString(),
        "regNo": regNoC.text.toString().toUpperCase(),
        "profilePic":
        'https://firebasestorage.googleapis.com/v0/b/android-club-65a70.appspot.com/o/Default%20Profile.jpeg?alt=media&token=a1528021-8b7a-44c4-85c7-4f96012cc771',
        "allRegisteredEvents": [],
      }).then((_) {
        log('You Are Set! A verification email has been sent to your email address. Kindly click on it.');
        Navigator.pop(context);
      });
    } else {
      final fileName = basename(image.path);
      final destination = 'ProfilePic/$fileName';

      try {
        final ref = firebase_storage.FirebaseStorage.instance
            .ref('users')
            .child(firebaseUser!.uid)
            .child(destination);

        await ref.putFile(image);
        var snapshot = await ref.putFile(image);
        downloadUrl = await snapshot.ref.getDownloadURL();
        await firestoreInstance.collection("users").doc(firebaseUser!.uid).set({
          "name": nameC.text.toString(),
          "phone": phoneC.text.toString(),
          "email": emailC.text.toString(),
          "regNo": regNoC.text.toString().toUpperCase(),
          "profilePic": downloadUrl,
          "allRegisteredEvents": [],
        }).then((_) {
          log('You Are Set! A verification email has been sent to your email address. Kindly click on it.');
        });
      } catch (e) {
        log('error occured while uploading');

        await firestoreInstance.collection("users").doc(firebaseUser!.uid).set({
          "name": nameC.text.toString(),
          "phone": phoneC.text.toString(),
          "email": emailC.text.toString(),
          "regNo": regNoC.text.toString().toUpperCase(),
          "profilePic":
          'https://firebasestorage.googleapis.com/v0/b/android-club-65a70.appspot.com/o/Default%20Profile.jpeg?alt=media&token=a1528021-8b7a-44c4-85c7-4f96012cc771',
          "allRegisteredEvents": [],
        }).then((_) {
          log('Using default photo');
          log('You Are Set! A verification email has been sent to your email address. Kindly click on it.');
        });
      }

      Navigator.pop(context);
    }
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
    await uploadFile(context);
    Navigator.pop(context); //pop dialog
  }

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
                  GestureDetector(
                    onTap: () {
                      log('tapped');
                      _showOptions(context);
                      //do what you want here
                    },
                    child: CircleAvatar(
                      radius: 60.0,
                      foregroundImage: FileImage(image),
                      backgroundImage:
                      const AssetImage("assets/images/profile-icon.png"),
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                  const Title1(text: "Sign Up!"),
                  Text(
                    "Enter your details below : ",
                    style: lightText,
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  InputContainer(
                    child: TextField(
                      controller: nameC,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Name',
                        floatingLabelStyle: TextStyle(color: AppColor.primary),
                      ),
                    ),
                  ),
                  InputContainer(
                    child: TextField(
                      controller: emailC,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Email',
                        floatingLabelStyle: TextStyle(color: AppColor.primary),
                      ),
                    ),
                  ),
                  InputContainer(
                    child: TextField(
                      controller: phoneC,
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Phone',
                        floatingLabelStyle: TextStyle(color: AppColor.primary),
                      ),
                    ),
                  ),
                  InputContainer(
                    child: TextField(
                      controller: passC,
                      obscureText: true,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Password',
                        floatingLabelStyle: TextStyle(color: AppColor.primary),
                      ),
                    ),
                  ),
                  InputContainer(
                    child: TextField(
                      controller: rePassC,
                      obscureText: true,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Re-enter Password',
                        floatingLabelStyle: TextStyle(color: AppColor.primary),
                      ),
                    ),
                  ),
                  // Row(
                  //   children: [
                  //     SizedBox(
                  //       width: 40.h,
                  //     ),
                  //     const Text("Are you a VITian?"),
                  //     Switch(
                  //       activeColor: Colors.green,
                  //       value: _switchValue,
                  //       onChanged: (value) {
                  //         setState(() {
                  //           print("VALUE : $value");
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
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          labelText: 'Registration Number',
                          floatingLabelStyle:
                          TextStyle(color: AppColor.primary),
                        ),
                      ),
                    ),
                  AppButton(
                    text: "Register",
                    onTap: () {
                      if (emailC.text.toString() != "" &&
                          passC.text.toString() != "" &&
                          nameC.text.toString() != "" &&
                          phoneC.text.toString() != "" &&
                          rePassC.text.toString() != "") {
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
                        if (passC.text.toString() == rePassC.text.toString()) {
                          AuthenticationHelper()
                              .signUp(
                              email: emailC.text.toString(),
                              password: passC.text.toString())
                              .then((error) {
                            if (error == null) {
                              //uploadFile(context);
                              _onLoading(context);
                            } else {
                              log('Error : $error');
                              showMessage(error);
                            }
                          });
                        } else {
                          log("Passwords don't match!");
                          showMessage("Passwords don't match!");
                        }
                      } else {
                        log('Please fill all fields to continue');
                        showMessage('Please fill all fields to continue');
                      }
                    },
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
