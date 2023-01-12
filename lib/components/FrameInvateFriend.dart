// ignore: file_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class FrameInvateFriend extends StatefulWidget {
  const FrameInvateFriend({
    Key? key,
    required this.frameRank,
    required this.pathAvatar,
    required this.userName,
    required this.pathFriend,
    required this.roomId,
  }) : super(key: key);

  final String frameRank;
  final String pathAvatar;
  final String userName;
  final String pathFriend;
  final String roomId;

  @override
  State<FrameInvateFriend> createState() => _FrameInvateFriendState();
}

class _FrameInvateFriendState extends State<FrameInvateFriend> {
  final _db = FirebaseDatabase.instance.ref();
  final _auth = FirebaseAuth.instance;
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
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Container(
              margin: const EdgeInsets.only(left: 10),
              child: Row(
                children: [
                  Stack(
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
                                "assets/images/FrameRank${widget.frameRank}.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
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
          Container(
            margin: const EdgeInsets.all(10),
            child: InkWell(
              onTap: () {
                
                _db
                    .child('members/${widget.pathFriend}')
                    .update({'statusInvite': true, 'roomId': widget.roomId});
              },
              child: Image.asset(
                'assets/images/iconAddfriend.png',
              ),
            ),
          )
        ],
      ),
    );
  }
}
