import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:dc_marvel_app/components/AppBarProfile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';
import 'InfoProfile.dart';

class InfoFriend extends StatefulWidget {
  String url;
  String starrank;
  String urlRank;
  String frameRank;
  String userName;
  String chapter;
  String highScore;
  String ID;
  InfoFriend(
      {super.key,
      required this.starrank,
      required this.url,
      required this.urlRank,
      required this.frameRank,
      required this.userName,
      required this.chapter,
      required this.highScore,
      required this.ID});

  @override
  State<InfoFriend> createState() => _InfoFriendState();
}

class _InfoFriendState extends State<InfoFriend> {
  bool isAdd = true, isFriend = false, isUnFr = false;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final _db = FirebaseDatabase.instance.ref();
  late StreamSubscription _useLevel, _isFriend;
  final userName = TextEditingController();
  final startRank = TextEditingController();
  final frameRank = TextEditingController();
  final img = TextEditingController();
  late Future<bool> dataFuture;

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState

    _userLevel();

    dataFuture = isFriendF();

    super.initState();
  }

  //Get lever user
  void _userLevel() async {
    _useLevel = _db
        .child('members/${auth.currentUser!.uid}')
        .onValue
        .listen((event) async {
      final data = event.snapshot.value as dynamic;

      setState(() {
        userName.text = data['userName'].toString();
        startRank.text = data['starRank'].toString();
        frameRank.text = data['frameRank'].toString();
        img.text = data['image'].toString();
      });
    });
  }

  Future<bool> isFriendF() async {
    final snapshot =
        await _db.child('friends/${auth.currentUser!.uid}/${widget.ID}').get();
    if (snapshot.exists) {
      _isFriend = _db
          .child('friends/${auth.currentUser!.uid}/${widget.ID}')
          .onValue
          .listen((event) async {
        final data = event.snapshot.value as dynamic;
        setState(() {
          isFriend = data['statusAdd'].toString() == '2';
        });
      });
      return isFriend;
    } else {
      _isFriend = _db
          .child('friends/${auth.currentUser!.uid}/${widget.ID}')
          .onValue
          .listen((event) async {
        setState(() {
          isFriend = false;
        });
      });
      return isFriend;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black.withOpacity(.6),
        // title: const Text('Basic dialog title'),
        body: FutureBuilder(
            future: dataFuture,
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (!snapshot.hasData) {
// while data is loading:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Spacer(),
                    Expanded(
                      flex: 4,
                      child: Container(
                          margin: const EdgeInsets.all(15),
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                            image: AssetImage(
                                'assets/images/profile_background.png'),
                            fit: BoxFit.fill,
                          )),
                          child: Column(
                            children: [
                              Expanded(
                                  child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const Spacer(
                                    flex: 5,
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: WidgetAnimator(
                                      incomingEffect: WidgetTransitionEffects
                                          .incomingSlideInFromRight(),
                                      child: Text(
                                        isFriend ? 'Friend' : 'Player',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 30,
                                          fontFamily: 'Horizon',
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Spacer()
                                ],
                              )),
                              Expanded(
                                flex: 13,
                                child: Column(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: WidgetAnimator(
                                        incomingEffect: WidgetTransitionEffects
                                            .incomingSlideInFromTop(),
                                        child: Stack(
                                          alignment: Alignment.center,
                                          fit: StackFit.loose,
                                          children: [
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  4.8,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  4.8,
                                              child: Image.asset(
                                                  'assets/images/AvatarChibi${widget.url}.jpg'),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  3.2,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  3.2,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/images/FrameRank${widget.frameRank}.png'),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      4),
                                              child: const Text(
                                                '2',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 11,
                                                    fontFamily: 'Horizon',
                                                    letterSpacing: 2),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: WidgetAnimator(
                                        incomingEffect: WidgetTransitionEffects
                                            .incomingSlideInFromTop(),
                                        child: AnimatedTextKit(
                                          totalRepeatCount: 100,
                                          animatedTexts: [
                                            ColorizeAnimatedText(
                                              widget.userName,
                                              textStyle: colorizeTextStyle,
                                              colors: colorizeColors,
                                            ),
                                          ],
                                          isRepeatingAnimation: true,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                        flex: 2,
                                        child: WidgetAnimator(
                                          incomingEffect:
                                              WidgetTransitionEffects
                                                  .incomingSlideInFromRight(),
                                          child: Column(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  'ID : ${widget.ID}',
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: 'Horizon',
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                  flex: 2,
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Column(
                                                          children: [
                                                            Expanded(
                                                                child: Text(
                                                              widget.highScore,
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontFamily:
                                                                      'Horizon',
                                                                  fontSize: 20),
                                                            )),
                                                            const Expanded(
                                                                child: Text(
                                                              'Points',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontFamily:
                                                                      'Horizon',
                                                                  fontSize: 20),
                                                            )),
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Column(
                                                          children: [
                                                            Expanded(
                                                                child: Text(
                                                              widget.chapter,
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontFamily:
                                                                      'Horizon',
                                                                  fontSize: 20),
                                                            )),
                                                            const Expanded(
                                                                child: Text(
                                                              'Chapter',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontFamily:
                                                                      'Horizon',
                                                                  fontSize: 20),
                                                            )),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ))
                                            ],
                                          ),
                                        )),
                                    Expanded(
                                        flex: 2,
                                        child: Row(
                                          children: [
                                            infoProfle(
                                              Url: 'assets/images/cup.png',
                                              x: 1,
                                            ),
                                            infoProfle(
                                                Url:
                                                    'assets/images/rank${widget.urlRank}.png',
                                                x: int.parse(widget.starrank)),
                                            Expanded(
                                              flex: 2,
                                              child: isFriend
                                                  ? Column(
                                                      children: [
                                                        Expanded(
                                                          child: InkWell(
                                                            onTap: () async {
                                                              if (_db
                                                                      .child(
                                                                          'members')
                                                                      .child(auth
                                                                          .currentUser!
                                                                          .uid)
                                                                      .key !=
                                                                  null) {
                                                                final snapshot =
                                                                    await _db
                                                                        .child(
                                                                            'friends/${FirebaseAuth.instance.currentUser!.uid}/${widget.ID}')
                                                                        .get();

                                                                if (snapshot
                                                                    .exists) {
                                                                  final addFriend = <
                                                                      String,
                                                                      dynamic>{
                                                                    'statusAdd':
                                                                        3
                                                                  };
                                                                  _db
                                                                      .child(
                                                                          'friends/${auth.currentUser!.uid}/${widget.ID}')
                                                                      .update(
                                                                          addFriend)
                                                                      .then((_) =>
                                                                          print(
                                                                              'friend has been Acp!'))
                                                                      .catchError(
                                                                          (error) =>
                                                                              print('You got an error $error'));
                                                                  final snapshot1 =
                                                                      await _db
                                                                          .child(
                                                                              'friends/${widget.ID}/${FirebaseAuth.instance.currentUser!.uid}')
                                                                          .get();

                                                                  if (snapshot1
                                                                      .exists) {
                                                                    final addFriend = <
                                                                        String,
                                                                        dynamic>{
                                                                      'statusAdd':
                                                                          3
                                                                    };
                                                                    _db
                                                                        .child(
                                                                            'friends/${widget.ID}/${FirebaseAuth.instance.currentUser!.uid}')
                                                                        .update(
                                                                            addFriend)
                                                                        .then((_) =>
                                                                            print(
                                                                                'friend has been acp!'))
                                                                        .catchError((error) =>
                                                                            print('You got an error $error'));
                                                                  }
                                                                }
                                                                setState(() {
                                                                  isFriend =
                                                                      false;
                                                                  isAdd = true;
                                                                  isUnFr = true;
                                                                });
                                                              }
                                                            },
                                                            child: SizedBox(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  5,
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  5,
                                                              child: Image.asset(
                                                                  'assets/images/iconUnFriend.png'),
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Container(
                                                            margin:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 5),
                                                            child: const Text(
                                                              'Unfriend',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 20,
                                                                fontFamily:
                                                                    'Horizon',
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  : Column(
                                                      children: [
                                                        Expanded(
                                                          child: InkWell(
                                                            onTap: isAdd
                                                                ? () async {
                                                                    if (_db
                                                                            .child('members')
                                                                            .child(auth.currentUser!.uid)
                                                                            .key !=
                                                                        null) {
                                                                      final snapshot = await _db
                                                                          .child(
                                                                              'friends/${FirebaseAuth.instance.currentUser!.uid}/${widget.ID}')
                                                                          .get();
                                                                      final status = await _db
                                                                          .child(
                                                                              'friends/${FirebaseAuth.instance.currentUser!.uid}/${widget.ID}/statusAdd')
                                                                          .get();
                                                                      print(status
                                                                          .value
                                                                          .toString());
                                                                      if (!snapshot
                                                                              .exists ||
                                                                          int.parse(status.value.toString()) !=
                                                                              2) {
                                                                        final addFriend = <
                                                                            String,
                                                                            dynamic>{
                                                                          'frameRank':
                                                                              widget.frameRank,
                                                                          'image':
                                                                              widget.url,
                                                                          'userName':
                                                                              widget.userName,
                                                                          'timeAdd':
                                                                              '${DateTime.now()}',
                                                                          'statusAdd':
                                                                              1
                                                                        };
                                                                        _db
                                                                            .child(
                                                                                'friends/${auth.currentUser!.uid}/${widget.ID}')
                                                                            .set(
                                                                                addFriend)
                                                                            .then((_) =>
                                                                                print('friend has been written!'))
                                                                            .catchError((error) => print('You got an error $error'));

                                                                        final addPlayerTwo = <
                                                                            String,
                                                                            dynamic>{
                                                                          'frameRank': frameRank.text != ''
                                                                              ? frameRank.text
                                                                              : 'null',
                                                                          'image': img.text != ''
                                                                              ? img.text
                                                                              : 'null',
                                                                          'userName': userName.text != ''
                                                                              ? userName.text
                                                                              : 'null',
                                                                          'timeAdd':
                                                                              '${DateTime.now()}',
                                                                          'statusAdd':
                                                                              0
                                                                        };
                                                                        _db
                                                                            .child(
                                                                                'friends/${widget.ID}/${auth.currentUser!.uid}')
                                                                            .set(
                                                                                addPlayerTwo)
                                                                            .then((_) =>
                                                                                print('friend has been written!'))
                                                                            .catchError((error) => print('You got an error $error'));

                                                                        setState(
                                                                            () {
                                                                          isAdd =
                                                                              false;
                                                                        });
                                                                        // ignore: use_build_context_synchronously

                                                                      }
                                                                    }
                                                                  }
                                                                : isUnFr
                                                                    ? null
                                                                    : () async {
                                                                        if (_db.child('members').child(auth.currentUser!.uid).key !=
                                                                            null) {
                                                                          final snapshot = await _db
                                                                              .child('friends/${FirebaseAuth.instance.currentUser!.uid}/${widget.ID}')
                                                                              .get();

                                                                          if (snapshot
                                                                              .exists) {
                                                                            _db.child('friends/${FirebaseAuth.instance.currentUser!.uid}/${widget.ID}').remove();
                                                                            final snapshot1 =
                                                                                await _db.child('friends/${widget.ID}/${FirebaseAuth.instance.currentUser!.uid}').get();

                                                                            if (snapshot1.exists) {
                                                                              _db.child('friends/${widget.ID}/${FirebaseAuth.instance.currentUser!.uid}').remove();
                                                                            }
                                                                            setState(() {
                                                                              isAdd = true;
                                                                            });
                                                                          }
                                                                        }
                                                                      },
                                                            child: SizedBox(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  5,
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  5,
                                                              child: Image.asset(isAdd
                                                                  ? 'assets/images/iconAddfriend.png'
                                                                  : isUnFr
                                                                      ? 'assets/images/iconsHourglass.png'
                                                                      : 'assets/images/iconMinus.png'),
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Container(
                                                            margin:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 5),
                                                            child: Text(
                                                              isAdd
                                                                  ? 'Add'
                                                                  : isUnFr
                                                                      ? 'Wating'
                                                                      : 'Cancel',
                                                              style:
                                                                  const TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 22,
                                                                fontFamily:
                                                                    'Horizon',
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                            ),
                                            const Spacer()
                                          ],
                                        )),
                                    Expanded(
                                        child: WidgetAnimator(
                                      incomingEffect: WidgetTransitionEffects
                                          .incomingSlideInFromLeft(),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          InkWell(
                                            onTap: (() {
                                              Navigator.pop(context);
                                            }),
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  5,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  5,
                                              decoration: const BoxDecoration(
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      "assets/images/backhome.png"),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ))
                                  ],
                                ),
                              ),
                            ],
                          )),
                    ),
                    const Spacer()
                  ],
                );
              }
            }));
  }

  @override
  void deactivate() {
    _useLevel.cancel();
    _isFriend.cancel();

    super.deactivate();
  }
}
