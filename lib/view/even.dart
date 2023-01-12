import 'package:flutter/material.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

import '../components/FrameEven.dart';

class Even extends StatefulWidget {
  const Even({super.key});

  @override
  State<Even> createState() => _EvenState();
}

class _EvenState extends State<Even> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/galaxy.gif"),
          fit: BoxFit.fill,
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            WidgetAnimator(
              incomingEffect: WidgetTransitionEffects.incomingSlideInFromBottom(
                delay: const Duration(milliseconds: 0),
              ),
              child: const FrameEven(
                num: 100,
                pathFrame: "assets/images/FrameEvenTwo.png",
                pathItemOne: 'assets/images/IconDiamond.png',
                pathItemTwo: 'assets/images/IconSet.png',
              ),
            ),
            WidgetAnimator(
              incomingEffect: WidgetTransitionEffects.incomingSlideInFromBottom(
                delay: const Duration(milliseconds: 200),
              ),
              child: const FrameEven(
                num: 110,
                pathFrame: "assets/images/FrameEven.png",
                pathItemOne: 'assets/images/icon_nhen.png',
                pathItemTwo: 'assets/images/icons_khien.png',
              ),
            ),
            WidgetAnimator(
              incomingEffect: WidgetTransitionEffects.incomingSlideInFromBottom(
                delay: const Duration(milliseconds: 400),
              ),
              child: const FrameEven(
                num: 120,
                pathFrame: "assets/images/FrameEvenThree.png",
                pathItemOne: 'assets/images/icons_doi.png',
                pathItemTwo: 'assets/images/icons_thor.png',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
