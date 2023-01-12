import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'FrameInvateFriend.dart';

class InviteFriend extends StatefulWidget {
  const InviteFriend({super.key, required this.roomId});
  final String roomId;

  @override
  State<InviteFriend> createState() => _InviteFriendState();
}

class _InviteFriendState extends State<InviteFriend> {
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseDatabase.instance.ref();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(.7),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                ),
              ),
              Expanded(
                child: FirebaseAnimatedList(
                    query: _db.child('friends/${_auth.currentUser!.uid}'),
                    itemBuilder: (context, snapshot, animation, index) {
                      if (snapshot.child('statusAdd').value.toString() == "2") {
                        return FrameInvateFriend(
                          frameRank:
                              snapshot.child('frameRank').value.toString(),
                          pathAvatar: snapshot.child('image').value.toString(),
                          userName: snapshot.child('userName').value.toString(),
                          pathFriend: snapshot.key.toString(),
                          roomId: widget.roomId,
                        );
                      } else {
                        return Container();
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
