import 'package:flutter/material.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

class BonusFrameItem extends StatelessWidget {
  const BonusFrameItem({Key? key, required this.path}) : super(key: key);

  final String path;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 10,
      height: MediaQuery.of(context).size.width / 10,
      margin: const EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 160, 110, 17),
        border: Border.all(
          width: 2,
          color: const Color.fromARGB(255, 173, 127, 66),
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: Image.asset(path),
    );
  }
}
