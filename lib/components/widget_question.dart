import 'package:dc_marvel_app/components/widget_answer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class widget_Question extends StatelessWidget {
  widget_Question({super.key, required this.title});

  String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: Border.all(width: 1, color: Colors.white)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              Text(
                '30',
                style: TextStyle(color: Colors.white),
              ),
              Icon(
                Icons.alarm,
                color: Colors.green,
              )
            ],
          )
        ],
      ),
    );
  }
}
