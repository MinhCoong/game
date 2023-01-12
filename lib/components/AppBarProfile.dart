import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:dc_marvel_app/components/ShowDialogFindBattle.dart';
import 'package:dc_marvel_app/components/ShowDialogPlayProfile.dart';
import 'package:dc_marvel_app/components/ShowDialogSetting.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

class AppBarProfile extends StatefulWidget {
  const AppBarProfile({
    Key? key,
  }) : super(key: key);

  @override
  State<AppBarProfile> createState() => _AppBarProfileState();
}

const colorizeColors = [
  Colors.white,
  Colors.blue,
  Colors.yellow,
  Colors.red,
];

const colorizeTextStyle = TextStyle(
  fontSize: 28.0,
  fontFamily: 'Horizon',
  color: Colors.white,
);

class _AppBarProfileState extends State<AppBarProfile> {
  final _db = FirebaseDatabase.instance.ref();
  final _auth = FirebaseAuth.instance;

  final getAvater = TextEditingController();
  final getRank = TextEditingController();
  late StreamSubscription _getAvatar;

  @override
  void initState() {
    super.initState();
    _getAvaterUser();
  }

  void _getAvaterUser() {
    _getAvatar =
        _db.child('members/${_auth.currentUser!.uid}').onValue.listen((event) {
      final data = event.snapshot.value as dynamic;
      setState(() {
        getAvater.text = data['image'].toString();
        getRank.text = data['frameRank'].toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            margin: const EdgeInsets.only(right: 10),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/BgProfileLeft.png"),
                fit: BoxFit.fill,
              ),
            ),
            child: Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(left: 10, top: 10),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      opaque: false,
                      pageBuilder: (BuildContext context, _, __) =>
                          const ShowDiaLogProfile(),
                    ),
                  );
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 11,
                      height: MediaQuery.of(context).size.width / 11,
                      child: Image.asset(getAvater.text == ""
                          ? 'assets/images/iconAddfriend.png'
                          : 'assets/images/AvatarChibi${getAvater.text}.jpg'),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 9,
                      height: MediaQuery.of(context).size.width / 9,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(getRank.text == ""
                              ? 'assets/images/FrameRank1.png'
                              : "assets/images/FrameRank${getRank.text}.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(bottom: 20),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/BgProfileBetween.png"),
                fit: BoxFit.fill,
              ),
            ),
            child: AnimatedTextKit(
              totalRepeatCount: 100,
              animatedTexts: [
                ColorizeAnimatedText(
                  'CHAPTER 1',
                  textStyle: colorizeTextStyle,
                  colors: colorizeColors,
                ),
                ColorizeAnimatedText(
                  'CHAPTER 2',
                  textStyle: colorizeTextStyle,
                  colors: colorizeColors,
                ),
                ColorizeAnimatedText(
                  'CHAPTER 3',
                  textStyle: colorizeTextStyle,
                  colors: colorizeColors,
                ),
                ColorizeAnimatedText(
                  'CHAPTER 4',
                  textStyle: colorizeTextStyle,
                  colors: colorizeColors,
                ),
                ColorizeAnimatedText(
                  'CHAPTER 5',
                  textStyle: colorizeTextStyle,
                  colors: colorizeColors,
                ),
                ColorizeAnimatedText(
                  'CHAPTER 6',
                  textStyle: colorizeTextStyle,
                  colors: colorizeColors,
                ),
                ColorizeAnimatedText(
                  'CHAPTER 7',
                  textStyle: colorizeTextStyle,
                  colors: colorizeColors,
                ),
                ColorizeAnimatedText(
                  'CHAPTER 8',
                  textStyle: colorizeTextStyle,
                  colors: colorizeColors,
                ),
              ],
              isRepeatingAnimation: true,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            alignment: Alignment.topRight,
            margin: const EdgeInsets.only(left: 10),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/BgProfileRight.png"),
                fit: BoxFit.fill,
              ),
            ),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                    opaque: false,
                    pageBuilder: (BuildContext context, _, __) =>
                        const ShowDialogSetting(),
                  ),
                );
              },
              child: Container(
                alignment: Alignment.topRight,
                margin: const EdgeInsets.only(right: 10, top: 10),
                width: MediaQuery.of(context).size.width / 8,
                height: MediaQuery.of(context).size.width / 8,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/icon_setting.png"),
                    // fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void deactivate() {
    _getAvatar.cancel();
    super.deactivate();
  }
}
