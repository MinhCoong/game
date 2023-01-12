// ignore_for_file: non_constant_identifier_names

import 'dart:async';

import 'package:dc_marvel_app/components/widget_answer.dart';
import 'package:dc_marvel_app/view/play/play_game.dart';
import 'package:dc_marvel_app/view/play/playing_now.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';
import 'IconHelper.dart';
import 'score.dart';

class Score_event extends StatefulWidget {
  Score_event(
      {super.key,
      required this.isWin,
      required this.Lever,
      required this.exp,
      required this.diamond,
      required this.Score,
      required this.total,
      required this.hightscore,
      // required this.chapter,
      required this.energy,
      required this.time,
      required this.num,
      required this.quantiHammer,
      required this.quantiSpider,
      required this.quantiBat,
      required this.quantiShield});
  bool isWin;
  int Lever;
  int exp;
  int diamond;
  int Score;
  int hightscore;
  int total;
  int time;
  int quantiSpider;
  int quantiBat;
  int num;
  int quantiHammer;
  int quantiShield;
  // int chapter;
  int energy;

  @override
  State<Score_event> createState() => _Score_eventState();
}

class _Score_eventState extends State<Score_event> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final _db = FirebaseDatabase.instance.ref();
  late StreamSubscription _useLevel;
  int chapterCurrent = 1;
  var lsHelp = [];
  @override
  void initState() {
    // TODO: implement initState\

    super.initState();
    _userLevel();
  }

  //Get lever user
  void _userLevel() {
    _useLevel =
        _db.child('members/${auth.currentUser!.uid}').onValue.listen((event) {
      final data = event.snapshot.value as dynamic;
      final data2 = event.snapshot.child('help').children;

      if (mounted) {
        setState(() {
          chapterCurrent = data['chapter'];

          for (var element in data2) {
            lsHelp.add(int.parse(element.value.toString()));
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(.3),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/Background_Play.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          const Spacer(),
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              margin: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: widget.isWin
                      ? const AssetImage('assets/images/FrameScore.png')
                      : const AssetImage('assets/images/FrameScore_Lose.png'),
                  fit: BoxFit.fill,
                ),
              ),
              child: Column(children: [
                Expanded(
                  flex: 2,
                  child: WidgetAnimator(
                    incomingEffect:
                        WidgetTransitionEffects.incomingSlideInFromTop(),
                    child: Center(
                      child: Text(
                        widget.isWin ? 'You Win' : 'You Lose',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontFamily: 'Horizon',
                        ),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Expanded(
                  child: WidgetAnimator(
                    incomingEffect:
                        WidgetTransitionEffects.incomingOffsetThenScale(),
                    child: Container(
                      margin: const EdgeInsets.only(top: 5),
                      child: Text(
                        'Level ${widget.Lever.toString()}',
                        style: const TextStyle(
                          color: Color.fromARGB(255, 246, 250, 45),
                          fontSize: 20,
                          fontFamily: 'Horizon',
                        ),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Expanded(
                  flex: 3,
                  child: WidgetAnimator(
                    incomingEffect:
                        WidgetTransitionEffects.incomingSlideInFromRight(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        score(
                          nameScore: 'Score',
                          point: widget.Score.toString(),
                          fontsiPoint: 45,
                          fontsi: 35,
                          isWin: widget.isWin,
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                Expanded(
                  child: WidgetAnimator(
                    incomingEffect: WidgetTransitionEffects
                        .incomingOffsetThenScaleAndStep(),
                    child: const Text(
                      'Help',
                      style: TextStyle(
                        color: Color.fromARGB(255, 169, 221, 255),
                        fontSize: 20,
                        fontFamily: 'Horizon',
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 1.6,
                    child: WidgetAnimator(
                      incomingEffect:
                          WidgetTransitionEffects.incomingSlideInFromLeft(),
                      child: Row(
                        children: [
                          iconHelper(
                            url: 'assets/images/icons_thor.png',
                            quantity: widget.quantiHammer,
                          ),
                          iconHelper(
                            url: 'assets/images/icon_nhen.png',
                            quantity: widget.quantiSpider,
                          ),
                          iconHelper(
                            url: 'assets/images/icons_doi.png',
                            quantity: widget.quantiBat,
                          ),
                          iconHelper(
                            url: 'assets/images/icons_khien.png',
                            quantity: widget.quantiShield,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Expanded(
                  flex: 2,
                  child: WidgetAnimator(
                    incomingEffect:
                        WidgetTransitionEffects.incomingSlideInFromLeft(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.isWin
                              ? '${widget.total.toString()}/10  +'
                              : '${widget.total.toString()}/10  ',
                          style: const TextStyle(
                            color: Color.fromARGB(255, 246, 250, 45),
                            fontSize: 30,
                            fontFamily: 'Horizon',
                          ),
                        ),
                        widget.num == 110 && widget.isWin
                            ? SizedBox(
                                width: MediaQuery.of(context).size.width / 4.5,
                                child: Row(
                                  children: [
                                    Text(
                                      '${widget.total.toString()}0',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                        fontFamily: 'Horizon',
                                      ),
                                    ),
                                    Image(
                                      width: MediaQuery.of(context).size.width /
                                          11,
                                      image: const AssetImage(
                                          'assets/images/IconDiamond.png'),
                                    )
                                  ],
                                ),
                              )
                            : widget.num == 120 && widget.isWin
                                ? SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 3.2,
                                    child: Row(
                                      children: [
                                        iconHelper(
                                          url: 'assets/images/icon_nhen.png',
                                          quantity: 5,
                                        ),
                                        iconHelper(
                                          url: 'assets/images/icons_khien.png',
                                          quantity: 5,
                                        ),
                                      ],
                                    ),
                                  )
                                : widget.num == 130 && widget.isWin
                                    ? SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3.2,
                                        child: Row(
                                          children: [
                                            iconHelper(
                                              url:
                                                  'assets/images/icons_doi.png',
                                              quantity: 5,
                                            ),
                                            iconHelper(
                                              url:
                                                  'assets/images/icons_thor.png',
                                              quantity: 5,
                                            ),
                                          ],
                                        ),
                                      )
                                    : SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                100,
                                        height:
                                            MediaQuery.of(context).size.width /
                                                100,
                                      )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.width / 18,
                    ),
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: Row(
                      children: [
                        const Spacer(),
                        Expanded(
                          flex: 4,
                          child: Container(
                              width: double.infinity,
                              height: double.infinity,
                              margin: const EdgeInsets.fromLTRB(10, 8, 0, 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: const InkWell()),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          flex: 6,
                          child: WidgetAnimator(
                            incomingEffect: WidgetTransitionEffects
                                .incomingOffsetThenScale(),
                            child: Container(
                              width: double.infinity,
                              height: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: TextButton(
                                onPressed: widget.num == 110
                                    ? () {
                                        widget.exp += widget.Score ~/ 10;

                                        if (widget.isWin) {
                                          widget.energy += 10;
                                          if (widget.Lever * 100 < widget.exp) {
                                            widget.exp -= widget.Lever * 100;
                                            widget.Lever += 1;
                                            (100 - widget.Lever * 5) > 10
                                                ? widget.diamond +=
                                                    (100 - widget.Lever * 5)
                                                : widget.diamond + 10;
                                          }
                                        }

                                        if (_db
                                                .child('members')
                                                .child(auth.currentUser!.uid)
                                                .key !=
                                            null) {
                                          final Score = <String, dynamic>{
                                            'exp': widget.exp,
                                            'level': widget.Lever,
                                            'diamond': widget.isWin
                                                ? widget.diamond + 500
                                                : 0,
                                            'energy': widget.energy,
                                          };

                                          _db
                                              .child(
                                                  'members/${auth.currentUser!.uid}')
                                              .update(Score)
                                              .then((_) =>
                                                  print('update successful'))
                                              .catchError((error) => print(
                                                  'You got an error $error'));
                                        }

                                        Navigator.popUntil(context,
                                            ModalRoute.withName('home'));
                                      }
                                    : widget.num == 120
                                        ? () {
                                            widget.exp += widget.Score ~/ 10;

                                            if (widget.isWin) {
                                              if (widget.Lever * 100 <
                                                  widget.exp) {
                                                widget.exp -=
                                                    widget.Lever * 100;
                                                widget.Lever += 1;
                                              }
                                            }

                                            if (_db
                                                    .child('members')
                                                    .child(
                                                        auth.currentUser!.uid)
                                                    .key !=
                                                null) {
                                              final Score = <String, dynamic>{
                                                'exp': widget.exp,
                                                'level': widget.Lever,
                                              };

                                              _db
                                                  .child(
                                                      'members/${auth.currentUser!.uid}')
                                                  .update(Score)
                                                  .then((_) => print(
                                                      'update successful'))
                                                  .catchError((error) => print(
                                                      'You got an error $error'));

                                              if (widget.isWin) {
                                                final Score = <String, dynamic>{
                                                  'spider': lsHelp[2] + 5,
                                                  'shield': lsHelp[1] + 5
                                                };

                                                _db
                                                    .child(
                                                        'members/${auth.currentUser!.uid}/help')
                                                    .update(Score)
                                                    .then((_) => print(
                                                        'update successful'))
                                                    .catchError((error) => print(
                                                        'You got an error $error'));
                                              }
                                            }

                                            Navigator.popUntil(context,
                                                ModalRoute.withName('home'));
                                          }
                                        : () {
                                            widget.exp += widget.Score ~/ 10;

                                            if (widget.isWin) {
                                              if (widget.Lever * 100 <
                                                  widget.exp) {
                                                widget.exp -=
                                                    widget.Lever * 100;
                                                widget.Lever += 1;
                                              }
                                            }

                                            if (_db
                                                    .child('members')
                                                    .child(
                                                        auth.currentUser!.uid)
                                                    .key !=
                                                null) {
                                              final Score = <String, dynamic>{
                                                'exp': widget.exp,
                                                'level': widget.Lever,
                                              };

                                              _db
                                                  .child(
                                                      'members/${auth.currentUser!.uid}')
                                                  .update(Score)
                                                  .then((_) => print(
                                                      'update successful'))
                                                  .catchError((error) => print(
                                                      'You got an error $error'));

                                              if (widget.isWin) {
                                                final Score = <String, dynamic>{
                                                  'bat': lsHelp[0] + 5,
                                                  'thor': lsHelp[3] + 5
                                                };

                                                _db
                                                    .child(
                                                        'members/${auth.currentUser!.uid}/help')
                                                    .update(Score)
                                                    .then((_) => print(
                                                        'update successful'))
                                                    .catchError((error) => print(
                                                        'You got an error $error'));
                                              }
                                            }

                                            Navigator.popUntil(context,
                                                ModalRoute.withName('home'));
                                          },
                                child: Container(
                                  margin:
                                      const EdgeInsets.only(top: 5, left: 3),
                                  child: const Center(
                                    child: Text(
                                      'OK',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 30,
                                        fontFamily: 'Horizon',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          flex: 4,
                          child: Container(
                              width: double.infinity,
                              height: double.infinity,
                              margin: const EdgeInsets.fromLTRB(5, 8, 5, 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: InkWell()),
                        ),
                        const Spacer()
                      ],
                    ),
                  ),
                ),
              ]),
            ),
          ),
          const Spacer()
        ]),
      ),
    );
  }

  @override
  void deactivate() {
    _useLevel.cancel();
    super.deactivate();
  }
}
