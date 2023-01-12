import 'package:dc_marvel_app/components/FrameHistory.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseDatabase.instance.ref();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.8),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: Stack(
              children: [
                Container(
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
                      'History',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.topRight,
                  padding: const EdgeInsets.only(top: 10, right: 10),
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.logout),
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 18,
            child: WidgetAnimator(
              incomingEffect: WidgetTransitionEffects.incomingSlideInFromLeft(),
              child: FirebaseAnimatedList(
                  query: _db
                      .child('historys/${_auth.currentUser!.uid}')
                      .limitToLast(20),
                  sort: (a, b) => (b.key!.compareTo(a.key!)),
                  itemBuilder: (context, snapshot, animation, index) {
                    return FrameHistory(
                      framehistory: 'assets/images/FrameSiver.png',
                      item: snapshot.child('report').value.toString() == 'win'
                          ? 'assets/images/iconwin.png'
                          : 'assets/images/iconlose.png',
                      time: snapshot.child('time').value.toString(),
                      point1: snapshot
                          .child('playerOne/highScore')
                          .value
                          .toString(),
                      point2: snapshot
                          .child('playerTwo/highScore')
                          .value
                          .toString(),
                      avatarOne:
                          snapshot.child('playerOne/image').value.toString(),
                      avatarTwo:
                          snapshot.child('playerTwo/image').value.toString(),
                      frameRankOne:
                          snapshot.child('playerOne/rank').value.toString(),
                      frameRankTwo:
                          snapshot.child('playerTwo/rank').value.toString(),
                      battle: snapshot.child('battle').value.toString(),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
