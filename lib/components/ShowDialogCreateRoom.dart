// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers
import 'dart:async';
import 'package:dc_marvel_app/components/FrameEx.dart';
import 'package:dc_marvel_app/components/InviteFriend.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../view/play/PlayBattleLoad.dart';
import 'PlayerRoom.dart';

class ShowDialogCreateRoom extends StatefulWidget {
  const ShowDialogCreateRoom({super.key, required this.roomId});
  final String roomId;

  @override
  State<ShowDialogCreateRoom> createState() => _ShowDialogCreateRoomState();
}

class _ShowDialogCreateRoomState extends State<ShowDialogCreateRoom> {
  TextEditingController keyUser = TextEditingController();
  TextEditingController statusClose = TextEditingController();
  TextEditingController statusPlayerTowStart = TextEditingController();
  TextEditingController userTwo = TextEditingController();
  TextEditingController userOne = TextEditingController();
  TextEditingController status = TextEditingController();
  TextEditingController frameRankUserOne = TextEditingController();
  TextEditingController frameRankUserTwo = TextEditingController();
  TextEditingController userImageOne = TextEditingController();
  TextEditingController userImageTwo = TextEditingController();

  final auth = FirebaseAuth.instance;
  final _database = FirebaseDatabase.instance.ref();
  late StreamSubscription _subscription;
  late StreamSubscription _getRoom;
  late StreamSubscription _getStart;
  late StreamSubscription _getKeyUser;
  late StreamSubscription _getStatusClose;

  @override
  void initState() {
    super.initState();
    _getPlayerTwo();
    _getPlayerOne();
    _getStatus();
    _getUserKey();
    _getCloseStatus();
  }

  void _getUserKey() {
    _getKeyUser = _database
        .child('members/${auth.currentUser!.uid}')
        .onValue
        .listen((event) {
      final data = event.snapshot.value as dynamic;
      setState(() {
        keyUser.text = data['userName'].toString();
      });
    });
  }

  void _getPlayerTwo() {
    _subscription = _database
        .child('rooms/${widget.roomId}/playerTwo')
        .onValue
        .listen((event) {
      final data = event.snapshot.value as dynamic;
      setState(() {
        userTwo.text = data['userName'].toString();
        userImageTwo.text = data['image'].toString();
        frameRankUserTwo.text = data['rank'].toString();
        statusClose.text = data['statusClose'].toString();
        statusPlayerTowStart.text = data['statusStart'].toString();
      });
    });
  }

  void _getPlayerOne() {
    _getRoom = _database
        .child('rooms/${widget.roomId}/playerOne')
        .onValue
        .listen((event) {
      final data = event.snapshot.value as dynamic;
      setState(() {
        userOne.text = data['userName'].toString();
        userImageOne.text = data['image'].toString();
        frameRankUserOne.text = data['rank'].toString();
      });
    });
  }

  void _getCloseStatus() {
    _getStatusClose =
        _database.child('rooms/${widget.roomId}/playerTwo').onValue.listen(
      (event) {
        final data = event.snapshot.value as dynamic;
        setState(
          () {
            if (data['statusClose'].toString() == 'true' &&
                keyUser.text == userTwo.text) {
              Navigator.pop(context);
              _database.child('rooms/${widget.roomId}/playerTwo').update({
                'userName': "",
                'image': "",
                'rank': "",
                'statusClose': false
              });
            }
          },
        );
      },
    );
  }

