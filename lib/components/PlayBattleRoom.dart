// ignore_for_file: file_names, camel_case_types

import 'package:dc_marvel_app/components/CartDifficulty.dart';
import 'package:flutter/material.dart';

class showDialogPlayBattleRoom extends StatefulWidget {
  const showDialogPlayBattleRoom({
    Key? key,
  }) : super(key: key);

  @override
  State<showDialogPlayBattleRoom> createState() =>
      _showDialogPlayBattleRoomState();
}

class _showDialogPlayBattleRoomState extends State<showDialogPlayBattleRoom> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.black.withOpacity(.6),
      title: const Text('Basic dialog title'),
      content: Container(
        width: 400,
        height: 500,
        color: Colors.green,
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CartDifficulty(
                  text: "JiDuy",
                ),
                CartDifficulty(
                  text: "JiDuyy",
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CartDifficulty(
                  text: "JiDuyyy",
                ),
                CartDifficulty(
                  text: "JiDuyyyy",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
