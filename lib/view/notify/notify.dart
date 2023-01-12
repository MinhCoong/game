import 'package:dc_marvel_app/components/FrameNotify.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

class Notify extends StatefulWidget {
  const Notify({super.key});

  @override
  State<Notify> createState() => _NotifyState();
}

class _NotifyState extends State<Notify> {
  final _db = FirebaseDatabase.instance.ref().child('friends');
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black.withOpacity(.6),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            Expanded(
              flex: 4,
              child: Container(
                margin: const EdgeInsets.all(15),
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage('assets/images/profile_background.png'),
                  fit: BoxFit.fill,
                )),
                child: Column(
                  children: [
                    Expanded(
                      child: WidgetAnimator(
                        incomingEffect:
                            WidgetTransitionEffects.incomingSlideInFromRight(),
                        child: Container(
                          margin: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width / 2.8,
                              top: MediaQuery.of(context).size.width / 50),
                          child: const Text(
                            'Notify',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontFamily: 'Horizon',
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 7,
                      child: WidgetAnimator(
                        incomingEffect:
                            WidgetTransitionEffects.incomingSlideInFromLeft(),
                        child: FirebaseAnimatedList(
                            query: _db
                                .child(_auth.currentUser!.uid)
                                .orderByChild('statusAdd')
                                .limitToLast(100)
                                .equalTo(0),
                            sort: (a, b) => b
                                .child('timeAdd')
                                .value
                                .toString()
                                .compareTo(a.child('timeAdd').value.toString()),
                            itemBuilder: (context, snapshot, animation, index) {
                              return FrameNotify(
                                idUser: snapshot.key.toString(),
                                frameRank:
                                    'assets/images/FrameRank${snapshot.child('frameRank').value.toString()}.png',
                                pathAvatar:
                                    'assets/images/AvatarChibi${snapshot.child('image').value.toString()}.jpg',
                                userName:
                                    snapshot.child('userName').value.toString(),
                                Time:
                                    snapshot.child('timeAdd').value.toString(),
                                Notication:
                                    '${snapshot.child('userName').value.toString()} sent a friend request',
                              );
                            }),
                      ),
                    ),
                    Expanded(
                        child: WidgetAnimator(
                      incomingEffect:
                          WidgetTransitionEffects.incomingSlideInFromLeft(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: (() {
                              Navigator.pop(context);
                            }),
                            child: Container(
                              width: MediaQuery.of(context).size.width / 5,
                              height: MediaQuery.of(context).size.width / 5,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image:
                                      AssetImage("assets/images/backhome.png"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
                  ],
                ),
              ),
            ),
            const Spacer()
          ],
        ));
  }
}
