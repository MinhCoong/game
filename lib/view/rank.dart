import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';
import '../components/FrameRank.dart';
import '../components/InfoFriend.dart';

class Rank extends StatefulWidget {
  const Rank({super.key});

  @override
  State<Rank> createState() => _RankState();
}

class _RankState extends State<Rank> {
  final _db = FirebaseDatabase.instance.ref().child('members');
  final _auth = FirebaseAuth.instance;
  late StreamSubscription _useLevel;
  final userName = TextEditingController();
  final startRank = TextEditingController();
  final frameRank = TextEditingController();
  final img = TextEditingController();
  int myIndex = 0;

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    _userLevel();
  }

  //Get lever user
  void _userLevel() {
    _useLevel = _db.child(_auth.currentUser!.uid).onValue.listen((event) async {
      final data = event.snapshot.value as dynamic;

      setState(() {
        userName.text = data['userName'].toString();
        startRank.text = data['starRank'].toString();
        frameRank.text = data['frameRank'].toString();
        img.text = data['image'].toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/galaxy.gif"),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              child: const Align(
                alignment: Alignment.center,
                child: Text(
                  'RANK',
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
            flex: 10,
            child: WidgetAnimator(
              incomingEffect: WidgetTransitionEffects.incomingSlideInFromLeft(),
              child: FirebaseAnimatedList(
                  query: _db.orderByChild('starRank').limitToLast(100),
                  sort: (a, b) =>
                      int.parse(b.child('starRank').value.toString()).compareTo(
                          int.parse(a.child('starRank').value.toString())),
                  itemBuilder: (context, snapshot, animation, index) {
                    if (snapshot.child('userName').value.toString() ==
                        userName.text) {
                      Future.delayed(Duration.zero, () async {
                        setState(() {
                          myIndex = index;
                        });
                      });
                    }
                    return InkWell(
                      onTap: userName.text ==
                              snapshot.child('userName').value.toString()
                          ? null
                          : () {
                              Navigator.of(context).push(PageRouteBuilder(
                                opaque: false,
                                pageBuilder: (BuildContext context, _, __) =>
                                    InfoFriend(
                                  starrank: snapshot
                                      .child('starRank')
                                      .value
                                      .toString(),
                                  url: snapshot.child('image').value.toString(),
                                  urlRank:
                                      snapshot.child('rank').value.toString(),
                                  userName: snapshot
                                      .child('userName')
                                      .value
                                      .toString(),
                                  frameRank: snapshot
                                      .child('frameRank')
                                      .value
                                      .toString(),
                                  chapter: snapshot
                                      .child('chapter')
                                      .value
                                      .toString(),
                                  highScore: snapshot
                                      .child('highScoreChapter')
                                      .child(snapshot
                                          .child('chapter')
                                          .value
                                          .toString())
                                      .value
                                      .toString(),
                                  ID: snapshot.child('userID').value.toString(),
                                ),
                              ));
                            },
                      child: FrameRank(
                        frame: index == 0
                            ? 'assets/images/FrameGold.png'
                            : index == 1
                                ? 'assets/images/FrameSiver.png'
                                : index == 2
                                    ? 'assets/images/FrameCopper.png'
                                    : 'assets/images/FrameNormal.png',
                        frameRank:
                            'assets/images/FrameRank${snapshot.child('frameRank').value.toString()}.png',
                        pathAvatar:
                            'assets/images/AvatarChibi${snapshot.child('image').value.toString()}.jpg',
                        rank: '${index += 1}',
                        userName: snapshot.child('userName').value.toString(),
                        pointRank: snapshot.child('starRank').value.toString(),
                      ),
                    );
                  }),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              margin: const EdgeInsets.only(top: 15, bottom: 5),
              child: FrameRank(
                pathAvatar: img.text != ''
                    ? 'assets/images/AvatarChibi${img.text}.jpg'
                    : 'assets/images/AvatarChibi1.jpg',
                frameRank: frameRank.text != ''
                    ? 'assets/images/FrameRank${frameRank.text}.png'
                    : 'assets/images/FrameRank0.png',
                rank: '$myIndex',
                userName: userName.text,
                pointRank: startRank.text,
                frame: myIndex - 1 == 0
                    ? 'assets/images/FrameGold.png'
                    : myIndex - 1 == 1
                        ? 'assets/images/FrameSiver.png'
                        : myIndex - 1 == 2
                            ? 'assets/images/FrameCopper.png'
                            : 'assets/images/FrameNormal.png',
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
