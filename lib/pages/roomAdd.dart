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
import 'loading.dart';
import 'package:star_home/modal/user_data_modal.dart';
TextEditingController serial = TextEditingController();
TextEditingController nameC = TextEditingController();
TextEditingController app1name = TextEditingController();
TextEditingController app2name = TextEditingController();
TextEditingController app3name = TextEditingController();
TextEditingController app4name = TextEditingController();


final firestoreInstance = FirebaseFirestore.instance;
var firebaseUser = FirebaseAuth.instance.currentUser;

class RoomAdd extends StatefulWidget {
  static String route = 'RoomAdd';
  const RoomAdd({Key? key}) : super(key: key);

  @override
  State<RoomAdd> createState() => _RoomAddState();
}

bool _switchValue = false;


class _RoomAddState extends State<RoomAdd> {
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Map<String, dynamic> roomData1 = {};

  Future uploadData(context) async {
    String path = "assets/icons/bed.svg";

    for(int g = 0; g<roomData.length;g++)
      {
        if(roomData.length % 1 == 0)
        {
          path = "assets/icons/bed.svg";
        }
        if(roomData.length % 2 == 0)
        {
          path = "assets/icons/chair.svg";
        }
        if(roomData.length % 3 == 0)
        {
          path = "assets/icons/bathtub.svg";
        }
        if(roomData.length % 4 == 0)
        {
          path = "assets/icons/chair.svg";
        }
        if(roomData.length % 5 == 0)
        {
          path = "assets/icons/kitchen.svg";
        }
      }

    roomData.add(RoomModal(nameC.text.toString(), app1name.text.toString(), app2name.text.toString(), app3name.text.toString(), app4name.text.toString(), path, path, path, path, false, serial.text.toString()));
    print(roomData.length);
    //RoomModal(name, app1, app2, app3, app4, status, imageURL, temperature, humidity, isItSelected, Serial)
    for(int l = 0; l< roomData.length; l++)
      {
        roomData1.addAll({"${l}" : roomData[l].toMap()});
      }
      //print(roomData1);
    await firestoreInstance.collection("users").doc(firebaseUser!.uid).set({
      "name": userData[0].userName,
      "phone": userData[0].mobile,
      "email": userData[0].email,
      "profilePic": userData[0].ProfilePicURL,
      "roomData": roomData1,

    }).then((_) {
      Navigator.of(context).pushNamedAndRemoveUntil(
          LoadingPage.route,
      (Route<dynamic> route) => false);

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
    uploadData(context);
    //Navigator.pop(context); //pop dialog
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

                  const Title1(text: "Add Room!"),
                  Text(
                    "Enter details below : ",
                    style: lightText,
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  InputContainer(
                    child: TextField(
                      controller: serial,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Box Serial Number',
                        floatingLabelStyle: TextStyle(color: AppColor.primary),
                      ),
                    ),
                  ),
                  InputContainer(
                    child: TextField(
                      controller: nameC,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Room Name',
                        floatingLabelStyle: TextStyle(color: AppColor.primary),
                      ),
                    ),
                  ),
                  InputContainer(
                    child: TextField(
                      controller: app1name,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Appliance 1 Name',
                        floatingLabelStyle: TextStyle(color: AppColor.primary),
                      ),
                    ),
                  ),
                  InputContainer(
                    child: TextField(
                      controller: app2name,
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Appliance 2 Name',
                        floatingLabelStyle: TextStyle(color: AppColor.primary),
                      ),
                    ),
                  ),
                  InputContainer(
                    child: TextField(
                      controller: app3name,
                      //obscureText: true,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Appliance 3 Name',
                        floatingLabelStyle: TextStyle(color: AppColor.primary),
                      ),
                    ),
                  ),
                  InputContainer(
                    child: TextField(
                      controller: app4name,
                      //obscureText: true,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Appliance 4 Name',
                        floatingLabelStyle: TextStyle(color: AppColor.primary),
                      ),
                    ),
                  ),

                  AppButton(
                    text: "Save Room",
                    onTap: () {
                      if (nameC.text.toString() != "" &&
                          app1name.text.toString() != "" &&
                          app1name.text.toString() != "" &&
                          app1name.text.toString() != "" &&
                          app1name.text.toString() != "" &&
                          serial.text.toString() != "") {

                      uploadData(context);
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
