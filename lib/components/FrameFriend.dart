import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'InfoFriend.dart';
import 'score_game.dart';

class FrameFriend extends StatefulWidget {
  const FrameFriend(
      {Key? key,
      required this.frameRank,
      required this.pathAvatar,
      required this.userName,
      required this.idUser})
      : super(key: key);

  final String frameRank;
  final String pathAvatar;
  final String userName;
  final String idUser;

  @override
  State<FrameFriend> createState() => _FrameFriendState();
}

class _FrameFriendState extends State<FrameFriend> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final _db = FirebaseDatabase.instance.ref();
  late StreamSubscription _useLevel;
  var hScoreC;
  String chapter = '', urlRank = '';
  String star = '';
  Future<String> loadUser() async {
    _useLevel =
        _db.child('members/${widget.idUser}').onValue.listen((event) async {
      final data = event.snapshot.value as dynamic;
      final data2 =
          event.snapshot.child('highScoreChapter').value as List<dynamic>;
      if (mounted) {
        setState(() {
          star = data['starRank'].toString();
          chapter = data['chapter'].toString();
          urlRank = data['rank'].toString();
          hScoreC = data2[int.parse(chapter)];
        });
      }
    });
    return chapter;
  }

  @override
  void initState() {
    // TODO: implement initState
    loadUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        // padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
        width: double.infinity,
        height: 60,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/FrameNormal.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: FutureBuilder(
          future: loadUser(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (!snapshot.hasData) {
              // while data is loading:
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(PageRouteBuilder(
                                opaque: false,
                                pageBuilder: (BuildContext context, _, __) =>
                                    InfoFriend(
                                  starrank: star,
                                  url: widget.pathAvatar,
                                  urlRank: urlRank,
                                  userName: widget.userName,
                                  frameRank: widget.frameRank,
                                  chapter: chapter,
                                  highScore: hScoreC.toString(),
                                  ID: widget.idUser,
                                ),
                              ));
                            },
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                SizedBox(
                                  width: 28,
                                  height: 28,
                                  child: Image.asset(
                                      'assets/images/AvatarChibi${widget.pathAvatar}.jpg'),
                                ),
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/FrameRank${widget.frameRank}.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 20),
                            child: Text(
                              widget.userName,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Container(
                              width: MediaQuery.of(context).size.width / 10,
                              height: MediaQuery.of(context).size.width / 10,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/Icon_sms.png'),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {},
                            child: Container(
                              width: MediaQuery.of(context).size.width / 10,
                              height: MediaQuery.of(context).size.width / 10,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/Icon_Gift.png'),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
          },
        ));
  }

  @override
  void deactivate() {
    _useLevel.cancel();

    super.deactivate();
  }
}
