import 'package:flutter/material.dart';

class CartDifficulty extends StatefulWidget {
  const CartDifficulty({super.key, required this.text});
  final String text;

  @override
  State<CartDifficulty> createState() => _CartDifficultyState();
}

class _CartDifficultyState extends State<CartDifficulty> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      width: 100,
      height: 100,
      // color: Colors.white,
      child: ElevatedButton(
        child: Text(widget.text),
        onPressed: () {},
      ),
    );
  }
}
