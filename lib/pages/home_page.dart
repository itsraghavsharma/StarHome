import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:star_home/pages/roomAdd.dart';
import 'package:star_home/widgets/titles.dart';
import 'package:star_home/widgets/accessory_card.dart';
import 'package:star_home/widgets/titles.dart';
import 'package:flutter/material.dart';
import 'package:star_home/values/text_styles.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:star_home/widgets/room_slider.dart';
import 'package:star_home/widgets/tumid_banner.dart';
import 'package:star_home/widgets/accessory_cards.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'profile_page.dart';
import '../values/color.dart';
import 'package:star_home/widgets/social_button.dart';
import 'package:star_home/modal/user_data_modal.dart';
import 'package:flutterfire_ui/database.dart';
final FirebaseFirestore _db = FirebaseFirestore.instance;
var firebaseUser = FirebaseAuth.instance.currentUser;
FirebaseDatabase database = FirebaseDatabase.instance;
var selectedRoomSerial = roomData[0].Serial;

class HomePage extends StatefulWidget {
  static String route = 'homepage';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}
  class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = Get.size;
    final usersQuery = FirebaseDatabase.instance.ref();
   //selectedRoomSerial = roomData[0].Serial;

    return Container(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.067),
    height: size.height,
    width: size.width,
    color: Theme.of(context).scaffoldBackgroundColor,
    child: Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      SizedBox(height: size.height * 0.25),


      Expanded(
          child: Container(
          width: size.width * 0.9,
          child: SingleChildScrollView(
          child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Project Exhibition'),
                Text('Group 280'),
              ],
            ),
            //SizedBox(height: size.height * 0.03),
            SizedBox(height: size.height * 0.015),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                //Text('Rooms'),
                Title1(text: "Rooms"),
                SocialButton(
                    icon: Icons.add,
                    onTap: () async {
                      Navigator.pushNamed(
                          context, RoomAdd.route);
                    }),
              ],
            ),
            SizedBox(height: size.height * 0.02),
            if(roomData.isNotEmpty)
            Container(
                width: size.width,
                height: size.height * 0.15,
                child:ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: roomData.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      child: RoomSelector(
                        roomName: roomData[index].name,
                        roomImageURL: roomData[index].imageURL,
                        //roomImageURL:"assets/icons/bed.svg",
                        isSelected: roomData[index].isItSelected,

                      ),
                      onTap: () {
                        //print("Index is ${index} => selected : ${roomData[index].isItSelected}");
                        if (roomData[index].isItSelected != true) {
                          //print("for loop");
                          for (int h = 0; h < roomData.length; h++) {

                            setState(() {roomData[h].isItSelected = false;});
                            //print("h is ${h} : ${roomData[h].isItSelected}");
                          }
                          setState(() {roomData[index].isItSelected = true;});
                          setState(() {selectedRoomSerial = roomData[index].Serial;});
                        }

                      }
                    );
                  },
                ),
            ),
            if(roomData.isEmpty)
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [Text("Pls Add a room to continue...")],
            ),
            SizedBox(height: size.height * 0.04),
            Text('Smart Accessories',style: speakerName,),
            SizedBox(height: size.height * 0.02),
            if(roomData.isNotEmpty)
            StreamBuilder(

                stream:  FirebaseDatabase.instance.ref().child("SerialNumbers").child(selectedRoomSerial).onValue,
                builder: (context,AsyncSnapshot<dynamic>  snapshot) {
                  selectedRoomSerial = roomData[0].Serial;
                  if (snapshot.hasData) {
                    DatabaseEvent databaseEvent = snapshot.data!;
                    var databaseSnapshot = databaseEvent.snapshot;
                    print('Snapshot: ${databaseSnapshot.value}');
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TumidBanner(
                          img: 'assets/icons/temperature.png',
                          title: 'Temperature',
                          horizontalPadding: Get.width * 0.044,
                          child: Text("${databaseSnapshot.child("temperature").value}"),
                        ),
                        TumidBanner(
                          img: 'assets/icons/humidity.png',
                          title: 'Humidity',
                          horizontalPadding: Get.width * 0.044,
                          child: Text("${databaseSnapshot.child("humidity").value}"),
                        ),
                      ],
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                }),

            SizedBox(height: size.height * 0.02),

            SizedBox(height: size.height * 0.03),
            if(roomData.isNotEmpty)

            //SizedBox(height: size.height * 0.03),
            if(roomData.isNotEmpty)
             StreamBuilder(
                  stream:  FirebaseDatabase.instance.ref().child("SerialNumbers").child(selectedRoomSerial).onValue,
                  builder: (context,AsyncSnapshot<dynamic>  snapshot) {
                  if (snapshot.hasData) {
                  DatabaseEvent databaseEvent = snapshot.data!;
                  var databaseSnapshot = databaseEvent.snapshot;
                  print('Snapshot: ${databaseSnapshot.value}');
                  bool state0 = false, state1= false, state2= false, state3= false;
                  var RelayStatus = databaseSnapshot.child("Relay").value;

                  if(RelayStatus == 0) {state0 = state1 = state2 = state3 = false;}
                  if(RelayStatus == 1) {state0 = true; state1 = state2 = state3 = false;}
                  if(RelayStatus == 2) {state1 = true; state0 = state2 = state3 = false;}
                  if(RelayStatus == 3) {state2 = true; state1 = state0 = state3 = false;}
                  if(RelayStatus == 4) {state3 = true; state1 = state2 = state0 = false;}
                  if(RelayStatus == 5) {state0 = state1 = true; state2 = state3 = false;}
                  if(RelayStatus == 6) {state0 = state2 = true; state1 = state3 = false;}
                  if(RelayStatus == 7) {state1 = state2 = false;state0 = state3 = true;}
                  if(RelayStatus == 8) {state0 = state1 = state2 = true; state3 = false;}
                  if(RelayStatus == 9) {state0 = state1 = state3 = true; state2 = false;}
                  if(RelayStatus == 10) {state0 = state3 = state2 = true; state1 = false;}
                  if(RelayStatus == 11) {state0 = state1 = state2 = state3 = true;}
                  if(RelayStatus == 12) {state1 = state2 = true;state0 = state3 = false;}
                  if(RelayStatus == 13) {state0 = state2 = false;state1 = state3 = true;}
                  if(RelayStatus == 14) {state1 = state2 = state3 = true;state0 = false;}
                  if(RelayStatus == 15) {state0 = state1 = false; state2 = state3 = true;}

                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SmartSystem(
                            color: Colors.lightBlue,
                            index: 0,
                            title: roomData[0].app1,
                            isToggle: state0,
                            imageUrl: 'assets/images/icons8-light-96.png',
                            onToggleTap: () {
                              state0 = !state0;
                              var status = 0;
                              if(!state0 && !state1 && !state2 && !state3) {status = 0;}
                              else if(state0 && !state1 && !state2 && !state3) {status = 1;}
                              else if(!state0 && state1 && !state2 && !state3) {status = 2;}
                              else if(!state0 && !state1 && state2 && !state3) {status = 3;}
                              else if(!state0 && !state1 && !state2 && state3) {status = 4;}
                              else if(state0 && state1 && !state2 && !state3) {status = 5;}
                              else if(state0 && !state1 && state2 && !state3) {status = 6;}
                              else if(state0 && !state1 && !state2 && state3) {status = 7;}
                              else if(state0 && state1 && state2 && !state3) {status = 8;}
                              else if(state0 && state1 && !state2 && state3) {status = 9;}
                              else if(state0 && !state1 && state2 && state3) {status = 10;}
                              else if(state0 && state1 && state2 && state3) {status = 11;}
                              else if(!state0 && state1 && state2 && !state3) {status = 12;}
                              else if(!state0 && state1 && !state2 && state3) {status = 13;}
                              else if(!state0 && state1 && state2 && state3) {status = 14;}
                              else if(!state0 && !state1 && state2 && state3) {status = 15;}
                              print("status is ${status}");
                              FirebaseDatabase.instance.ref().child("SerialNumbers").child(selectedRoomSerial).update({
                                "Relay": status,
                              });

                            },
                            onTap: () {

                            },
                          ),
                          SmartSystem(
                            color: Colors.lightGreen,
                            index: 1,
                            title: roomData[0].app2,
                            imageUrl:
                            'assets/images/icons8-rgb-lamp-96.png',
                            isToggle: state1,
                            onToggleTap: () {
                              state1 = !state1;
                              var status = 0;
                              if(!state0 && !state1 && !state2 && !state3) {status = 0;}
                              else if(state0 && !state1 && !state2 && !state3) {status = 1;}
                              else if(!state0 && state1 && !state2 && !state3) {status = 2;}
                              else if(!state0 && !state1 && state2 && !state3) {status = 3;}
                              else if(!state0 && !state1 && !state2 && state3) {status = 4;}
                              else if(state0 && state1 && !state2 && !state3) {status = 5;}
                              else if(state0 && !state1 && state2 && !state3) {status = 6;}
                              else if(state0 && !state1 && !state2 && state3) {status = 7;}
                              else if(state0 && state1 && state2 && !state3) {status = 8;}
                              else if(state0 && state1 && !state2 && state3) {status = 9;}
                              else if(state0 && !state1 && state2 && state3) {status = 10;}
                              else if(state0 && state1 && state2 && state3) {status = 11;}
                              else if(!state0 && state1 && state2 && !state3) {status = 12;}
                              else if(!state0 && state1 && !state2 && state3) {status = 13;}
                              else if(!state0 && state1 && state2 && state3) {status = 14;}
                              else if(!state0 && !state1 && state2 && state3) {status = 15;}
                              FirebaseDatabase.instance.ref().child("SerialNumbers").child(selectedRoomSerial).update({
                                "Relay": status,
                              });
                            },
                            onTap: () {

                            },
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * 0.01),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SmartSystem(
                            color: Colors.yellow,
                            index: 2,
                            title: roomData[0].app3,
                            imageUrl:
                            'assets/images/icons8-music-record-96.png',
                            isToggle: state2,
                            onToggleTap: () {
                              state2 = !state2;
                              var status = 0;
                              if(!state0 && !state1 && !state2 && !state3) {status = 0;}
                              else if(state0 && !state1 && !state2 && !state3) {status = 1;}
                              else if(!state0 && state1 && !state2 && !state3) {status = 2;}
                              else if(!state0 && !state1 && state2 && !state3) {status = 3;}
                              else if(!state0 && !state1 && !state2 && state3) {status = 4;}
                              else if(state0 && state1 && !state2 && !state3) {status = 5;}
                              else if(state0 && !state1 && state2 && !state3) {status = 6;}
                              else if(state0 && !state1 && !state2 && state3) {status = 7;}
                              else if(state0 && state1 && state2 && !state3) {status = 8;}
                              else if(state0 && state1 && !state2 && state3) {status = 9;}
                              else if(state0 && !state1 && state2 && state3) {status = 10;}
                              else if(state0 && state1 && state2 && state3) {status = 11;}
                              else if(!state0 && state1 && state2 && !state3) {status = 12;}
                              else if(!state0 && state1 && !state2 && state3) {status = 13;}
                              else if(!state0 && state1 && state2 && state3) {status = 14;}
                              else if(!state0 && !state1 && state2 && state3) {status = 15;}
                              FirebaseDatabase.instance.ref().child("SerialNumbers").child(selectedRoomSerial).update({
                                "Relay": status,
                              });
                            },
                            onTap: () {

                            },
                          ),
                          SmartSystem(
                            color: Colors.redAccent,
                            index: 3,
                            title: roomData[0].app4,
                            imageUrl: 'assets/images/icons8-light-96.png',
                            isToggle: state3,
                            onToggleTap: () {
                              state3 = !state3;

                              var status = 0;

                              if(!state0 && !state1 && !state2 && !state3) {status = 0;}
                              else if(state0 && !state1 && !state2 && !state3) {status = 1;}
                              else if(!state0 && state1 && !state2 && !state3) {status = 2;}
                              else if(!state0 && !state1 && state2 && !state3) {status = 3;}
                              else if(!state0 && !state1 && !state2 && state3) {status = 4;}
                              else if(state0 && state1 && !state2 && !state3) {status = 5;}
                              else if(state0 && !state1 && state2 && !state3) {status = 6;}
                              else if(state0 && !state1 && !state2 && state3) {status = 7;}
                              else if(state0 && state1 && state2 && !state3) {status = 8;}
                              else if(state0 && state1 && !state2 && state3) {status = 9;}
                              else if(state0 && !state1 && state2 && state3) {status = 10;}
                              else if(state0 && state1 && state2 && state3) {status = 11;}
                              else if(!state0 && state1 && state2 && !state3) {status = 12;}
                              else if(!state0 && state1 && !state2 && state3) {status = 13;}
                              else if(!state0 && state1 && state2 && state3) {status = 14;}
                              else if(!state0 && !state1 && state2 && state3) {status = 15;}

                              FirebaseDatabase.instance.ref().child("SerialNumbers").child(selectedRoomSerial).update({
                                "Relay": status,
                              });

                            },
                            onTap: () {

                            },
                          ),
                        ],
                      ),
                    ],
                  );
                  } else {
                    return CircularProgressIndicator();
                  }
                  }
            ),
            SizedBox(height: size.height * 0.15),
      ],
       ),
        ),
          ),
      ),
    ],
    ),
    );


  }
  }




