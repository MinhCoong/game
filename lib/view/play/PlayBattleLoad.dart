// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, use_build_context_synchronously, avoid_print

import 'dart:async';
import 'dart:math';

import 'package:dc_marvel_app/components/AnswerBattle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../components/ReportBattle.dart';
import '../../components/ReportBattleRank.dart';

class PlayBattleGame extends StatefulWidget {
  const PlayBattleGame({super.key, required this.roomID, required this.urlRef});
  final String roomID;
  final String urlRef;

  @override
  State<PlayBattleGame> createState() => _PlayBattleGameState();
}

class _PlayBattleGameState extends State<PlayBattleGame> {
  TextEditingController userTwo = TextEditingController();
  TextEditingController userOne = TextEditingController();
  TextEditingController frameRankUserOne = TextEditingController();
  TextEditingController frameRankUserTwo = TextEditingController();
  TextEditingController userImageOne = TextEditingController();
  TextEditingController userImageTwo = TextEditingController();
  TextEditingController highScoreOne = TextEditingController();
  TextEditingController highScoreTwo = TextEditingController();
  TextEditingController chapterID = TextEditingController();
  TextEditingController chapterName = TextEditingController();
  int _activeAnswer = 0;
  int timeDown = 15;
  int _nextQuestion = 1;
  int ScoreOne = 0;
  int ScoreTwo = 0;
  int EndNextQuestion = 1;

