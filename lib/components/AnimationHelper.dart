// ignore: file_names
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

class TimeRunHelp extends StatefulWidget {
  const TimeRunHelp({super.key});

  @override
  State<TimeRunHelp> createState() => _TimeRunHelpState();
}

class _TimeRunHelpState extends State<TimeRunHelp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 10), () async {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.1),
      body: Container(
        alignment: Alignment.center,
        child: TextAnimatorSequence(
          // ignore: sort_child_properties_last
          children: [
            TextAnimator(
              '10',
              incomingEffect: WidgetTransitionEffects.incomingScaleDown(),
              atRestEffect: WidgetRestingEffects.bounce(),
              outgoingEffect: WidgetTransitionEffects.outgoingScaleUp(),
              style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: -7,
                  fontSize: 64),
            ),
            TextAnimator(
              '9',
              incomingEffect: WidgetTransitionEffects.incomingScaleDown(),
              atRestEffect: WidgetRestingEffects.bounce(),
              outgoingEffect: WidgetTransitionEffects.outgoingScaleUp(),
              style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  fontSize: 64),
            ),
            TextAnimator(
              '8',
              incomingEffect: WidgetTransitionEffects.incomingScaleDown(),
              atRestEffect: WidgetRestingEffects.bounce(),
              outgoingEffect: WidgetTransitionEffects.outgoingScaleUp(),
              style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  fontSize: 64),
            ),
            TextAnimator(
              '7',
              incomingEffect: WidgetTransitionEffects.incomingScaleDown(),
              atRestEffect: WidgetRestingEffects.bounce(),
              outgoingEffect: WidgetTransitionEffects.outgoingScaleUp(),
              style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  fontSize: 64),
            ),
            TextAnimator(
              '6',
              incomingEffect: WidgetTransitionEffects.incomingScaleDown(),
              atRestEffect: WidgetRestingEffects.bounce(),
              outgoingEffect: WidgetTransitionEffects.outgoingScaleUp(),
              style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  fontSize: 64),
            ),
            TextAnimator(
              '5',
              incomingEffect: WidgetTransitionEffects.incomingScaleDown(),
              atRestEffect: WidgetRestingEffects.bounce(),
              outgoingEffect: WidgetTransitionEffects.outgoingScaleUp(),
              style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  fontSize: 64),
            ),
            TextAnimator(
              '4',
              incomingEffect: WidgetTransitionEffects.incomingScaleDown(),
              atRestEffect: WidgetRestingEffects.bounce(),
              outgoingEffect: WidgetTransitionEffects.outgoingScaleUp(),
              style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  fontSize: 64),
            ),
            TextAnimator(
              '3',
              incomingEffect: WidgetTransitionEffects.incomingScaleDown(),
              atRestEffect: WidgetRestingEffects.bounce(),
              outgoingEffect: WidgetTransitionEffects.outgoingScaleUp(),
              style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  fontSize: 64),
            ),
            TextAnimator(
              '2',
              incomingEffect: WidgetTransitionEffects.incomingScaleDown(),
              atRestEffect: WidgetRestingEffects.bounce(),
              outgoingEffect: WidgetTransitionEffects.outgoingScaleUp(),
              style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  fontSize: 64),
            ),
            TextAnimator(
              '1',
              incomingEffect: WidgetTransitionEffects.incomingScaleDown(),
              atRestEffect: WidgetRestingEffects.bounce(),
              outgoingEffect: WidgetTransitionEffects.outgoingScaleUp(),
              style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  fontSize: 64),
            ),
          ],
          transitionTime: const Duration(milliseconds: 390),
        ),
      ),
    );
  }
}

class BatAniMation extends StatefulWidget {
  const BatAniMation({super.key});

  @override
  State<BatAniMation> createState() => _BatAniMationState();
}

class _BatAniMationState extends State<BatAniMation> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(milliseconds: 2400), () async {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black.withOpacity(0.1),
        body: Container(
          alignment: Alignment.center,
          child: WidgetAnimator(
            incomingEffect: WidgetTransitionEffects.incomingScaleDown(),
            atRestEffect: WidgetRestingEffects.rotate(),
            child: Image(
              image: const AssetImage('assets/images/icon_bat.png'),
              width: MediaQuery.of(context).size.width,
            ),
          ),
        ));
  }
}

class HammerAnimation extends StatefulWidget {
  const HammerAnimation({super.key});

  @override
  State<HammerAnimation> createState() => _HammerAnimationState();
}

class _HammerAnimationState extends State<HammerAnimation> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(milliseconds: 500), () async {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(.0),
      body: Container(
          margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.width / 10,
              right: MediaQuery.of(context).size.width / 7),
          alignment: Alignment.topCenter,
          child: Text(
            '+5',
            style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Color.fromARGB(255, 21, 228, 255)),
          )),
    );
  }
}
