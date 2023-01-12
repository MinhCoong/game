import 'package:flutter/material.dart';

class Answer extends StatefulWidget {
  const Answer({
    Key? key,
    required this.title,
    required this.caption,
  }) : super(key: key);
  final String title;
  final String caption;

  @override
  State<Answer> createState() => _AnswerState();
}

class _AnswerState extends State<Answer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/FrameAnswer1.png"),
          fit: BoxFit.fill,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              widget.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              margin: const EdgeInsets.only(right: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.caption,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
