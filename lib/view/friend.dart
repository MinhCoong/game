import 'package:dc_marvel_app/components/FrameFriend.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

class Friend extends StatefulWidget {
  const Friend({super.key});

  @override
  State<Friend> createState() => _FriendState();
}

class _FriendState extends State<Friend> {
  final _db = FirebaseDatabase.instance.ref().child('friends');
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/galaxy.gif"),
          fit: BoxFit.cover,
        ),
      ),
      // color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: WidgetAnimator(
              incomingEffect: WidgetTransitionEffects.incomingSlideInFromTop(),
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
                    'FRIEND',
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
          ),
          Expanded(
            flex: 12,
            child: WidgetAnimator(
              incomingEffect: WidgetTransitionEffects.incomingSlideInFromLeft(),
              child: FirebaseAnimatedList(
                  query: _db
                      .child(_auth.currentUser!.uid)
                      .orderByChild('statusAdd')
                      .limitToLast(100)
                      .equalTo(2),
                  sort: (a, b) => b
                      .child('timeAdd')
                      .value
                      .toString()
                      .compareTo(a.child('timeAdd').value.toString()),
                  itemBuilder: (context, snapshot, animation, index) {
                    return FrameFriend(
                      idUser: snapshot.key.toString(),
                      frameRank: snapshot.child('frameRank').value.toString(),
                      pathAvatar: snapshot.child('image').value.toString(),
                      userName: snapshot.child('userName').value.toString(),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
