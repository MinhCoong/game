// ignore_for_file: file_names

import 'package:dc_marvel_app/view/shop/pay.dart';
import 'package:flutter/material.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

class BorderShop extends StatefulWidget {
  const BorderShop(
      {super.key,
      required this.quantity,
      required this.path,
      required this.price,
      required this.text,
      required this.content,
      required this.pathPrice});
  final String quantity;
  final String path;
  final String price;
  final String text;
  final String pathPrice;
  final String content;
  @override
  State<BorderShop> createState() => _BorderShopState();
}

class _BorderShopState extends State<BorderShop> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: const BoxDecoration(
          // color: Colors.black.withOpacity(0.6),

          image: DecorationImage(
            image: AssetImage("assets/images/FrameShop.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(right: 10, top: 10),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    widget.quantity,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                widget.text,
                style: const TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
            Expanded(
              flex: 6,
              child: Image.asset(
                widget.path,
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                widget.content,
                style: const TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height / 70),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      widget.pathPrice,
                      width: 30,
                    ),
                    Text(
                      widget.price,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
