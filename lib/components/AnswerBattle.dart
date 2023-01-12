import 'package:flutter/material.dart';

class AnswerBattle extends StatefulWidget {
  const AnswerBattle({
    Key? key,
    required this.title,
    required this.caption,
    required this.frameAnswer,
  }) : super(key: key);
  final String title;
  final String caption;
  final String frameAnswer;

  @override
  State<AnswerBattle> createState() => _AnswerBattleState();
}

class _AnswerBattleState extends State<AnswerBattle> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(widget.frameAnswer),
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
