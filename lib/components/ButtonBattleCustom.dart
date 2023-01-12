// ignore_for_file: file_names

import 'package:flutter/material.dart';

class ButtonBattleCustom extends StatefulWidget {
  const ButtonBattleCustom(
      {super.key,
      required this.title,
      required this.url,
      required this.fontSize,
      });
  final String title;
  final String url;
  final double fontSize;
  @override
  State<ButtonBattleCustom> createState() => _ButtonBattleCustomState();
}

class _ButtonBattleCustomState extends State<ButtonBattleCustom> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(widget.url),
          fit: BoxFit.fill,
        ),
      ),
      child: Center(
        child: Text(
          widget.title,
          style: TextStyle(
            fontSize: widget.fontSize,
            fontWeight: FontWeight.w900,
            color: Colors.black,
            fontFamily: 'Horizon',
          ),
        ),
      ),
    );
  }
}
