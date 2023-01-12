import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

class FrameEx extends StatefulWidget {
  const FrameEx({super.key, required this.Ex});
  final String Ex;

  @override
  State<FrameEx> createState() => _FrameExState();
}

class _FrameExState extends State<FrameEx> {
  late Timer time;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    time = Timer(const Duration(seconds: 5), () {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.5),
      body: Center(
        child: InkWell(
          onTap: () {
            time.cancel();
            Navigator.pop(context);
          },
          child: WidgetAnimator(
            incomingEffect: WidgetTransitionEffects.incomingScaleDown(),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width / 2,
              padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: const DecorationImage(
                  image: AssetImage("assets/images/frameEx.png"),
                ),
              ),
              child: Column(
                children: [
                  const Expanded(
                    child: Text(
                      'Notify',
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          widget.Ex,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
