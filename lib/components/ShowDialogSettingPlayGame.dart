import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ShowDialogSettingPlayGame extends StatefulWidget {
  const ShowDialogSettingPlayGame({super.key});

  @override
  State<ShowDialogSettingPlayGame> createState() =>
      _ShowDialogSettingPlayGameState();
}

class _ShowDialogSettingPlayGameState extends State<ShowDialogSettingPlayGame> {
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseDatabase.instance.ref();
  late StreamSubscription _getStatus;
  bool isON = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getStatusMusic();
  }

  Future<bool> _getStatusMusic() async {
    _getStatus = _db
        .child('members/${_auth.currentUser!.uid}')
        .onValue
        .listen((event) async {
      final data = event.snapshot.value as dynamic;
      if (mounted) {
        setState(() {
          isON = data['statusMusic'];
        });
      }
    });
    return isON;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(.95),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 30,
          ),
          const Align(
            alignment: Alignment.topCenter,
            child: Text(
              'Setting',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.w500,
                letterSpacing: 2.5,
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 10,
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FutureBuilder(
                      future: _getStatusMusic(),
                      builder:
                          (BuildContext context, AsyncSnapshot<bool> snapshot) {
                        if (!snapshot.hasData) {
                          return CircularProgressIndicator();
                        } else {
                          return InkWell(
                            onTap: (() {
                              final status = <String, dynamic>{
                                'statusMusic': !isON
                              };

                              _db
                                  .child('members/${_auth.currentUser!.uid}')
                                  .update(status);
                            }),
                            child: Container(
                              margin: const EdgeInsets.all(10),
                              padding:
                                  const EdgeInsets.fromLTRB(60, 10, 60, 10),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: isON
                                        ? const AssetImage(
                                            'assets/images/ButonSetting.png')
                                        : const AssetImage(
                                            'assets/images/ButonSettingRed.png'),
                                    fit: BoxFit.fill
                                    // fit: BoxFit.cover,
                                    ),
                              ),
                              child: Image.asset(
                                'assets/images/IconMusic.png',
                                height: 30,
                              ),
                            ),
                          );
                        }
                      }),
                  Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.fromLTRB(60, 10, 60, 10),
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/ButonSetting.png'),
                          fit: BoxFit.fill
                          // fit: BoxFit.cover,
                          ),
                    ),
                    child: Image.asset(
                      'assets/images/IconVolume.png',
                      height: 30,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context, false);
                    },
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.fromLTRB(60, 10, 60, 10),
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/ButonSetting.png'),
                            fit: BoxFit.fill
                            // fit: BoxFit.cover,
                            ),
                      ),
                      child: Image.asset(
                        'assets/images/start.png',
                        height: 30,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.popUntil(context, ModalRoute.withName('home'));
                    },
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.fromLTRB(60, 10, 60, 10),
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/ButonSetting.png'),
                            fit: BoxFit.fill
                            // fit: BoxFit.cover,
                            ),
                      ),
                      child: Image.asset(
                        'assets/images/home.png',
                        height: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void deactivate() {
    _getStatus.cancel();
    super.deactivate();
  }
}
