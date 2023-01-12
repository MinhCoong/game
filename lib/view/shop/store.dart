import 'dart:async';

import 'package:dc_marvel_app/components/FrameEx.dart';
import 'package:flutter/material.dart';
import 'package:dc_marvel_app/components/BorderStore.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class Store extends StatefulWidget {
  const Store({super.key});

  @override
  State<Store> createState() => _StoreState();
}

class _StoreState extends State<Store> {
  final auth = FirebaseAuth.instance;
  final _db = FirebaseDatabase.instance.ref();
  int diamond = 0;
  int thor = 0;
  int spider = 0;
  int bat = 0;
  int shield = 0;
  late StreamSubscription _get;
  late StreamSubscription _gethelp;
  @override
  void initState() {
    super.initState();
    _getdata();
    _gethel();
  }

  void _getdata() {
    _get =
        _db.child('members/${auth.currentUser!.uid}').onValue.listen((event) {
      final data = event.snapshot.value as dynamic;
      if (mounted) {
        setState(() {
          diamond = data['diamond'];
        });
      }
    });
  }

  void _gethel() {
    _gethelp = _db
        .child('members/${auth.currentUser!.uid}/help')
        .onValue
        .listen((event) {
      final data = event.snapshot.value as dynamic;
      if (mounted) {
        setState(() {
          thor = data['thor'];
          spider = data['spider'];
          bat = data['bat'];
          shield = data['shield'];
        });
      }
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
        child: StreamBuilder(
          stream: _db.child('members/${auth.currentUser!.uid}/help').onValue,
          builder: ((context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              final data = Map<String, dynamic>.from(
                Map<String, dynamic>.from((snapshot.data as DatabaseEvent)
                    .snapshot
                    .value as Map<dynamic, dynamic>),
              );
              return Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: WidgetAnimator(
                      incomingEffect:
                          WidgetTransitionEffects.incomingSlideInFromTop(),
                      child: Container(
                        margin: const EdgeInsets.only(top: 10),
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/FrameTitle.png'),
                              fit: BoxFit.fill),
                        ),
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text(
                            'STORE',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 2.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: (() {
                              if (diamond >= 50) {
                                diamond -= 50;
                                _db
                                    .child(
                                        'members/${auth.currentUser!.uid}/diamond')
                                    .set(diamond);
                                thor += 1;
                                _db
                                    .child(
                                        'members/${auth.currentUser!.uid}/help/thor')
                                    .set(thor);
                              } else {
                                Navigator.of(context).push(
                                  PageRouteBuilder(
                                    opaque: false,
                                    pageBuilder:
                                        (BuildContext context, _, __) =>
                                            FrameEx(Ex: "Diamond not enough"),
                                  ),
                                );
                              }
                            }),
                            child: InkWell(
                              child: BorderShop(
                                  content: '+5s when haft time ',
                                  quantity: 'Owned:${data['thor']}',
                                  path: 'assets/images/icons_thor.png',
                                  price: '50',
                                  text: 'Hammer Thor',
                                  pathPrice: 'assets/images/IconDiamond.png'),
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: (() {
                              if (diamond >= 100) {
                                diamond -= 100;
                                _db
                                    .child(
                                        'members/${auth.currentUser!.uid}/diamond')
                                    .set(diamond);
                                spider += 1;
                                _db
                                    .child(
                                        'members/${auth.currentUser!.uid}/help/spider')
                                    .set(spider);
                              } else {
                                Navigator.of(context).push(
                                  PageRouteBuilder(
                                    opaque: false,
                                    pageBuilder:
                                        (BuildContext context, _, __) =>
                                            FrameEx(Ex: "Diamond not enough"),
                                  ),
                                );
                              }
                            }),
                            child: BorderShop(
                                content: '50/50',
                                quantity: 'Owned:${data['spider']}',
                                path: 'assets/images/icon_nhen.png',
                                price: '100',
                                text: 'Spider',
                                pathPrice: 'assets/images/IconDiamond.png'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: (() {
                              if (diamond >= 150) {
                                diamond -= 150;
                                _db
                                    .child(
                                        'members/${auth.currentUser!.uid}/diamond')
                                    .set(diamond);
                                bat += 1;
                                _db
                                    .child(
                                        'members/${auth.currentUser!.uid}/help/bat')
                                    .set(bat);
                              } else {
                                Navigator.of(context).push(
                                  PageRouteBuilder(
                                    opaque: false,
                                    pageBuilder:
                                        (BuildContext context, _, __) =>
                                            FrameEx(Ex: "Diamond not enough"),
                                  ),
                                );
                              }
                            }),
                            child: BorderShop(
                                content: 'Next question',
                                quantity: 'Owned:${data['bat']}',
                                path: 'assets/images/icons_doi.png',
                                price: '150',
                                text: 'Bat',
                                pathPrice: 'assets/images/IconDiamond.png'),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: (() {
                              if (diamond >= 100) {
                                diamond -= 100;
                                _db
                                    .child(
                                        'members/${auth.currentUser!.uid}/diamond')
                                    .set(diamond);
                                shield += 1;
                                _db
                                    .child(
                                        'members/${auth.currentUser!.uid}/help/shield')
                                    .set(shield);
                              } else {
                                Navigator.of(context).push(
                                  PageRouteBuilder(
                                    opaque: false,
                                    pageBuilder:
                                        (BuildContext context, _, __) =>
                                            FrameEx(Ex: "Diamond not enough"),
                                  ),
                                );
                              }
                            }),
                            child: BorderShop(
                                content: 'delay 10s',
                                quantity: 'Owned:${data['shield']}',
                                path: 'assets/images/icons_khien.png',
                                price: '100',
                                text: 'Shield',
                                pathPrice: 'assets/images/IconDiamond.png'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(flex: 1),
                ],
              );
            }
            return const CircularProgressIndicator();
          }),
        ));
  }

  @override
  void deactivate() {
    _get.cancel();
    _gethelp.cancel();
    super.deactivate();
  }
}
