// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'package:dc_marvel_app/view/play/PlayBattleLoad.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../components/PlayerRoom.dart';
import '../../components/ShowDialogFindBattle.dart';

class FindBattle extends StatefulWidget {
  const FindBattle({super.key, required this.roomId});
  final String roomId;

  @override
  State<FindBattle> createState() => _FindBattleState();
}

class _FindBattleState extends State<FindBattle> {
  final txtFrameRank = TextEditingController();
  final txtImage = TextEditingController();
  final _db = FirebaseDatabase.instance.ref();
  final _auth = FirebaseAuth.instance;
  int timers = 0;
  Timer? _timer;

  late StreamSubscription _getMember, _getStart;

  @override
  void initState() {
    super.initState();
    _getStatus();
    _getPlayer();
    _getNextQuestion();
  }

  void _getPlayer() {
    _getMember =
        _db.child('members/${_auth.currentUser!.uid}').onValue.listen((event) {
      final data = event.snapshot.value as dynamic;
      setState(() {
        txtFrameRank.text = data['frameRank'].toString();
        txtImage.text = data['image'].toString();
      });
    });
  }

  void _getNextQuestion() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      setState(() {
        timers++;
      });
    });
  }

  void _getStatus() {
    _getStart = _db.child('battle/${widget.roomId}').onValue.listen(
      (event) {
        final data = event.snapshot.value as dynamic;
        setState(
          () {
            if (data['status'].toString() == 'true') {
              Timer(
                const Duration(seconds: 1),
                () {
                  Navigator.pop(context);
                  Navigator.of(context).push(PageRouteBuilder(
                    opaque: false,
                    pageBuilder: (BuildContext context, _, __) =>
                        ShowDialogFindBattle(roomId: widget.roomId),
                  ));
                },
              );
            }
            if (data['statusEnd'].toString() == 'true') {
              Navigator.pop(context);
              Timer(
                const Duration(seconds: 1),
                () {
                  _db.child('battle/${widget.roomId}').remove();
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
    return Scaffold(
        backgroundColor: Colors.black.withOpacity(0.7),
        body: Center(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width / 2,
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              image: const DecorationImage(
                image: AssetImage("assets/images/FrameTitle.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    const Text(
                      'FIND BATTLE',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        letterSpacing: 2.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        onPressed: () {
                          // Navigator.pop(context);

                          _db
                              .child('battle/${widget.roomId}/statusEnd')
                              .set(true);
                        },
                        icon: const Icon(
                          Icons.logout,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
                PlayerRoom(
                  pathFrameRank: txtFrameRank.text,
                  size: MediaQuery.of(context).size,
                  path: txtImage.text == ""
                      ? 'assets/images/iconAddfriend.png'
                      : 'assets/images/AvatarChibi${txtImage.text}.jpg',
                ),
                Text(
                  timers.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  @override
  void deactivate() {
    _getStart.cancel();
    _getMember.cancel();
    _timer!.cancel();
    super.deactivate();
  }
}
