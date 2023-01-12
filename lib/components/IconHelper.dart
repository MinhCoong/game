import 'package:flutter/material.dart';

class iconHelper extends StatelessWidget {
  String url;
  int quantity;
  iconHelper({Key? key, required this.url, required this.quantity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(left: 2, right: 2),
        decoration: BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image(
              image: AssetImage(url),
            ),
            Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.width / 10,
                  left: MediaQuery.of(context).size.width / 10),
              child: Text(
                quantity.toString(),
                // ignore: prefer_const_constructors
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontFamily: 'Horizon',
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
