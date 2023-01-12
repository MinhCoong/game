// ignore_for_file: avoid_print, use_build_context_synchronously, non_constant_identifier_names

import 'dart:async';
import 'dart:math';

import 'package:dc_marvel_app/components/ChangeRoom.dart';
import 'package:dc_marvel_app/components/FrameEx.dart';
import 'package:dc_marvel_app/components/showChapterAll.dart';
import 'package:dc_marvel_app/view/play/find_battle.dart';
import 'package:dc_marvel_app/view/play/playing_now.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';
import '../../components/AppBarProfile.dart';
import '../../components/ButtonBattleCustom.dart';
import '../../components/ChapterImage.dart';
import '../notify/notify.dart';

class PlayGame extends StatefulWidget {
  const PlayGame({super.key});

  @override
  State<PlayGame> createState() => _PlayGameState();
}

class _PlayGameState extends State<PlayGame> {
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseDatabase.instance.ref();
  late StreamSubscription _useLevel, _numberAdd;
  int level = 1;
  var hightScore;
  int chapter = 1;
  int exp = 0;
  int diamond = 0;
  int energy = 0;
  int count = 0;
  bool isVisible = false;
  late Future<int> dataFuture;

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initStat
    dataFuture = numberAddF();
    _userLevel();
    super.initState();
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
          chapter = data['chapter'];
          exp = data['exp'];
          diamond = data['diamond'];
          energy = data['energy'];
          hightScore = hSc[chapter];
        });
      }
    });
  }

  Future<int> numberAddF() async {
    _db.child('friends').child(_auth.currentUser!.uid).onValue.listen((event) {
      for (var element in event.snapshot.children) {
        if (element.child('statusAdd').value.toString().isNotEmpty &&
            int.parse(element.child('statusAdd').value.toString()) == 0) {
          if (mounted) {
            setState(() {
              isVisible = true;
            });
          }
        } else {
          if (mounted) {
            setState(() {
              isVisible = false;
            });
          }
        }
      }
    });
    return count;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.all(20),
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/galaxy.gif"),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        children: [
          const Expanded(
            flex: 1,
            child: AppBarProfile(),
          ),
          Expanded(
            flex: 5,
            child: Stack(
              alignment: Alignment.center,
              children: [
                WidgetAnimator(
                  incomingEffect:
                      WidgetTransitionEffects.incomingSlideInFromTop(),
                  atRestEffect: WidgetRestingEffects.wave(),
                  child: chapter == 1
                      ? InkWell(
                          key: const ValueKey('1'),
                          onTap: (() => Navigator.of(context).push(
                                PageRouteBuilder(
                                  opaque: false,
                                  pageBuilder: (BuildContext context, _, __) =>
                                      const ShowChapterAll(),
                                ),
                              )),
                          child: const ChapterImage(
                            hightScore: '',
                            path: 'assets/images/Chapter1.png',
                          ),
                        )
                      : InkWell(
                          key: ValueKey('$chapter'),
                          onTap: (() => Navigator.of(context).push(
                                PageRouteBuilder(
                                  opaque: false,
                                  pageBuilder: (BuildContext context, _, __) =>
                                      const ShowChapterAll(),
                                ),
                              )),
                          child: ChapterImage(
                            hightScore: '',
                            path: 'assets/images/Chapter$chapter.png',
                          ),
                        ),
                ),
                Container(
                  alignment: Alignment.topRight,
                  margin: const EdgeInsets.only(top: 5, right: 5),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        isVisible = false;
                      });
                      Navigator.of(context).push(PageRouteBuilder(
                        opaque: false,
                        pageBuilder: (BuildContext context, _, __) =>
                            const Notify(),
                      ));
                    },
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Image(
                          width: MediaQuery.of(context).size.width / 7,
                          height: MediaQuery.of(context).size.width / 7,
                          image:
                              const AssetImage('assets/images/Icon_bell.png'),
                          fit: BoxFit.fill,
                        ),
                        FutureBuilder(
                            future: dataFuture,
                            builder: (BuildContext context,
                                AsyncSnapshot<int> snapshot) {
                              if (!snapshot.hasData) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else {
                                return Visibility(
                                    visible: isVisible,
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: MediaQuery.of(context).size.width /
                                          25,
                                      height:
                                          MediaQuery.of(context).size.width /
                                              25,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/iconCircle.png'),
                                          // fit: BoxFit.cover,
                                        ),
                                      ),
                                    ));
                              }
                            })
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.only(top: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: WidgetAnimator(
                      incomingEffect:
                          WidgetTransitionEffects.incomingSlideInFromLeft(),
                      child: InkWell(
                        onTap: () async {
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              opaque: false,
                              pageBuilder: (BuildContext context, _, __) =>
                                  const PlayBattle(),
                            ),
                          );
                        },
                        child: const ButtonBattleCustom(
                          title: 'BATTLE',
                          url: "assets/images/ButtonPlayBattle.png",
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: WidgetAnimator(
                      incomingEffect:
                          WidgetTransitionEffects.incomingSlideInFromBottom(),
                      child: InkWell(
                        onTap: () {
                          if (energy > 1) {
                            if (_db
                                    .child('members')
                                    .child(_auth.currentUser!.uid)
                                    .key !=
                                null) {
                              final energy1 = <String, dynamic>{
                                'energy': energy -= 2
                              };
                              _db
                                  .child('members/${_auth.currentUser!.uid}')
                                  .update(energy1)
                                  .then(
                                      (_) => print('update Spider successful'))
                                  .catchError((error) =>
                                      print('You got an error $error'));
                            }
                            Navigator.of(context).push(
                              PageRouteBuilder(
                                opaque: false,
                                pageBuilder: (BuildContext context, _, __) =>
                                    PlayingGame(
                                        level: level,
                                        exp: exp,
                                        hightScore: hightScore,
                                        chapter: chapter,
                                        diamond: diamond),
                              ),
                            );
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const FrameEx(
                                        Ex: 'Energy is not enought')));
                          }
                        },
                        child: const ButtonBattleCustom(
                          title: 'PLAY NOW',
                          url: "assets/images/ButtonPlaynow.png",
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: WidgetAnimator(
                      incomingEffect:
                          WidgetTransitionEffects.incomingSlideInFromRight(),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              opaque: false,
                              pageBuilder: (BuildContext context, _, __) =>
                                  const ChangeRoom(),
                            ),
                          );
                        },
                        child: const ButtonBattleCustom(
                          title: 'ROOM',
                          url: "assets/images/ButtonPlayRoom.png",
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
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
