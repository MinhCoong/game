import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:dc_marvel_app/components/AppBarCustom.dart';
import 'package:dc_marvel_app/view/even.dart';
import 'package:dc_marvel_app/view/friend.dart';
import 'package:dc_marvel_app/view/rank.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../components/ButtomNavigationBarCustom.dart';
import '../components/FrameExInvite.dart';
import 'play/play_game.dart';
import 'shop/buyEnergy.dart';
import 'shop/diamond_recharge.dart';
import 'shop/store.dart';

class PageMain extends StatefulWidget {
  const PageMain({super.key});

  @override
  State<PageMain> createState() => _PageMainState();
}

class _PageMainState extends State<PageMain> {
  TextEditingController statusInvite = TextEditingController();
  final playMusic = AudioPlayer();
  bool? statusMusic;
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseDatabase.instance.ref();
  PageController pageController = PageController(initialPage: 2);
  List<Widget> pages = [
    const Rank(),
    const Store(),
    const PlayGame(),
    const Even(),
    const Friend(),
    const DiamondRecharge(),
    const BuyEnergy(),
  ];

  late StreamSubscription _getInviteStatus;

  @override
  void initState() {
    super.initState();
    _getPlayerOne();
    // playMusic.play(AssetSource('musics/nhacnen2.mp3'));
  }

  void _getPlayerOne() {
    _getInviteStatus =
        _db.child('members/${_auth.currentUser!.uid}').onValue.listen((event) {
      final data = event.snapshot.value as dynamic;
      setState(() {
        statusInvite.text = data['statusInvite'].toString();
        data['statusMusic']
            ? playMusic.play(AssetSource('musics/nhacnen2.mp3'))
            : playMusic.stop();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(45),
          child: AppBarCustom(
            pageController: pageController,
          ),
        ),
        body: Stack(
          children: [
            PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: pageController,
              children: pages,
              // onPageChanged: onPageChanged,
            ),
            statusInvite.text == "true" ? const FrameExInvite() : Container()
          ],
        ),
        bottomNavigationBar:
            BottomNavigationBarCustom(pageController: pageController),
      ),
    );
  }

  @override
  void deactivate() {
    _getInviteStatus.cancel();
    super.deactivate();
  }
}
