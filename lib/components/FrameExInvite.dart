// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

import 'FrameEx.dart';
import 'ShowDialogCreateRoom.dart';

class FrameExInvite extends StatefulWidget {
  const FrameExInvite({
    Key? key,
  }) : super(key: key);

  @override
  State<FrameExInvite> createState() => _FrameExInviteState();
}

class _FrameExInviteState extends State<FrameExInvite> {
  final userName = TextEditingController();
  final userImage = TextEditingController();
  final userFrameRank = TextEditingController();
  final roomId = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseDatabase.instance.ref();

  late StreamSubscription _getUser;

  @override
  void initState() {
    super.initState();
    _getMember();
  }

  void _getMember() {
    _getUser =
        _db.child('members/${_auth.currentUser!.uid}').onValue.listen((event) {
      final data = event.snapshot.value as dynamic;
      setState(() {
        roomId.text = data['roomId'].toString();
        userName.text = data['userName'].toString();
        userImage.text = data['image'].toString();
        userFrameRank.text = data['frameRank'].toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: WidgetAnimator(
          incomingEffect: WidgetTransitionEffects.incomingScaleDown(),
          child: Container(
            width: MediaQuery.of(context).size.width - 50,
            height: MediaQuery.of(context).size.height / 4,
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: const DecorationImage(
                image: AssetImage("assets/images/frameEx.png"),
              ),
            ),
            child: Column(
              children: [
                const Expanded(
                  child: Text(
                    'Notify',
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                ),
                const Expanded(
                  flex: 4,
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        'The player invites you to the match',
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        onPressed: () {
                          _db
                              .child(
                                  'members/${_auth.currentUser!.uid}/statusInvite')
                              .set(false);
                        },
                        child: const Text('Disagree'),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        onPressed: () async {
                          final getPlayerTwo = await _db
                              .child('rooms/${roomId.text}/playerTwo/userName')
                              .get();

                          if (getPlayerTwo.value.toString() == "") {
                            _db.child('rooms/${roomId.text}/playerTwo').update({
                              'userName': userName.text,
                              'image': userImage.text,
                              'rank': userFrameRank.text,
                              'statusClose': false,
                              'statusStart': true
                            });

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
                                    const FrameEx(Ex: "Room is full"),
                              ),
                            );
                          }
                          _db
                              .child(
                                  'members/${_auth.currentUser!.uid}/statusInvite')
                              .set(false);
                        },
                        child: const Text('Agree'),
                      ),
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

  @override
  void deactivate() {
    _getUser.cancel();
    super.deactivate();
  }
}
