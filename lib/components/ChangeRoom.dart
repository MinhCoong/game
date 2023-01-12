// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, use_build_context_synchronously

import 'dart:async';
import 'dart:math';

import 'package:dc_marvel_app/components/FrameEx.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'ShowDialogCreateRoom.dart';

class ChangeRoom extends StatefulWidget {
  const ChangeRoom({super.key});

  @override
  State<ChangeRoom> createState() => _ChangeRoomState();
}

class _ChangeRoomState extends State<ChangeRoom> {
  TextEditingController roomId = TextEditingController();
  TextEditingController user = TextEditingController();
  TextEditingController frameRank = TextEditingController();
  TextEditingController rank = TextEditingController();
  TextEditingController image = TextEditingController();
  final _db = FirebaseDatabase.instance.ref();
  final _auth = FirebaseAuth.instance;
  late StreamSubscription _subscription;

  @override
  void initState() {
    super.initState();
    _activateListeners();
  }

  void _activateListeners() {
    _subscription =
        _db.child('members/${_auth.currentUser!.uid}').onValue.listen((event) {
      final data = event.snapshot.value as dynamic;
      setState(() {
        user.text = data['userName'].toString();
        frameRank.text = data['frameRank'].toString();
        rank.text = data['rank'].toString();
        image.text = data['image'].toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(.8),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width / 2,
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              image: AssetImage("assets/images/FrameTitle.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.logout),
                      color: Colors.white,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      onPressed: () async {
                        var RoomKey = Random().nextInt(8999) + 1000;

                        final nextMember = <String, dynamic>{
                          'key': RoomKey,
                          'playerOne': {
                            'key': true,
                            'userName': user.text,
                            'image': image.text,
                            'rank': frameRank.text,
                            'highScore': 0,
                          },
                          'playerTwo': {
                            'userName': "",
                            'image': "",
                            'rank': "",
                            'highScore': 0,
                          },
                          'status': false,
                          'statusEnd': false,
                          'time': DateTime.now().millisecondsSinceEpoch,
                        };
                        _db.child('rooms/$RoomKey').set(nextMember);
                        Navigator.pop(context);
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            opaque: false,
                            pageBuilder: (BuildContext context, _, __) =>
                                ShowDialogCreateRoom(
                              roomId: RoomKey.toString(),
                            ),
                          ),
                        );
                      },
                      child: Text("Create Room"),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  height: 55,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.white),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      SizedBox(
                          width: 25,
                          child: Text(
                            'ID',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          )),
                      Text(
                        "|",
                        style: TextStyle(fontSize: 33, color: Colors.grey),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: TextField(
                          style: TextStyle(color: Colors.white),
                          onChanged: (value) => roomId.text = value,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "change id room",
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    onPressed: () async {
                      final getRoom =
                          await _db.child('rooms/${roomId.text}/key').get();
                      final getPlayerTwo = await _db
                          .child('rooms/${roomId.text}/playerTwo/userName')
                          .get();

                      if (roomId.text.isNotEmpty && getRoom.exists) {
                        if (getPlayerTwo.value.toString() == "") {
                          _db.child('rooms/${roomId.text}/playerTwo').update({
                            'userName': user.text,
                            'image': image.text,
                            'rank': frameRank.text,
                            'statusClose': false,
                            'statusStart': true
                          });

                          Navigator.pop(context);
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              opaque: false,
                              pageBuilder: (BuildContext context, _, __) =>
                                  ShowDialogCreateRoom(
                                roomId: roomId.text.toString(),
                              ),
                            ),
                          );
                        } else {
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              opaque: false,
                              pageBuilder: (BuildContext context, _, __) =>
                                  FrameEx(Ex: "Room is full"),
                            ),
                          );
                        }
                      } else {
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            opaque: false,
                            pageBuilder: (BuildContext context, _, __) =>
                                FrameEx(Ex: "Room ID does not exist"),
                          ),
                        );
                      }
                    },
                    child: Text("Let's go"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void deactivate() {
    _subscription.cancel();
    super.deactivate();
  }
}
