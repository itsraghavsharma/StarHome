import 'dart:developer';
import 'package:star_home/pages/profile_page.dart';

import 'package:star_home/pages/password_change_page.dart';
import 'package:star_home/values/color.dart';
import 'package:star_home/values/text_styles.dart';
import 'package:star_home/widgets/back_button.dart';
import 'package:star_home/widgets/button.dart';
import 'package:star_home/widgets/frosted_background.dart';
import 'package:star_home/widgets/titles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/input_field_container.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart';
import 'package:flutter/services.dart';

final firestoreInstance = FirebaseFirestore.instance;
var firebaseUser = FirebaseAuth.instance.currentUser;

TextEditingController nameEdit = TextEditingController();
TextEditingController phoneEdit = TextEditingController();
TextEditingController regNoEdit = TextEditingController();
final ImagePicker picker = ImagePicker();
bool enabler = true;

class ProfileEdit extends StatefulWidget {
  static String route = 'profileEdit';
  const ProfileEdit({Key? key}) : super(key: key);

  @override
  State<ProfileEdit> createState() => _ProfileEditPage();
}

class _ProfileEditPage extends State<ProfileEdit> {
  //const ProfileEditPage({Key? key}) : super(key: key);

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  File image = File('');

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future pickImageC() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  void _showOptions(BuildContext context) {
    final totalHeight = MediaQuery.of(context).size.height;
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: totalHeight * 0.15,
          child: Column(
            children: <Widget>[
              ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    pickImageC();
                  },
                  leading: const Icon(Icons.photo_camera),
                  title: const Text(
                    "Take a picture from camera",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  )),
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                  pickImage();
                },
                leading: const Icon(Icons.photo_library),
                title: const Text(
                  "Choose from photo library",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  var downloadUrl = "";
  Future uploadFile(context) async {
    if (image == File('')) {
      log('Image Null');
      await firestoreInstance.collection("users").doc(firebaseUser!.uid).set({
        "name": nameEdit.text.toString(),
        "phone": phoneEdit.text.toString(),
        "email": AllData['email'],
        "regNo": regNoEdit.text.toString().toUpperCase(),
        "profilePic": AllData['profilePic'],
        "allRegisteredEvents": [],
      }).then((_) {
        log('Profile Edited');
        Navigator.pop(context);
      });
    } else {
      log('Image Not Null');
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
          "name": nameEdit.text.toString(),
          "phone": phoneEdit.text.toString(),
          "email": AllData['email'],
          "regNo": regNoEdit.text.toString().toUpperCase(),
          "profilePic": downloadUrl,
          "allRegisteredEvents": [],
        }).then((_) {
          log('Profile Edited');
        });
      } catch (e) {
        log('error occured while uploading');

        await firestoreInstance.collection("users").doc(firebaseUser!.uid).set({
          "name": nameEdit.text.toString(),
          "phone": phoneEdit.text.toString(),
          "email": AllData['email'],
          "regNo": regNoEdit.text.toString().toUpperCase(),
          "profilePic": AllData['profilePic'],
          "allRegisteredEvents": [],
        }).then((_) {
          log('Using default photo');
          log('Profile Edited');
        });
      }
      //await initRetrieval();

      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ProfilePage(),
        ),
      );
    }
  }

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    final totalHeight = MediaQuery.of(context).size.height;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: SafeArea(
        child: Scaffold(
          body: FrostedBackground(
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Stack(
                children: [
                  const AppBackButton(),
                  Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: totalHeight * 0.05,
                        ),
                        GestureDetector(
                          onTap: () {
                            _showOptions(context);
                          }, // Display Picture Button
                          child: CircleAvatar(
                            radius: totalHeight * 0.1,
                            foregroundImage: FileImage(image),
                            backgroundImage: CachedNetworkImageProvider(
                                '${AllData['profilePic']}'),
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                        SizedBox(
                          height: totalHeight * 0.03,
                        ),
                        FutureBuilder<DocumentSnapshot>(
                          future: users.doc(firebaseUser!.uid).get(),
                          builder: (BuildContext context,
                              AsyncSnapshot<DocumentSnapshot> snapshot) {
                            if (snapshot.hasError) {
                              return const Title1(text: "Hello!");
                            }
                            if (snapshot.hasData && !snapshot.data!.exists) {
                              return const Title1(text: "Hello!");
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              Map<String, dynamic> data =
                              snapshot.data!.data() as Map<String, dynamic>;
                              return Title1(text: "Hey! ${data['name']}");
                            }
                            return const Title1(text: "loading");
                          },
                        ),
                        Text(
                          "Edit your profile",
                          style: lightText,
                        ),
                        SizedBox(
                          height: totalHeight * 0.03,
                        ),
                        InputContainer(
                          child: TextField(
                            controller: nameEdit,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Name',
                            ),
                          ),
                        ),
                        InputContainer(
                          child: TextField(
                            controller: phoneEdit,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Phone',
                            ),
                          ),
                        ),
                        InputContainer(
                          child: TextField(
                            controller: regNoEdit,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Registration Number',
                            ),
                          ),
                        ),
                        SizedBox(
                          height: totalHeight * 0.03,
                        ),
                        AppButton(
                            text: "Update!",
                            onTap: () {
                              uploadFile(context);
                            }),
                        if (enabler)
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) =>
                                        const PasswordChangePage())));
                              },
                              child: const Text("Change your password"))
                      ],
                    ),
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
