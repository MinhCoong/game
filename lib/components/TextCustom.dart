// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';

class TextCustom extends StatelessWidget {
  const TextCustom({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: Colors.white,
        letterSpacing: 1,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
