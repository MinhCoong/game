import 'package:flutter/material.dart';

class FramePay extends StatefulWidget {
  const FramePay({super.key, required this.text, required this.txt});
  final String text;
  final String txt;
  @override
  State<FramePay> createState() => _FramePayState();
}

class _FramePayState extends State<FramePay> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            widget.text,
            style: const TextStyle(
                fontSize: 15,
                fontFamily: 'Horizon',
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            widget.txt,
            style: const TextStyle(
                fontSize: 15,
                fontFamily: 'Horizon',
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
      ],
    );
  }
}
