// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers, use_build_context_synchronously
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'PlayerRoom.dart';

class ReportBattleRank extends StatefulWidget {
  const ReportBattleRank(
      {super.key,
      required this.roomId,
      required this.highScoreOne,
      required this.highScoreTwo});
  final String roomId;
  final int highScoreOne;
  final int highScoreTwo;

  @override
  State<ReportBattleRank> createState() => _ReportBattleRankState();
}

class _ReportBattleRankState extends State<ReportBattleRank> {
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
  // late StreamSubscription _getEnd;

  @override
  void initState() {
    super.initState();
    _getPlayerTwo();
    _getPlayerOne();
    _getStatus();
  }

  void _getPlayerTwo() {
    _subscription = _database
        .child('battle/${widget.roomId}/playerTwo')
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
        .child('battle/${widget.roomId}/playerOne')
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

  void _getStatus() {
    _getStart = _database.child('battle/${widget.roomId}').onValue.listen(
      (event) {
        final data = event.snapshot.value as dynamic;
        setState(
          () {
            if (data['statusEnd'].toString() == 'true') {
              Navigator.pop(context);
              Timer(
                const Duration(seconds: 1),
                () {
                  _database.child('battle/${widget.roomId}').remove();
                },
              );
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(.8),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 2.6,
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              image: AssetImage("assets/images/FrameTitle.png"),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'REPORT BATTLE RANK',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      letterSpacing: 2.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
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
                      final history = await _database
                          .child('historys/${auth.currentUser!.uid}')
                          .get();
                      final report =
                          history.children.last.child('report').value;
                      final upRankUser = await _database
                          .child('members/${auth.currentUser!.uid}/rank')
                          .get();
                      final upStarRankUser = await _database
                          .child('members/${auth.currentUser!.uid}/starRank')
                          .get();
                      int setRank = int.parse(upRankUser.value.toString());
                      int starRank = int.parse(upStarRankUser.value.toString());
                      Navigator.pop(context);
                      Timer(
                        const Duration(seconds: 1),
                        () async {
                          if (setRank > 1 && setRank < 27) {
                            report.toString() == "win"
                                ? _database
                                    .child(
                                        'members/${auth.currentUser!.uid}/rank')
                                    .set(setRank + 1)
                                : _database
                                    .child(
                                        'members/${auth.currentUser!.uid}/rank')
                                    .set(setRank - 1);
                            final rankNow = await _database
                                .child('members/${auth.currentUser!.uid}/rank')
                                .get();
                            Timer(const Duration(seconds: 1), () {
                              if (int.parse(rankNow.value.toString()) < 7) {
                                _database
                                    .child(
                                        'members/${auth.currentUser!.uid}/frameRank')
                                    .set(1);
                              } else if (int.parse(rankNow.value.toString()) <
                                  17) {
                                _database
                                    .child(
                                        'members/${auth.currentUser!.uid}/frameRank')
                                    .set(2);
                              } else if (int.parse(rankNow.value.toString()) <
                                  27) {
                                _database
                                    .child(
                                        'members/${auth.currentUser!.uid}/frameRank')
                                    .set(3);
                              } else {
                                _database
                                    .child(
                                        'members/${auth.currentUser!.uid}/frameRank')
                                    .set(4);
                              }
                            });
                          } else {
                            if (report.toString() == "win") {
                              _database
                                  .child(
                                      'members/${auth.currentUser!.uid}/starRank')
                                  .set(starRank + 1);
                            } else {
                              if (starRank != 0) {
                                _database
                                    .child(
                                        'members/${auth.currentUser!.uid}/starRank')
                                    .set(starRank - 1);
                              } else {
                                _database
                                    .child(
                                        'members/${auth.currentUser!.uid}/rank')
                                    .set(setRank - 1);
                                _database
                                    .child(
                                        'members/${auth.currentUser!.uid}/frameRank')
                                    .set(3);
                              }
                            }
                          }
                        },
                      );

                      Timer(
                        const Duration(minutes: 1),
                        () {
                          _database.child('battle/${widget.roomId}').remove();
                        },
                      );
                    },
                    child: Text("Back to rank"),
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
    // _getEnd.cancel();
    super.deactivate();
  }
}