  final _db = FirebaseDatabase.instance.ref();
  final _auth = FirebaseAuth.instance;
  late StreamSubscription _getRoomPlayerOne, _getRoomPlayerTwo, _getChapter;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _getPlayerOne();
    _getPlayerTwo();
    _getNextQuestion();
    _getChapters();
  }

  void _getPlayerOne() {
    _getRoomPlayerOne = _db
        .child('${widget.urlRef}/${widget.roomID}/playerOne')
        .onValue
        .listen((event) {
      final data = event.snapshot.value as dynamic;
      setState(() {
        userOne.text = data['userName'].toString();
        userImageOne.text = data['image'].toString();
        frameRankUserOne.text = data['rank'].toString();
        highScoreOne.text = data['highScore'].toString();
        print(frameRankUserOne.text);
      });
    });
  }

  void _getPlayerTwo() {
    _getRoomPlayerTwo = _db
        .child('${widget.urlRef}/${widget.roomID}/playerTwo')
        .onValue
        .listen((event) {
      final data = event.snapshot.value as dynamic;
      setState(() {
        userTwo.text = data['userName'].toString();
        userImageTwo.text = data['image'].toString();
        frameRankUserTwo.text = data['rank'].toString();
        highScoreTwo.text = data['highScore'].toString();
        print(frameRankUserTwo.text);
      });
    });
  }

  void _getChapters() {
    _getChapter =
        _db.child('questions/$_nextQuestion/chapter').onValue.listen((event) {
      final data = event.snapshot.value as dynamic;
      setState(() {
        chapterID.text = data['id'].toString();
        chapterName.text = data['title'].toString();
      });
    });
  }

  void _getNextQuestion() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) async {
      if (timeDown != 0) {
        setState(() {
          --timeDown;
        });
      } else {
        timeDown = 15;
        final lengQuestion = await _db.child('questions').get();
        await _db.child('questions/$_nextQuestion/key').get();
        final snapshotQuestion =
            await _db.child('questions/$_nextQuestion/key').get();
        final snapshot = await _db
            .child('members/${FirebaseAuth.instance.currentUser!.uid}/userName')
            .get();

        if (snapshotQuestion.value == _activeAnswer.toString()) {
          ScoreOne += 10;
          ScoreTwo += 10;
        }

        snapshot.value == userOne.text
            ? _db
                .child('${widget.urlRef}/${widget.roomID}/playerOne/highScore')
                .set(ScoreOne)
            : _db
                .child('${widget.urlRef}/${widget.roomID}/playerTwo/highScore')
                .set(ScoreTwo);

        _activeAnswer = 0;
        _nextQuestion = Random().nextInt(lengQuestion.children.length - 1) + 1;
        ++EndNextQuestion;
        if (EndNextQuestion == 11) {
          timer.cancel();
          _db.child('${widget.urlRef}/${widget.roomID}/status').set(false);
          final getRoom = await _db.child('battle/${widget.roomID}').get();
          Navigator.pop(context);
          Navigator.of(context).push(
            PageRouteBuilder(
              opaque: false,
              pageBuilder: (BuildContext context, _, __) {
                if (getRoom.children.isNotEmpty) {
                  return ReportBattleRank(
                    highScoreOne: int.parse(highScoreOne.text),
                    highScoreTwo: int.parse(highScoreTwo.text),
                    roomId: widget.roomID.toString(),
                  );
                } else {
                  return ReportBattle(
                    highScoreOne: int.parse(highScoreOne.text),
                    highScoreTwo: int.parse(highScoreTwo.text),
                    roomId: widget.roomID.toString(),
                  );
                }
              },
            ),
          );

          final String report;
          if ((int.parse(highScoreOne.text) > int.parse(highScoreTwo.text) &&
                  snapshot.value == userOne.text) ||
              (int.parse(highScoreOne.text) < int.parse(highScoreTwo.text) &&
                  snapshot.value != userOne.text)) {
            report = 'win';
          } else {
            report = 'lose';
          }

          DateTime dateToday = DateTime.now();
          String date = dateToday.toString().substring(0, 19);
          if (widget.urlRef == 'battle') {}

          final nextHistory = <String, dynamic>{
            'playerOne': {
              'userName': userOne.text,
              'image': userImageOne.text,
              'rank': frameRankUserOne.text,
              'highScore': highScoreOne.text,
            },
            'playerTwo': {
              'userName': userTwo.text,
              'image': userImageTwo.text,
              'rank': frameRankUserTwo.text,
              'highScore': highScoreTwo.text,
            },
            'battle': widget.urlRef == 'battle' ? 'rank' : 'normal',
            'report': report,
            'time': date,
          };
          _db
              .child(
                  'historys/${_auth.currentUser!.uid}/${DateTime.now().microsecondsSinceEpoch}')
              .set(nextHistory)
              .then((_) => print('Member has been written!'))
              .catchError((error) => print('You got an error $error'));

          Timer.periodic(Duration(seconds: 2), (timer) {
            _db
                .child('${widget.urlRef}/${widget.roomID}/playerOne/highScore')
                .set(0);
            _db
                .child('${widget.urlRef}/${widget.roomID}/playerTwo/highScore')
                .set(0);
            timer.cancel();
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/Background_Play.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/FrameTitle.png'),
                    fit: BoxFit.fill,
                  ),
                ),
                // padding: const EdgeInsets.only(bottom: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Center(
                                child: Image.asset(
                                  userImageOne.text == ""
                                      ? 'assets/images/iconAddfriend.png'
                                      : 'assets/images/AvatarChibi${userImageOne.text}.jpg',
                                  height: 66,
                                ),
                              ),
                              Center(
                                child: Image.asset(
                                  frameRankUserOne.text.isEmpty
                                      ? "assets/images/FrameRank1.png"
                                      : "assets/images/FrameRank${frameRankUserOne.text}.png",
                                  height: 100,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            '${userOne.text} : ${highScoreOne.text}',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/vsbattle.png"),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Center(
                                child: Image.asset(
                                  userImageTwo.text == ""
                                      ? 'assets/images/iconAddfriend.png'
                                      : 'assets/images/AvatarChibi${userImageTwo.text}.jpg',
                                  height: 66,
                                ),
                              ),
                              Center(
                                child: Image.asset(
                                  frameRankUserTwo.text.isEmpty
                                      ? "assets/images/FrameRank1.png"
                                      : "assets/images/FrameRank${frameRankUserTwo.text}.png",
                                  height: 100,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            '${userTwo.text} : ${highScoreTwo.text}',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 8,
              child: StreamBuilder(
                  stream: _db.child('questions/$_nextQuestion').onValue,
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data != null) {
                      final data = Map<String, dynamic>.from(
                        Map<String, dynamic>.from(
                            (snapshot.data as DatabaseEvent).snapshot.value
                                as Map<dynamic, dynamic>),
                      );
                      return Column(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      "assets/images/FrameTitle.png"),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              child: Column(
                                children: [
                                  Expanded(
                                    flex: 6,
                                    child: Padding(
                                      padding: EdgeInsets.all(size.width / 15),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          data['title'].toString(),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 12),
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          timeDown.toString(),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      // "Chapter ${chapterID.text}: ${chapterName.text}",
                                      'Câu $EndNextQuestion / 10',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: () async {
                                      setState(
                                        () {
                                          _activeAnswer = 1;
                                        },
                                      );
                                    },
                                    child: AnswerBattle(
                                      frameAnswer: _activeAnswer == 1
                                          ? "assets/images/FrameCopper.png"
                                          : "assets/images/FrameTitle.png",
                                      title: 'A',
                                      caption: data['1'].toString(),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      setState(
                                        () {
                                          _activeAnswer = 2;
                                        },
                                      );
                                    },
                                    child: AnswerBattle(
                                      frameAnswer: _activeAnswer == 2
                                          ? "assets/images/FrameCopper.png"
                                          : "assets/images/FrameTitle.png",
                                      title: 'B',
                                      caption: data['2'].toString(),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      setState(
                                        () {
                                          _activeAnswer = 3;
                                        },
                                      );
                                    },
                                    child: AnswerBattle(
                                      frameAnswer: _activeAnswer == 3
                                          ? "assets/images/FrameCopper.png"
                                          : "assets/images/FrameTitle.png",
                                      title: 'C',
                                      caption: data['3'].toString(),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      setState(
                                        () {
                                          _activeAnswer = 4;
                                        },
                                      );
                                    },
                                    child: AnswerBattle(
                                      frameAnswer: _activeAnswer == 4
                                          ? "assets/images/FrameCopper.png"
                                          : "assets/images/FrameTitle.png",
                                      title: 'D',
                                      caption: data['4'].toString(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }
                    return CircularProgressIndicator();
                  }),
            ),
            const Spacer(
              flex: 1,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void deactivate() {
    _getRoomPlayerOne.cancel();
    _getRoomPlayerTwo.cancel();
    _getChapter.cancel();
    _timer!.cancel();
    super.deactivate();
  }
}