  void _getStatus() {
    _getStart =
        _database.child('rooms/${widget.roomId}').onValue.listen((event) {
      final data = event.snapshot.value as dynamic;
      setState(
        () {
          if (data['status'].toString() == 'true') {
            Timer(
              Duration(seconds: 3),
              () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PlayBattleGame(
                      urlRef: 'rooms',
                      roomID: widget.roomId,
                    ),
                  ),
                );
                _database.child('rooms/${widget.roomId}/status').set(false);
                _database
                    .child('rooms/${widget.roomId}/playerTwo/statusStart')
                    .set(false);
              },
            );
          }
          if (data['statusEnd'].toString() == 'true') {
            Navigator.pop(context);
            Timer(
              const Duration(seconds: 1),
              () {
                _database.child('rooms/${widget.roomId}').remove();
              },
            );
          }
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(.6),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width / 1.5,
          padding: const EdgeInsets.all(10.0),
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
                flex: 1,
                child: Row(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        onPressed: () async {
                          Navigator.pop(context);
                          final getPlayerTwo = await _database
                              .child(
                                  'members/${auth.currentUser!.uid}/userName')
                              .get();
                          if (userTwo.text == getPlayerTwo.value.toString()) {
                            Timer(
                              const Duration(milliseconds: 100),
                              () {
                                _database
                                    .child('rooms/${widget.roomId}/playerTwo')
                                    .update({
                                  'userName': "",
                                  'image': "",
                                  'rank': ""
                                });
                              },
                            );
                          } else {
                            Timer(
                              const Duration(milliseconds: 100),
                              () {
                                _database
                                    .child('rooms/${widget.roomId}/playerTwo')
                                    .update({
                                  'userName': "",
                                  'image': "",
                                  'rank': "",
                                  'statusClose': false
                                });
                                _database
                                    .child('rooms/${widget.roomId}/playerOne')
                                    .update({
                                  'userName': userTwo.text,
                                  'image': userImageTwo.text,
                                  'rank': frameRankUserTwo.text
                                });
                              },
                            );
                          }
                          Timer(const Duration(seconds: 1), () async {
                            final playerOne = await _database
                                .child(
                                    'rooms/${widget.roomId}/playerOne/userName')
                                .get();
                            if (playerOne.value.toString() == "") {
                              _database
                                  .child('rooms/${widget.roomId}')
                                  .remove();
                            }
                          });
                        },
                        icon: Icon(Icons.logout),
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'CREATE ROOM',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              letterSpacing: 2.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'ID: ${widget.roomId}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              letterSpacing: 2.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Stack(
                          alignment: Alignment.topRight,
                          children: [
                            PlayerRoom(
                              pathFrameRank: frameRankUserOne.text,
                              size: size,
                              path: userImageOne.text == ""
                                  ? 'assets/images/iconAddfriend.png'
                                  : 'assets/images/AvatarChibi${userImageOne.text}.jpg',
                            ),
                            Image.asset(
                              'assets/images/iconking.png',
                              width: size.width / 13,
                              height: size.width / 13,
                            ),
                          ],
                        ),
                        Text(
                          userOne.text,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/vsbattle.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Stack(
                          alignment: Alignment.topRight,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  PageRouteBuilder(
                                    opaque: false,
                                    pageBuilder:
                                        (BuildContext context, _, __) =>
                                            InviteFriend(
                                      roomId: widget.roomId,
                                    ),
                                  ),
                                );
                              },
                              child: PlayerRoom(
                                size: size,
                                path: userImageTwo.text == ""
                                    ? 'assets/images/iconAddfriend.png'
                                    : 'assets/images/AvatarChibi${userImageTwo.text}.jpg',
                                pathFrameRank: frameRankUserTwo.text,
                              ),
                            ),
                            userOne.text == keyUser.text && userTwo.text != ""
                                ? InkWell(
                                    onTap: () {
                                      _database
                                          .child(
                                              'rooms/${widget.roomId}/playerTwo/statusClose')
                                          .set(true);
                                    },
                                    child: Image.asset(
                                      'assets/images/IconClose.png',
                                      width: MediaQuery.of(context).size.width /
                                          20,
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                        Text(
                          userTwo.text,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 9.0, bottom: 9.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: userOne.text == keyUser.text
                          ? Colors.red
                          : Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    onPressed: () async {
                      if (userTwo.text != "") {
                        if (userOne.text == keyUser.text) {
                          if (statusPlayerTowStart.text == "true") {
                            _database
                                .child('rooms/${widget.roomId}/status')
                                .set(true);
                          } else {
                            Navigator.of(context).push(
                              PageRouteBuilder(
                                opaque: false,
                                pageBuilder: (BuildContext context, _, __) =>
                                    FrameEx(
                                        Ex: "Players who are still summarizing cannot start"),
                              ),
                            );
                          }
                        } else {
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              opaque: false,
                              pageBuilder: (BuildContext context, _, __) =>
                                  FrameEx(Ex: "You are not the room owner"),
                            ),
                          );
                        }
                      } else {
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            opaque: false,
                            pageBuilder: (BuildContext context, _, __) =>
                                FrameEx(Ex: "The room is not full of players"),
                          ),
                        );
                      }
                    },
                    child: Text("Play Now"),
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
    _getRoom.cancel();
    _getStart.cancel();
    _getKeyUser.cancel();
    _getStatusClose.cancel();
    super.deactivate();
  }
}
