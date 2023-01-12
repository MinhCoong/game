// ignore_for_file: file_names

import 'package:flutter/material.dart';

class BottomNavigationBarCustom extends StatefulWidget {
  const BottomNavigationBarCustom({super.key, required this.pageController});
  final PageController pageController;

  @override
  State<BottomNavigationBarCustom> createState() =>
      _BottomNavigationBarCustomState();
}

BottomNavigationBarItem _createBottomNavigationBarItem(
    String urlImg, String label) {
  return BottomNavigationBarItem(
    icon: SizedBox(
      width: 40,
      height: 40,
      child: Image.asset(
        urlImg,
        fit: BoxFit.cover,
      ),
    ),
    label: label,
  );
}

class _BottomNavigationBarCustomState extends State<BottomNavigationBarCustom> {
  int index = 2;
  void onItemTap(selectItems) {
    widget.pageController.jumpToPage(selectItems);
    setState(() {
      index = selectItems;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: index,
      onTap: onItemTap,
      type: BottomNavigationBarType.fixed,
      backgroundColor: const Color.fromARGB(255, 91, 54, 255),
      selectedFontSize: 12,
      unselectedFontSize: 10,
      showSelectedLabels: true,
      showUnselectedLabels: false,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      selectedItemColor: Colors.white,
      items: [
        _createBottomNavigationBarItem(
          'assets/images/IconRank.png',
          'RANK',
        ),
        _createBottomNavigationBarItem(
          'assets/images/icon_shop.png',
          'STORE',
        ),
        _createBottomNavigationBarItem(
          'assets/images/IconBattleNew.png',
          'PLAY GAME',
        ),
        _createBottomNavigationBarItem(
          'assets/images/icon_tickets.png',
          'EVEN',
        ),
        _createBottomNavigationBarItem(
          'assets/images/iconFriend.png',
          'FRIEND',
        ),
      ],
    );
  }
}
