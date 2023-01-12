import 'package:flutter/material.dart';

class score extends StatelessWidget {
  String nameScore;
  String point;
  double fontsi;
  double fontsiPoint;
  bool isWin;
  score(
      {Key? key,
      required this.nameScore,
      required this.point,
      required this.fontsi,
      required this.isWin,
      required this.fontsiPoint})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: MediaQuery.of(context).size.width / 5),
      child: Row(
        children: [
          Text(
            nameScore,
            style: TextStyle(
              color: Color.fromARGB(255, 169, 221, 255),
              fontSize: fontsi,
              fontFamily: 'Horizon',
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Text(
              point,
              style: TextStyle(
                color: isWin
                    ? Color.fromARGB(255, 154, 255, 72)
                    : Color.fromARGB(255, 255, 18, 164),
                fontSize: fontsiPoint,
                fontFamily: 'Horizon',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
