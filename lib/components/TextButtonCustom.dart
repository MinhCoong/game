// ignore_for_file: file_names

import 'package:dc_marvel_app/components/TextCustom.dart';
import 'package:flutter/material.dart';

import '../view/account/select_login.dart';

class TextButtonCustom extends StatefulWidget {
  const TextButtonCustom(
      {super.key, required this.text, required this.textButton});
  final String text;
  final String textButton;
  @override
  State<TextButtonCustom> createState() => _TextButtonCustomState();
}

class _TextButtonCustomState extends State<TextButtonCustom> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextCustom(title: widget.text),
        TextButton(
          onPressed: () => {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SelectLogin(),
              ),
            ),
          },
          child: Text(
            widget.textButton,
            style: const TextStyle(
              color: Colors.white,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
