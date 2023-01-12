import 'package:flutter/material.dart';

class infoProfle extends StatelessWidget {
  String Url;
  int x;
  // ignore: non_constant_identifier_names
  infoProfle({Key? key, required this.Url, required this.x}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Column(
        children: [
          Expanded(
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 5,
              height: MediaQuery.of(context).size.width / 5,
              child: Image.asset(Url),
            ),
          ),
          Expanded(
            child: Text(
              x.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontFamily: 'Horizon',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
