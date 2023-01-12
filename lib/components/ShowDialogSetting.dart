import 'dart:async';
import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';
import 'package:audioplayers/audioplayers.dart';

class ShowDialogSetting extends StatefulWidget {
  const ShowDialogSetting({super.key});

  @override
  State<ShowDialogSetting> createState() => _ShowDialogSettingState();
}

class _ShowDialogSettingState extends State<ShowDialogSetting> {
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseDatabase.instance.ref();
  final _controller = ValueNotifier<bool>(true);
  final _controllerTwo = ValueNotifier<bool>(true);
  bool _checked = false;
  late StreamSubscription _getMusicStatus;

  @override
  void initState() {
    super.initState();
    _getStatusMusic();
    _controller.addListener(() {
      setState(() {
        if (_controller.value) {
          _checked = true;
          _db.child('members/${_auth.currentUser!.uid}/statusMusic').set(true);
        } else {
          _checked = false;
          _db.child('members/${_auth.currentUser!.uid}/statusMusic').set(false);
        }
      });
    });
  }

  void _getStatusMusic() {
    _getMusicStatus =
        _db.child('members/${_auth.currentUser!.uid}').onValue.listen((event) {
      final data = event.snapshot.value as dynamic;
      setState(() {
        _controller.value = data['statusMusic'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(.7),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 6,
          ),
          const Align(
            alignment: Alignment.center,
            child: Text(
              'SETTING',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.w500,
                letterSpacing: 2.5,
              ),
            ),
          ),
          Column(
            children: [
              WidgetAnimator(
                incomingEffect:
                    WidgetTransitionEffects.incomingSlideInFromLeft(),
                child: Container(
                  margin: const EdgeInsets.only(
                      left: 20, right: 20, top: 25, bottom: 25),
                  height: 60,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/ButonSetting.png'),
                      // fit: BoxFit.cover,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        'assets/images/IconMusic.png',
                        height: 50,
                      ),
                      // ElevatedButton(
                      //     onPressed: () {
                      //       playerState == PlayerState.playing
                      //           ? pauseMusic()
                      //           : playMusic();
                      //     },
                      //     child: Text('data')),
                      AdvancedSwitch(
                        activeColor: Colors.blue,
                        inactiveColor: Colors.orange,
                        width: 80,
                        height: 40,
                        controller: _controller,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              WidgetAnimator(
                incomingEffect: WidgetTransitionEffects.incomingSlideInFromLeft(
                    delay: const Duration(milliseconds: 100)),
                child: Container(
                  margin: const EdgeInsets.only(
                      left: 20, right: 20, top: 25, bottom: 25),
                  height: 60,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/ButonSetting.png'),
                      // fit: BoxFit.cover,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        'assets/images/IconVolume.png',
                        height: 50,
                      ),
                      AdvancedSwitch(
                        activeColor: Colors.blue,
                        inactiveColor: Colors.orange,
                        width: 80,
                        height: 40,
                        controller: _controllerTwo,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              WidgetAnimator(
                incomingEffect: WidgetTransitionEffects.incomingSlideInFromLeft(
                    delay: const Duration(milliseconds: 200)),
                child: InkWell(
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.pushNamedAndRemoveUntil(
                        context, 'phone', (route) => false);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(
                        left: 20, right: 20, top: 25, bottom: 25),
                    height: 60,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/ButonSetting.png'),
                        // fit: BoxFit.cover,
                      ),
                    ),
                    child: const Align(
                      alignment: Alignment.center,
                      child: Text(
                        'SIGN OUT',
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          letterSpacing: 2.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 4.5,
                      left: MediaQuery.of(context).size.width / 25),
                  height: 60,
                  width: 60,
                  child: InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/ButtonBack.png'),
                          // fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void deactivate() {
    _getMusicStatus.cancel();

    super.deactivate();
  }
}
