import 'package:flutter/material.dart';

class Card_player_wFind extends StatefulWidget {
  Card_player_wFind({super.key, required this.url, required this.Name});

  String url;
  String Name;
  @override
  State<Card_player_wFind> createState() => _Card_player_wFindState();
}

class _Card_player_wFindState extends State<Card_player_wFind> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              widget.url,
              height: 76,
            ),
            Image.asset(
              'assets/images/BoderAvatar2.png',
              height: 120,
            ),
          ],
        ),
        Text(
          widget.Name,
          style: const TextStyle(
            color: Colors.yellow,
            fontSize: 20,
            fontFamily: 'Horizon',
            fontWeight: FontWeight.w700,
          ),
        )
      ],
    );
  }
}
