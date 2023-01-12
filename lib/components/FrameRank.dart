import 'package:flutter/material.dart';

import 'InfoFriend.dart';

class FrameRank extends StatefulWidget {
  const FrameRank({
    Key? key,
    required this.frameRank,
    required this.pathAvatar,
    required this.rank,
    required this.userName,
    required this.pointRank, required this.frame,
  }) : super(key: key);

  final String frameRank;
  final String pathAvatar;
  final String rank;
  final String userName;
  final String pointRank;
  final String frame;

  @override
  State<FrameRank> createState() => _FrameRankState();
}

class _FrameRankState extends State<FrameRank> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(widget.frame),
          fit: BoxFit.fill,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              margin: const EdgeInsets.only(left: 10),
              child: Text(
                widget.rank,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Row(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 28,
                      height: 28,
                      child: Image.asset(widget.pathAvatar),
                    ),
                    Container(
                      width: 40,
                      height: 40,
                      decoration:  BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(widget.frameRank),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: Text(
                    widget.userName,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              margin: const EdgeInsets.only(left: 20),
              child: Text(
                widget.pointRank,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
