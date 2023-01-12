// ignore_for_file: file_names
import 'package:flutter/material.dart';
import '../view/play/playing_now.dart';

class ChapterImage extends StatefulWidget {
  const ChapterImage({Key? key, required this.path, required this.hightScore})
      : super(key: key);
  final String path;
  final String hightScore;

  @override
  State<ChapterImage> createState() => _ChapterImageState();
}

class _ChapterImageState extends State<ChapterImage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: MediaQuery.of(context).size.width / 20,
        top: MediaQuery.of(context).size.height / 40,
      ),
      width: MediaQuery.of(context).size.width / 1.1,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(widget.path),
        ),
      ),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Text(
          widget.hightScore != '' ? 'Highscore: ${widget.hightScore}' : '',
          style: const TextStyle(
            fontFamily: 'horizon',
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.w500,
            letterSpacing: 2.5,
          ),
        ),
      ),
    );
  }
}

class ItemChappter extends StatelessWidget {
  const ItemChappter(
      {Key? key,
      required this.chapter,
      required this.level,
      required this.exp,
      required this.hightScore,
      required this.diamond,
      required this.numberChappter,
      required this.path})
      : super(key: key);
  final int chapter;
  final int level;
  final int exp;
  final int hightScore;
  final int diamond;
  final int numberChappter;
  final String path;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: chapter < numberChappter
          ? null
          : () {
              Navigator.of(context).push(
                PageRouteBuilder(
                  opaque: false,
                  pageBuilder: (BuildContext context, _, __) => PlayingGame(
                      level: level,
                      exp: exp,
                      hightScore: hightScore,
                      chapter: chapter >= numberChappter ? numberChappter : 1,
                      diamond: diamond),
                ),
              );
            },
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(
              left: MediaQuery.of(context).size.width / 20,
              top: MediaQuery.of(context).size.height / 40,
              bottom: MediaQuery.of(context).size.height / 7,
            ),
            width: MediaQuery.of(context).size.width / 1.1,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(path),
              ),
            ),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                chapter >= numberChappter ? 'Highscore: $hightScore' : '',
                style: const TextStyle(
                  fontFamily: 'horizon',
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 2.5,
                ),
              ),
            ),
          ),
          chapter >= numberChappter
              ? Container(
                  alignment: Alignment.bottomCenter,
                  margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.width / 2.3,
                  ),
                )
              : Container(),
          Container(
            margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height / 30),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: chapter < numberChappter
                ? Colors.black.withOpacity(.6)
                : Colors.black.withOpacity(.0),
            child: chapter < numberChappter
                ? const Image(
                    image: AssetImage('assets/images/iconLockinChapter.png'),
                  )
                : Container(),
          )
        ],
      ),
    );
  }
}
