import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../view/play/PlayBattleLoad.dart';
import 'PlayerRoom.dart';

class ShowDialogFindBattle extends StatefulWidget {
  const ShowDialogFindBattle({super.key, required this.roomId});
  final String roomId;

  @override
  State<ShowDialogFindBattle> createState() => _ShowDialogFindBattleState();
}

class _ShowDialogFindBattleState extends State<ShowDialogFindBattle> {
  TextEditingController userTwo = TextEditingController();
  TextEditingController userOne = TextEditingController();
  TextEditingController frameRankUserOne = TextEditingController();
  TextEditingController frameRankUserTwo = TextEditingController();
  TextEditingController userImageOne = TextEditingController();
  TextEditingController userImageTwo = TextEditingController();
  TextEditingController statusOne = TextEditingController();
  TextEditingController statusTwo = TextEditingController();
  TextEditingController userKey = TextEditingController();
  bool isReadyGo = false;

  int timeDown = 15;
  Timer? _timer;

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
    _timerDown();
  }

  void _getUserKey() {
    _getKeyUser = _database
        .child('members/${auth.currentUser!.uid}')
        .onValue
        .listen((event) {
      final data = event.snapshot.value as dynamic;
      setState(() {
        userKey.text = data['userName'].toString();
      });
    });
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
        statusTwo.text = data['status'].toString();
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
        statusOne.text = data['status'].toString();
      });
    });
  }

  void _timerDown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (timeDown != 0) {
        setState(() {
          --timeDown;
          if (statusOne.text == 'true' && statusTwo.text == 'true') {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    PlayBattleGame(urlRef: 'battle', roomID: widget.roomId),
              ),
            );
          }
        });
      } else {
        Navigator.pop(context);
        Timer.periodic(const Duration(seconds: 2), (timer) async {
          _database.child('battle/${widget.roomId}').remove();
        });
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(.7),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 3,
          padding: const EdgeInsets.all(10.0),
          decoration: const BoxDecoration(
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
                    timeDown.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      letterSpacing: 2.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
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
                          size: MediaQuery.of(context).size,
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
                        decoration: const BoxDecoration(
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
                          size: MediaQuery.of(context).size,
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
                      backgroundColor:
                          isReadyGo == false ? Colors.red : Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        isReadyGo = true;
                      });
                      userKey.text == userOne.text
                          ? _database
                              .child('battle/${widget.roomId}/playerOne/status')
                              .set(true)
                          : _database
                              .child('battle/${widget.roomId}/playerTwo/status')
                              .set(true);
                    },
                    child: const Text("Ready go"),
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
    _timer?.cancel();
    _getKeyUser.cancel();
    super.deactivate();
  }
}
