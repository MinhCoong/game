// ignore_for_file: constant_identifier_names

import 'package:dc_marvel_app/components/ElvatedButtonCustom.dart';
import 'package:dc_marvel_app/components/buttonMode.dart';
import 'package:flutter/material.dart';
import '../view/play/playing_now.dart';

class showDialogPlayBattleNow extends StatefulWidget {
  const showDialogPlayBattleNow({
    Key? key,
  }) : super(key: key);

  @override
  State<showDialogPlayBattleNow> createState() =>
      _showDialogPlayBattleNowState();
}

// ignore: camel_case_types
enum theme { Nature, Funny, Geography, History, Human, Quiz_tips, Random }

class _showDialogPlayBattleNowState extends State<showDialogPlayBattleNow> {
  theme? themee = theme.Random;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.black.withOpacity(.2),
      title: const Text('Basic dialog title'),
      content: Container(
        width: MediaQuery.of(context).size.width,
        height: double.infinity,
        margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
        color: const Color.fromARGB(255, 255, 246, 117),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
                flex: 4,
                child: Column(children: [
                  Expanded(
                      flex: 2,
                      child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                          child: const Text(
                            "Play Now",
                            style: TextStyle(
                                fontSize: 35,
                                fontFamily: 'Horizon',
                                decoration: TextDecoration.none),
                          ))),
                  const Expanded(
                      child: Text('Choose theme',
                          style: TextStyle(
                            fontFamily: 'Horizon',
                            fontSize: 20,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w700,
                          ))),
                  Expanded(
                      child: RadioListTile<theme>(
                          activeColor: Colors.black,
                          title: const Text(
                            'Nature',
                          ),
                          value: theme.Nature,
                          groupValue: themee,
                          onChanged: (theme? value) {
                            setState(() {
                              themee = value;
                            });
                          })),
                  Expanded(
                      child: RadioListTile<theme>(
                          activeColor: Colors.black,
                          title: const Text(
                            'Funny',
                          ),
                          value: theme.Funny,
                          groupValue: themee,
                          onChanged: (theme? value) {
                            setState(() {
                              themee = value;
                            });
                          })),
                  Expanded(
                      child: RadioListTile<theme>(
                          activeColor: Colors.black,
                          title: const Text(
                            'Geography',
                          ),
                          value: theme.Geography,
                          groupValue: themee,
                          onChanged: (theme? value) {
                            setState(() {
                              themee = value;
                            });
                          })),
                  Expanded(
                      child: RadioListTile<theme>(
                          activeColor: Colors.black,
                          title: const Text(
                            'History',
                          ),
                          value: theme.History,
                          groupValue: themee,
                          onChanged: (theme? value) {
                            setState(() {
                              themee = value;
                            });
                          })),
                  Expanded(
                      child: RadioListTile<theme>(
                          activeColor: Colors.black,
                          title: const Text(
                            'Human',
                          ),
                          value: theme.Human,
                          groupValue: themee,
                          onChanged: (theme? value) {
                            setState(() {
                              themee = value;
                            });
                          })),
                  Expanded(
                      child: RadioListTile<theme>(
                          activeColor: Colors.black,
                          title: const Text(
                            'Quiz tips',
                          ),
                          value: theme.Quiz_tips,
                          groupValue: themee,
                          onChanged: (theme? value) {
                            setState(() {
                              themee = value;
                            });
                          })),
                  Expanded(
                      child: RadioListTile<theme>(
                    activeColor: Colors.black,
                    title: const Text(
                      'Random',
                    ),
                    value: theme.Random,
                    groupValue: themee,
                    onChanged: (theme? value) {
                      setState(() {
                        themee = value;
                      });
                    },
                  )),
                  const Expanded(
                      child: Text('Select mode',
                          style: TextStyle(
                            fontFamily: 'Horizon',
                            fontSize: 20,
                            color: Colors.black,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w700,
                          )))
                ])),
            Expanded(
              flex: 1,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width / 3,
                child: Row(
                  children: [
                    Expanded(
                        child: Container(
                            margin: const EdgeInsets.only(left: 5),
                            child: Column(children: [
                              Expanded(
                                  child: Button_Mode(
                                mode: 'Easy',
                              )),
                              Expanded(
                                  child: Button_Mode(
                                mode: 'Normal',
                              ))
                            ]))),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(right: 5),
                        child: Column(
                          children: [
                            Expanded(
                                child: Button_Mode(
                              mode: 'Hard',
                            )),
                            Expanded(
                              child: Button_Mode(
                                mode: 'Super',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 20),
                  width: MediaQuery.of(context).size.width / 4,
                  height: MediaQuery.of(context).size.width / 10,
                  child: ElvatedButtonCustom(
                    caption: 'Play',
                    colorBorder: Colors.black,
                    colorBackground: Colors.green,
                    opacity: 1,
                    colorTitle: Colors.black,
                    routePage: MaterialPageRoute(
                      builder: (context) => PlayingGame(
                        level: 1,
                        hightScore: 0,
                        chapter: 1,
                        diamond: 1,
                        exp: 1,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
