import 'package:flutter/material.dart';

class Icon_helper extends StatefulWidget {
  Icon_helper({super.key, required this.url, required this.items});

  String url;
  int items;
  @override
  State<Icon_helper> createState() => _Icon_helperState();
}

class _Icon_helperState extends State<Icon_helper> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 2,
          child: Image(
            image: AssetImage(widget.url),
            width: MediaQuery.of(context).size.width / 7,
            height: MediaQuery.of(context).size.width / 7,
          ),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.topCenter,
            child: Text(
              widget.items.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
