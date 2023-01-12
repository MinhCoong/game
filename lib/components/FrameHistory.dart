// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class FrameHistory extends StatefulWidget {
  const FrameHistory(
      {super.key,
      required this.framehistory,
      required this.item,
      required this.time,
      required this.point1,
      required this.point2,
      required this.avatarOne,
      required this.avatarTwo,
      required this.frameRankOne,
      required this.frameRankTwo,
      required this.battle});
  final framehistory;
  final item;
  final time;
  final String battle;
  final String point1;
  final String point2;
  final String avatarOne;
  final String avatarTwo;
  final String frameRankOne;
  final String frameRankTwo;
  @override
  State<FrameHistory> createState() => _FrameHistoryState();
}

class _FrameHistoryState extends State<FrameHistory> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(widget.framehistory),
          fit: BoxFit.fill,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 10, top: 5),
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 28,
                          height: 28,
                          child: Image.asset(
                              'assets/images/AvatarChibi${widget.avatarOne}.jpg'),
                        ),
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  "assets/images/FrameRank${widget.frameRankOne}.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      widget.point1,
                      // ignore: prefer_const_constructors
                      style: TextStyle(
                          fontSize: 10,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              const Image(
                image: AssetImage('assets/images/vsbattle.png'),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10, top: 5),
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 28,
                          height: 28,
                          child: Image.asset(
                              'assets/images/AvatarChibi${widget.avatarTwo}.jpg'),
                        ),
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  "assets/images/FrameRank${widget.frameRankTwo}.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      widget.point2,
                      style: const TextStyle(
                          fontSize: 10,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Text(widget.battle),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 6,
                height: MediaQuery.of(context).size.width / 12,
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(widget.item),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Text(
                widget.time,
                style: const TextStyle(fontSize: 10, color: Colors.black),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
