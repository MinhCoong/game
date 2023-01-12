// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names

import 'dart:async';
import 'dart:math';
import 'package:dc_marvel_app/view/play/FindBattle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class PlayBattle extends StatefulWidget {
  const PlayBattle({super.key});

  @override
  State<PlayBattle> createState() => PlayBattleState();
}

class PlayBattleState extends State<PlayBattle> {
  TextEditingController roomId = TextEditingController();
  TextEditingController user = TextEditingController();
  TextEditingController rank = TextEditingController();
  TextEditingController image = TextEditingController();
  TextEditingController starRank = TextEditingController();
  final _rank = TextEditingController();
  final _roomID = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseDatabase.instance.ref();
  late StreamSubscription _getRank, _getUser;

  @override
  void initState() {
    super.initState();
    getRank();
    // _getStatus();
    _getPlayger();
  }

  void _getPlayger() {
    _getUser =
        _db.child('members/${_auth.currentUser!.uid}').onValue.listen((event) {
      final data = event.snapshot.value as dynamic;
      setState(() {
        user.text = data['userName'].toString();
        rank.text = data['frameRank'].toString();
        image.text = data['image'].toString();
        starRank.text = data['starRank'].toString();
      });
    });
  }

  void getRank() {
    _getRank =
        _db.child('members/${_auth.currentUser!.uid}').onValue.listen((event) {
      final data = event.snapshot.value as dynamic;
      setState(() {
        _rank.text = data['rank'].toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(.9),
      body: SizedBox(
        // padding: const EdgeInsets.all(15),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Stack(
                children: [
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/FrameTitle.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: const Text(
                      'Battle',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontFamily: 'Horizon',
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    alignment: Alignment.topRight,
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.logout_rounded,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: Column(
                children: [
                  Expanded(
                    flex: 8,
                    child: Container(
                      margin: const EdgeInsets.all(30.0),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            _rank.text == ""
                                ? "assets/images/rank1.png"
                                : "assets/images/rank${_rank.text}.png",
                          ),
                          // fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: starRank.text != '0'
                        ? Container(
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image:
                                    AssetImage('assets/images/FrameStar.png'),
                                // fit: BoxFit.fill,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 24,
                                ),
                                Text(
                                  'x${starRank.text}',
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                              ],
                            ),
                          )
                        : Container(),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Center(
                child: Container(
                  height: 80,
                  width: 200,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/ButtonPlaynow.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: TextButton(
                    onPressed: () async {
                      final snapshot = await _db.child('battle').get();
                      final rankPlayger = await _db
                          .child('members/${_auth.currentUser!.uid}/frameRank')
                          .get();
                      List lstRooms = [];
                      if (snapshot.children.isNotEmpty) {
                        for (int i = 0; i < snapshot.children.length; i++) {
                          final getName = snapshot.children
                              .elementAt(i)
                              .child('playerTwo/userName');
                          final getRank = snapshot.children
                              .elementAt(i)
                              .child('playerOne/rank');
                          if (getName.value == "" &&
                              rankPlayger.value.toString() ==
                                  getRank.value.toString()) {
                            lstRooms.add(
                                snapshot.children.elementAt(i).key.toString());
                          }
                        }
                      }
                      if (lstRooms.isEmpty) {
                        var RoomKey = Random().nextInt(8999) + 1000;
                        setState(() {
                          _roomID.text = RoomKey.toString();
                        });
                        final nextMember = <String, dynamic>{
                          'key': RoomKey,
                          'playerOne': {
                            'userName': user.text,
                            'image': image.text,
                            'rank': rank.text,
                            'highScore': 0,
                            'status': false
                          },
                          'playerTwo': {
                            'userName': "",
                            'image': "",
                            'rank': "",
                            'highScore': 0,
                            'status': false
                          },
                          'status': false,
                          'statusEnd': false,
                          'time': DateTime.now().millisecondsSinceEpoch,
                        };
                        _db.child('battle/$RoomKey').set(nextMember);
                      } else {
                        setState(() {
                          _roomID.text = lstRooms[0];
                        });
                        _db.child('battle/${lstRooms[0]}/playerTwo').update({
                          'userName': user.text,
                          'image': image.text,
                          'rank': rank.text
                        });
                        _db.child('battle/${lstRooms[0]}/status').set(true);
                      }
                      // Navigator.pop(context);
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          opaque: false,
                          pageBuilder: (BuildContext context, _, __) =>
                              FindBattle(
                            roomId: _roomID.text,
                          ),
                        ),
                      );
                    },
                    child: const Center(
                      child: Text(
                        'PLAY',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                          fontFamily: 'Horizon',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void deactivate() {
    _getRank.cancel();
    _getUser.cancel();
    super.deactivate();
  }
}
