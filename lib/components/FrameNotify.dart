import 'package:dc_marvel_app/components/InfoFriend.dart';
import 'package:dc_marvel_app/view/notify/notify.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'score_game.dart';
import 'ShowDialogPlayProfile.dart';

class FrameNotify extends StatefulWidget {
  const FrameNotify(
      {Key? key,
      required this.frameRank,
      required this.pathAvatar,
      required this.userName,
      required this.Notication,
      required this.idUser,
      required this.Time})
      : super(key: key);

  final String frameRank;
  final String pathAvatar;
  final String userName;
  final String Time;
  final String Notication;
  final String idUser;

  @override
  State<FrameNotify> createState() => _FrameNotifyState();
}

class _FrameNotifyState extends State<FrameNotify> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final _db = FirebaseDatabase.instance.ref();
  String timeAdd = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timeAdd = widget.Time;
    final split = timeAdd.split(' ');
    final split2 = split[1].split('.');
    timeAdd = split2[0];
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
          image: AssetImage('assets/images/notify.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 25),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 16,
                    height: MediaQuery.of(context).size.width / 16,
                    child: Image.asset(widget.pathAvatar),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 10,
                    height: MediaQuery.of(context).size.width / 10,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(widget.frameRank),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 5, top: 7),
                        child: Text(
                          widget.userName,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 10, top: 7),
                        child: Text(
                          timeAdd,
                          style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    margin: const EdgeInsets.only(left: 5, top: 1, right: 10),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            widget.Notication,
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            if (_db
                                    .child('members')
                                    .child(auth.currentUser!.uid)
                                    .key !=
                                null) {
                              final snapshot = await _db
                                  .child(
                                      'friends/${FirebaseAuth.instance.currentUser!.uid}/${widget.idUser}')
                                  .get();

                              if (snapshot.exists) {
                                _db
                                    .child(
                                        'friends/${FirebaseAuth.instance.currentUser!.uid}/${widget.idUser}')
                                    .remove();
                                final snapshot1 = await _db
                                    .child(
                                        'friends/${widget.idUser}/${FirebaseAuth.instance.currentUser!.uid}')
                                    .get();

                                if (snapshot1.exists) {
                                  _db
                                      .child(
                                          'friends/${widget.idUser}/${FirebaseAuth.instance.currentUser!.uid}')
                                      .remove();
                                }
                              }
                            }
                          },
                          child: const Image(
                              image: AssetImage('assets/images/iconX.png')),
                        ),
                        InkWell(
                          onTap: () async {
                            if (_db
                                    .child('members')
                                    .child(auth.currentUser!.uid)
                                    .key !=
                                null) {
                              final snapshot = await _db
                                  .child(
                                      'friends/${FirebaseAuth.instance.currentUser!.uid}/${widget.idUser}')
                                  .get();

                              if (snapshot.exists) {
                                final addFriend = <String, dynamic>{
                                  'statusAdd': 2
                                };
                                _db
                                    .child(
                                        'friends/${auth.currentUser!.uid}/${widget.idUser}')
                                    .update(addFriend)
                                    .then((_) => print('friend has been Acp!'))
                                    .catchError((error) =>
                                        print('You got an error $error'));
                                final snapshot1 = await _db
                                    .child(
                                        'friends/${widget.idUser}/${FirebaseAuth.instance.currentUser!.uid}')
                                    .get();

                                if (snapshot1.exists) {
                                  final addFriend = <String, dynamic>{
                                    'statusAdd': 2
                                  };
                                  _db
                                      .child(
                                          'friends/${widget.idUser}/${FirebaseAuth.instance.currentUser!.uid}')
                                      .update(addFriend)
                                      .then(
                                          (_) => print('friend has been acp!'))
                                      .catchError((error) =>
                                          print('You got an error $error'));
                                }
                              }
                            }
                          },
                          child: const Image(
                            image: AssetImage('assets/images/iconCheck.png'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
