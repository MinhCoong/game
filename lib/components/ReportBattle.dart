// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers
import 'dart:async';
import 'package:dc_marvel_app/components/PlayBattleRoom.dart';
import 'package:dc_marvel_app/view/play/playing_battle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../view/play/PlayBattleLoad.dart';
import 'PlayerRoom.dart';
import 'ShowDialogCreateRoom.dart';

class ReportBattle extends StatefulWidget {
  const ReportBattle(
      {super.key,
      required this.roomId,
      required this.highScoreOne,
      required this.highScoreTwo});
  final String roomId;
  final int highScoreOne;
  final int highScoreTwo;

  @override
  State<ReportBattle> createState() => _ReportBattleState();
}

class _ReportBattleState extends State<ReportBattle> {
  TextEditingController keyUser = TextEditingController();
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
  late StreamSubscription _getKeyUser;

  @override
  void initState() {
    super.initState();
    _getPlayerTwo();
    _getPlayerOne();
    _getUserKey();
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

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(.8),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 3,
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      widget.highScoreOne > widget.highScoreTwo
                          ? 'assets/images/iconwin.png'
                          : 'assets/images/iconlose.png',
                      width: MediaQuery.of(context).size.width / 4.5,
                    ),
                    Image.asset(
                      widget.highScoreOne > widget.highScoreTwo
                          ? 'assets/images/iconlose.png'
                          : 'assets/images/iconwin.png',
                      width: MediaQuery.of(context).size.width / 4.5,
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
                        PlayerRoom(
                          pathFrameRank: frameRankUserOne.text,
                          size: size,
                          path: userImageOne.text == ""
                              ? 'assets/images/iconAddfriend.png'
                              : 'assets/images/AvatarChibi${userImageOne.text}.jpg',
                        ),
                        Text(
                          userOne.text,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: MediaQuery.of(context).size.height / 45,
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
                        PlayerRoom(
                          size: size,
                          path: userImageTwo.text == ""
                              ? 'assets/images/iconAddfriend.png'
                              : 'assets/images/AvatarChibi${userImageTwo.text}.jpg',
                          pathFrameRank: frameRankUserTwo.text,
                        ),
                        Text(
                          userTwo.text,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: MediaQuery.of(context).size.height / 45,
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
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    onPressed: () async {
                      if (keyUser.text == userTwo.text) {
                        _database
                            .child(
                                'rooms/${widget.roomId}/playerTwo/statusStart')
                            .set(true);
                      }
                      Navigator.pop(context);
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          opaque: false,
                          pageBuilder: (BuildContext context, _, __) =>
                              ShowDialogCreateRoom(
                            roomId: widget.roomId,
                          ),
                        ),
                      );
                    },
                    child: Text("Back to room"),
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
    _getKeyUser.cancel();
    super.deactivate();
  }
}
