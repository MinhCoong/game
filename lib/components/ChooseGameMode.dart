import 'package:flutter/material.dart';

class ChooseGameMode extends StatefulWidget {
  const ChooseGameMode({super.key, required this.caption});
  final String caption;

  @override
  State<ChooseGameMode> createState() => _ChooseGameModeState();
}

class _ChooseGameModeState extends State<ChooseGameMode> {
  Color colors = Colors.transparent;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        setState(() {
          if (colors == Colors.transparent) {
            colors = Colors.green;
          } else {
            colors = Colors.transparent;
          }
        });
      },
      child: Container(
        width: size.width / 2 - 20,
        height: size.height / 10,
        decoration: BoxDecoration(
          color: colors,
          border: Border.all(width: 1, color: Colors.green),
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        child: Center(
            child: Text(
          widget.caption,
          style: const TextStyle(color: Colors.white, fontSize: 20),
        )),
      ),
    );
  }
}
