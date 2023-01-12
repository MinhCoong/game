import 'package:flutter/material.dart';

class PlayerRoom extends StatefulWidget {
  const PlayerRoom({
    Key? key,
    required this.size,
    required this.path,
    required this.pathFrameRank,
  }) : super(key: key);

  final Size size;
  final String path;
  final String pathFrameRank;

  @override
  State<PlayerRoom> createState() => _PlayerRoomState();
}

class _PlayerRoomState extends State<PlayerRoom> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size.width / 4.5,
      height: widget.size.width / 4.5,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Image(
              image: AssetImage(widget.path),
              width: widget.size.width / 5.5,
              height: widget.size.width / 5.5,
            ),
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(widget.pathFrameRank.isEmpty
                    ? "assets/images/FrameRank0.png"
                    : "assets/images/FrameRank${widget.pathFrameRank}.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
