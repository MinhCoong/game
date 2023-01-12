import 'dart:async';

import 'package:flutter/material.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

import '../../components/BorderStore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import '../../components/FrameEx.dart';

class BuyEnergy extends StatefulWidget {
  const BuyEnergy({super.key});

  @override
  State<BuyEnergy> createState() => _BuyEnergyState();
}

class _BuyEnergyState extends State<BuyEnergy> {
  final auth = FirebaseAuth.instance;
  final _db = FirebaseDatabase.instance.ref();
  int diamond = 0;
  int energy = 0;
  late StreamSubscription _get;
  @override
  void initState() {
    super.initState();
    _getenergy();
  }

  void _getenergy() {
    _get =
        _db.child('members/${auth.currentUser!.uid}').onValue.listen((event) {
      final data = event.snapshot.value as dynamic;
      if (mounted) {
        setState(() {
          diamond = data['diamond'];
          energy = data['energy'];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/galaxy.gif"),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: WidgetAnimator(
              incomingEffect: WidgetTransitionEffects.incomingSlideInFromTop(),
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
                    'BUY ENERGY',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
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
                    onTap: () {
                      if (diamond >= 50) {
                        diamond -= 50;
                        _db
                            .child('members/${auth.currentUser!.uid}/diamond')
                            .set(diamond);
                        energy += 5;
                        _db
                            .child('members/${auth.currentUser!.uid}/energy')
                            .set(energy);
                      } else {
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            opaque: false,
                            pageBuilder: (BuildContext context, _, __) =>
                                FrameEx(Ex: "Diamond not enough"),
                          ),
                        );
                      }
                    },
                    child: const BorderShop(
                      content: '',
                      quantity: '+5 Energy',
                      path: 'assets/images/IconSet.png',
                      price: '50',
                      text: '',
                      pathPrice: 'assets/images/IconDiamond.png',
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      if (diamond >= 100) {
                        diamond -= 100;
                        _db
                            .child('members/${auth.currentUser!.uid}/diamond')
                            .set(diamond);
                        energy += 10;
                        _db
                            .child('members/${auth.currentUser!.uid}/energy')
                            .set(energy);
                      } else {
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            opaque: false,
                            pageBuilder: (BuildContext context, _, __) =>
                                FrameEx(Ex: "Diamond not enough"),
                          ),
                        );
                      }
                    },
                    child: const BorderShop(
                      content: '',
                      quantity: '+10 Energy',
                      path: 'assets/images/IconEnergyOne.png',
                      price: '100',
                      text: '',
                      pathPrice: 'assets/images/IconDiamond.png',
                    ),
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
                    onTap: () {
                      if (diamond >= 150) {
                        diamond -= 150;
                        _db
                            .child('members/${auth.currentUser!.uid}/diamond')
                            .set(diamond);
                        energy += 15;
                        _db
                            .child('members/${auth.currentUser!.uid}/energy')
                            .set(energy);
                      } else {
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            opaque: false,
                            pageBuilder: (BuildContext context, _, __) =>
                                FrameEx(Ex: "Diamond not enough"),
                          ),
                        );
                      }
                    },
                    child: const BorderShop(
                        content: '',
                        quantity: '+15 Energy',
                        path: 'assets/images/IconEnergyTwo.png',
                        price: '150',
                        text: '',
                        pathPrice: 'assets/images/IconDiamond.png'),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      if (diamond >= 200) {
                        diamond -= 200;
                        _db
                            .child('members/${auth.currentUser!.uid}/diamond')
                            .set(diamond);
                        energy += 20;
                        _db
                            .child('members/${auth.currentUser!.uid}/energy')
                            .set(energy);
                      } else {
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            opaque: false,
                            pageBuilder: (BuildContext context, _, __) =>
                                FrameEx(Ex: "Diamond not enough"),
                          ),
                        );
                      }
                    },
                    child: const BorderShop(
                        content: '',
                        quantity: '+20 Energys',
                        path: 'assets/images/IconEnergyThree.png',
                        price: '200',
                        text: '',
                        pathPrice: 'assets/images/IconDiamond.png'),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(
            flex: 1,
          ),
        ],
      ),
    );
  }

  @override
  void deactivate() {
    _get.cancel();

    super.deactivate();
  }
}
