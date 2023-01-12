import 'dart:async';

import 'package:dc_marvel_app/view/play/play_even.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'BonusFrameItem.dart';
import 'FrameEx.dart';

class FrameEven extends StatefulWidget {
  const FrameEven({
    Key? key,
    required this.pathItemOne,
    required this.pathItemTwo,
    required this.pathFrame,
    required this.num,
  }) : super(key: key);

  final String pathFrame;
  final String pathItemOne;
  final String pathItemTwo;
  final int num;

  @override
  State<FrameEven> createState() => _FrameEvenState();
}

class _FrameEvenState extends State<FrameEven> {
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseDatabase.instance.ref();
  late StreamSubscription _useLevel;
  int level = 1;
  int hightScore = 0;
  int chapter = 1;
  int exp = 0;
  int diamond = 0;
  int energy = 0;
  int thor = 0;
  int spider = 0;
  int bat = 0;
  int shiled = 0;
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    _userLevel();
  }

  //Get lever user
  void _userLevel() {
    _useLevel =
        _db.child('members/${_auth.currentUser!.uid}').onValue.listen((event) {
      final data = event.snapshot.value as dynamic;
      final hSc =
          event.snapshot.child('highScoreChapter').value as List<dynamic>;
      if (mounted) {
        setState(() {
          level = data['level'];
          exp = data['exp'];
          diamond = data['diamond'];
          energy = data['energy'];
          hightScore = hSc[chapter];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 50,
      height: MediaQuery.of(context).size.width + 50,
      margin: const EdgeInsets.only(top: 15, bottom: 15),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(widget.pathFrame),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Expanded(
            flex: 10,
            child: Text(''),
          ),
          Expanded(
            flex: 1,
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 1.5,
              child: const Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Giải thưởng',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              margin: const EdgeInsets.only(top: 10, bottom: 10),
              width: MediaQuery.of(context).size.width / 1.5,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(.5),
                borderRadius: const BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BonusFrameItem(path: widget.pathItemOne),
                  BonusFrameItem(path: widget.pathItemTwo),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: InkWell(
              onTap: () {
                if (energy > 1) {
                  if (_db.child('members').child(_auth.currentUser!.uid).key !=
                      null) {
                    final energy1 = <String, dynamic>{'energy': energy -= 5};
                    _db
                        .child('members/${_auth.currentUser!.uid}')
                        .update(energy1)
                        .then((_) => print('update Spider successful'))
                        .catchError(
                            (error) => print('You got an error $error'));
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PlayingEven(
                        num: widget.num,
                        level: level,
                        diamond: diamond,
                        exp: exp,
                        hightScore: hightScore,
                        energy: energy,
                        //chapter: 11,
                      ),
                    ),
                  );
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const FrameEx(Ex: 'Energy is not enought')));
                }
              },
              child: Container(
                width: MediaQuery.of(context).size.width / 2,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/ButonSetting.png'),
                    fit: BoxFit.fill,
                  ),
                ),
                child: const Center(
                  child: Text(
                    'PLAY',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.5,
                      fontFamily: 'Horizon',
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              margin: const EdgeInsets.only(top: 10),
              width: MediaQuery.of(context).size.width / 1.5,
              child: const Text(
                "Thử thách vô tận, bứt phá giới hạn của bạn.",
                style: TextStyle(color: Colors.white, fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void deactivate() {
    _useLevel.cancel();

    super.deactivate();
  }
}
