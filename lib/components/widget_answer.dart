import 'package:flutter/material.dart';
class widget_Answer extends StatefulWidget {
  widget_Answer({super.key, required this.title});

  String title;
  @override
  State<widget_Answer> createState() => _widget_AnswerState();
}

class _widget_AnswerState extends State<widget_Answer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width / 10,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.black.withOpacity(0.5)),
      child: Center(
        child: Text(
          widget.title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
