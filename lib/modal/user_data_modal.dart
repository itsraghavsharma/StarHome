import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'dart:developer';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:star_home/main.dart';
import 'package:star_home/values/app_icon_icons.dart';

final FirebaseFirestore _db = FirebaseFirestore.instance;
var firebaseUser = FirebaseAuth.instance.currentUser;


class UserModal {
  String userName;
  String email;
  String mobile;
  String ProfilePicURL;
  Map<String, dynamic> roomData = {
    'RoomName': 'Loading...',
    'app1': 'Loading...',
    'app2': 'Loading...',
    'app3': 'Loading...',
    'app4': 'Loading...',
    'status': 'Loading...'
  };

  UserModal(
      this.userName,
      this.email,
      this.mobile,
      this.ProfilePicURL,
      this.roomData,
      );

  Map<String, dynamic> toMap() {
    return {
      'UserName': userName,
      'email': email,
      'mobile': mobile,
      'ProfilePicURL': ProfilePicURL,
      'roomData': roomData,
    };
  }

  UserModal.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : userName = doc.data()!["name"],
        email = doc.data()!["email"],
        mobile = doc.data()!["phone"],
        ProfilePicURL = doc.data()!["profilePic"],
        roomData = doc.data()!["roomData"];

}

List<UserModal> userData = [];
List<RoomModal> roomData = [];

Future<List<UserModal>> retrieveRoomData() async {

  QuerySnapshot<Map<String, dynamic>> snapshot =
  await _db.collection("users").get();
  print("Snaper");

        List<UserModal> newer = snapshot.docs
          .map((docSnapshot) => UserModal.fromDocumentSnapshot(docSnapshot))
          .toList();

        for (var j = 0; j< newer.length; j++)
        {
          if(newer[j].email.toString() != firebaseUser!.email)
          {
            newer.removeAt(j);
          }
        }

        return newer;

}

initRetrieval() async {

  userData = await retrieveRoomData();
print(userData[0].roomData);

   for(var k = 0; k < userData[0].roomData.length; k++)
    {
      if(k==0)
        {
          roomData = [];
          roomData.add(RoomModal(userData[0].roomData["${k}"]["name"], userData[0].roomData["${k}"]["app1"], userData[0].roomData["${k}"]["app2"], userData[0].roomData["${k}"]["app3"], userData[0].roomData["${k}"]["app4"], userData[0].roomData["${k}"]["status"],userData[0].roomData["${k}"]["img"],userData[0].roomData["${k}"]["temp"],userData[0].roomData["${k}"]["humid"],true,userData[0].roomData["${k}"]["serial"]));

        }
      else
        {
          roomData.add(RoomModal(userData[0].roomData["${k}"]["name"], userData[0].roomData["${k}"]["app1"], userData[0].roomData["${k}"]["app2"], userData[0].roomData["${k}"]["app3"], userData[0].roomData["${k}"]["app4"], userData[0].roomData["${k}"]["status"],userData[0].roomData["${k}"]["img"],userData[0].roomData["${k}"]["temp"],userData[0].roomData["${k}"]["humid"],false,userData[0].roomData["${k}"]["serial"]));

        }
       }
  print("Room Data is");
 // print("Room's Name : ${roomData[0].name}\napp1 : ${roomData[0].app1}\napp2 : ${roomData[0].app2}\napp3 : ${roomData[0].app3}\napp4 : ${roomData[0].app4}\nStatus : ${roomData[0].status}\nImg : ${roomData[0].imageURL}\nTemp : ${roomData[0].temperature}\nHumid : ${roomData[0].humidity}\nroom 1: ${roomData[0].isItSelected}\nroom2 : ${roomData[0].isItSelected}");
}

loader(context) async
{
  await initRetrieval();


  Navigator.of(context)
      .pushNamedAndRemoveUntil(Navigation.route,
        (Route<dynamic> route) => false,
  );
}


class RoomModal {
  String name;
  String app1;
  String app2;
  String app3;
  String app4;
  String status;
  String temperature;
  String humidity;
  String imageURL;
  bool isItSelected;
  String Serial;

  RoomModal(
      this.name,
      this.app1,
      this.app2,
      this.app3,
      this.app4,
      this.status,
      this.imageURL,
      this.temperature,
      this.humidity,
      this.isItSelected,
      this.Serial,
      );
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'app1': app1,
      'app2': app2,
      'app3': app3,
      'app4': app4,
      'status': status,
      'img': temperature,
      'temp': humidity,
      'humid': imageURL,
      'select': isItSelected,
      'serial': Serial,
    };
  }
}