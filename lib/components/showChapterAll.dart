import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

import '../view/play/playing_now.dart';
import 'ChapterImage.dart';

class ShowChapterAll extends StatefulWidget {
  const ShowChapterAll({super.key});

  @override
  State<ShowChapterAll> createState() => _ShowChapterAllState();
}

class _ShowChapterAllState extends State<ShowChapterAll> {
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseDatabase.instance.ref();
  late StreamSubscription _useLevel;
  final level = TextEditingController();
  final hightScore = TextEditingController();
  final chapter = TextEditingController();
  final exp = TextEditingController();
  final diamond = TextEditingController();
  var hSchapter;

  @override
  void initState() {
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
          level.text = data['level'].toString();
          chapter.text = data['chapter'].toString();
          exp.text = data['exp'].toString();
          diamond.text = data['diamond'].toString();
          hightScore.text = hSc[int.parse(chapter.text)].toString();
          hSchapter = hSc;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(.9),
      body: InkWell(
        onTap: () => Navigator.pop(context),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                margin: const EdgeInsets.only(top: 10),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/FrameTitle.png'),
                    fit: BoxFit.fill,
                  ),
                ),
                child: const Align(
                  alignment: Alignment.center,
                  child: Text(
                    'ALL CHAPTER',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ItemChappter(
                      chapter: chapter.text != '' ? int.parse(chapter.text) : 1,
                      level: level.text != '' ? int.parse(chapter.text) : 1,
                      exp: exp.text != '' ? int.parse(exp.text) : 1,
                      hightScore: hightScore.text != '' ? hSchapter[1] : 1,
                      diamond: diamond.text != '' ? int.parse(diamond.text) : 1,
                      numberChappter: 1,
                      path: 'assets/images/Chapter1.png',
                    ),
                    ItemChappter(
                      chapter: chapter.text != '' ? int.parse(chapter.text) : 1,
                      level: level.text != '' ? int.parse(chapter.text) : 1,
                      exp: exp.text != '' ? int.parse(exp.text) : 1,
                      hightScore: hightScore.text != ''
                          ? int.parse(chapter.text) == 2
                              ? int.parse(hightScore.text)
                              : int.parse(chapter.text) > 2
                                  ? hSchapter[2]
                                  : 1
                          : 1,
                      diamond: diamond.text != '' ? int.parse(diamond.text) : 1,
                      numberChappter: 2,
                      path: 'assets/images/Chapter2.png',
                    ),
                    ItemChappter(
                      chapter: chapter.text != '' ? int.parse(chapter.text) : 1,
                      level: level.text != '' ? int.parse(chapter.text) : 1,
                      exp: exp.text != '' ? int.parse(exp.text) : 1,
                      hightScore: hightScore.text != ''
                          ? int.parse(chapter.text) == 3
                              ? int.parse(hightScore.text)
                              : int.parse(chapter.text) > 3
                                  ? hSchapter[3]
                                  : 1
                          : 1,
                      diamond: diamond.text != '' ? int.parse(diamond.text) : 1,
                      numberChappter: 3,
                      path: 'assets/images/Chapter3.png',
                    ),
                    ItemChappter(
                      chapter: chapter.text != '' ? int.parse(chapter.text) : 1,
                      level: level.text != '' ? int.parse(chapter.text) : 1,
                      exp: exp.text != '' ? int.parse(exp.text) : 1,
                      hightScore: hightScore.text != ''
                          ? int.parse(chapter.text) == 4
                              ? int.parse(hightScore.text)
                              : int.parse(chapter.text) > 4
                                  ? hSchapter[4]
                                  : 1
                          : 1,
                      diamond: diamond.text != '' ? int.parse(diamond.text) : 1,
                      numberChappter: 4,
                      path: 'assets/images/Chapter4.png',
                    ),
                    ItemChappter(
                      chapter: chapter.text != '' ? int.parse(chapter.text) : 1,
                      level: level.text != '' ? int.parse(chapter.text) : 1,
                      exp: exp.text != '' ? int.parse(exp.text) : 1,
                      hightScore: hightScore.text != ''
                          ? int.parse(chapter.text) == 5
                              ? int.parse(hightScore.text)
                              : int.parse(chapter.text) > 5
                                  ? hSchapter[5]
                                  : 1
                          : 1,
                      diamond: diamond.text != '' ? int.parse(diamond.text) : 1,
                      numberChappter: 5,
                      path: 'assets/images/Chapter5.png',
                    ),
                    ItemChappter(
                      chapter: chapter.text != '' ? int.parse(chapter.text) : 1,
                      level: level.text != '' ? int.parse(chapter.text) : 1,
                      exp: exp.text != '' ? int.parse(exp.text) : 1,
                      hightScore: hightScore.text != ''
                          ? int.parse(chapter.text) == 6
                              ? int.parse(hightScore.text)
                              : int.parse(chapter.text) > 6
                                  ? hSchapter[6]
                                  : 1
                          : 1,
                      diamond: diamond.text != '' ? int.parse(diamond.text) : 1,
                      numberChappter: 6,
                      path: 'assets/images/Chapter6.png',
                    ),
                    ItemChappter(
                      chapter: chapter.text != '' ? int.parse(chapter.text) : 1,
                      level: level.text != '' ? int.parse(chapter.text) : 1,
                      exp: exp.text != '' ? int.parse(exp.text) : 1,
                      hightScore: hightScore.text != ''
                          ? int.parse(chapter.text) == 7
                              ? int.parse(hightScore.text)
                              : int.parse(chapter.text) > 7
                                  ? hSchapter[7]
                                  : 1
                          : 1,
                      diamond: diamond.text != '' ? int.parse(diamond.text) : 1,
                      numberChappter: 7,
                      path: 'assets/images/Chapter7.png',
                    ),
                    ItemChappter(
                      chapter: chapter.text != '' ? int.parse(chapter.text) : 1,
                      level: level.text != '' ? int.parse(chapter.text) : 1,
                      exp: exp.text != '' ? int.parse(exp.text) : 1,
                      hightScore: hightScore.text != ''
                          ? int.parse(chapter.text) == 8
                              ? int.parse(hightScore.text)
                              : int.parse(chapter.text) > 8
                                  ? hSchapter[8]
                                  : 1
                          : 1,
                      diamond: diamond.text != '' ? int.parse(diamond.text) : 1,
                      numberChappter: 8,
                      path: 'assets/images/Chapter8.png',
                    ),
                    ItemChappter(
                      chapter: chapter.text != '' ? int.parse(chapter.text) : 1,
                      level: level.text != '' ? int.parse(chapter.text) : 1,
                      exp: exp.text != '' ? int.parse(exp.text) : 1,
                      hightScore: hightScore.text != ''
                          ? int.parse(chapter.text) == 9
                              ? int.parse(hightScore.text)
                              : int.parse(chapter.text) > 9
                                  ? hSchapter[9]
                                  : 1
                          : 1,
                      diamond: diamond.text != '' ? int.parse(diamond.text) : 1,
                      numberChappter: 9,
                      path: 'assets/images/Chapter9.png',
                    ),
                    ItemChappter(
                      chapter: chapter.text != '' ? int.parse(chapter.text) : 1,
                      level: level.text != '' ? int.parse(chapter.text) : 1,
                      exp: exp.text != '' ? int.parse(exp.text) : 1,
                      hightScore: hightScore.text != ''
                          ? int.parse(chapter.text) == 10
                              ? int.parse(hightScore.text)
                              : int.parse(chapter.text) > 10
                                  ? hSchapter[10]
                                  : 1
                          : 1,
                      diamond: diamond.text != '' ? int.parse(diamond.text) : 1,
                      numberChappter: 10,
                      path: 'assets/images/Chapter10.png',
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.width / 2),
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/tubecontinue.gif'),
                          fit: BoxFit.fill,
                        ),
                      ),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: WidgetAnimator(
                        incomingEffect:
                            WidgetTransitionEffects.incomingSlideInFromLeft(),
                        atRestEffect: WidgetRestingEffects.wave(),
                        child: const Text(
                          'To be continue...',
                          style: TextStyle(
                              fontFamily: 'Horizon',
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.cyan),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
