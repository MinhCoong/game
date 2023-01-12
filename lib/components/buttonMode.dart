// ignore: file_names
import 'package:flutter/material.dart';

class Button_Mode extends StatefulWidget {
  Button_Mode({super.key, required this.mode});

  String mode;
  @override
  State<Button_Mode> createState() => _Button_ModeState();
}

class _Button_ModeState extends State<Button_Mode> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      width: double.infinity,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: Colors.white, onPrimary: Colors.black),
          onPressed: (() {}),
          child: Text(widget.mode)),
    );
  }
}
