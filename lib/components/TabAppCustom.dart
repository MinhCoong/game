// ignore_for_file: file_names

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class TabAppBarCustom extends StatefulWidget {
  const TabAppBarCustom(
      {super.key,
      required this.title,
      required this.urlOne,
      required this.urlTwo,
      required this.color,
      required this.pageController,
      required this.jumpToPage});
  final String title;
  final String urlOne;
  final String urlTwo;
  final Color color;
  final PageController pageController;
  final int jumpToPage;

  @override
  State<TabAppBarCustom> createState() => _TabAppBarCustomState();
}

class _TabAppBarCustomState extends State<TabAppBarCustom> {
  final auth = FirebaseAuth.instance;
  final _db = FirebaseDatabase.instance.ref();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _db.child('members/${auth.currentUser!.uid}').onValue,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            final data = Map<String, dynamic>.from(
              Map<String, dynamic>.from((snapshot.data as DatabaseEvent)
                  .snapshot
                  .value as Map<dynamic, dynamic>),
            );

            return Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    // width: 75,
                    width: MediaQuery.of(context).size.width / 6,
                    height: 15,
                    color: Colors.black,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            width: 50 *
                                (double.parse(data['energy'].toString()) / 18),
                            color: widget.color,
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            widget.title,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(widget.urlOne),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(widget.urlTwo),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: InkWell(
                      onTap: () {
                        widget.pageController.jumpToPage(widget.jumpToPage);
                      },
                    ),
                  ),
                ),
              ],
            );
          }
          return CircularProgressIndicator();
        });
  }
}
