import 'package:dc_marvel_app/view/shop/pay.dart';
import 'package:flutter/material.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

import '../../components/BorderStore.dart';

class DiamondRecharge extends StatefulWidget {
  const DiamondRecharge({super.key});

  @override
  State<DiamondRecharge> createState() => _DiamondRechargeState();
}

class _DiamondRechargeState extends State<DiamondRecharge> {
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
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: WidgetAnimator(
              incomingEffect: WidgetTransitionEffects.incomingSlideInFromTop(),
              child: Container(
                margin: const EdgeInsets.only(top: 10),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/FrameTitle.png'),
                      fit: BoxFit.fill),
                ),
                child: const Align(
                  alignment: Alignment.center,
                  child: Text(
                    'BUY DIAMOND',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: WidgetAnimator(
              incomingEffect: WidgetTransitionEffects.incomingSlideInFromLeft(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            opaque: false,
                            pageBuilder: (BuildContext context, _, __) =>
                                const PayDiamond(),
                          ),
                        );
                      },
                      child: const BorderShop(
                        content: '',
                          quantity: '+15 Diamonds',
                          path: 'assets/images/IconDiamondOne.png',
                          price: '1',
                          text: '',
                          pathPrice: 'assets/images/IconDollar.png'),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: (() {
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            opaque: false,
                            pageBuilder: (BuildContext context, _, __) =>
                                const PayDiamond(),
                          ),
                        );
                      }),
                      child: const BorderShop(
                        content: '',
                          quantity: '+150 Diamonds',
                          path: 'assets/images/IconDiamondTwo.png',
                          price: '10',
                          text: '',
                          pathPrice: 'assets/images/IconDollar.png'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: WidgetAnimator(
              incomingEffect:
                  WidgetTransitionEffects.incomingSlideInFromRight(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: (() {
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            opaque: false,
                            pageBuilder: (BuildContext context, _, __) =>
                                const PayDiamond(),
                          ),
                        );
                      }),
                      child: const BorderShop(
                        content: '',
                          quantity: '+1500 Diamonds',
                          path: 'assets/images/IconDiamondThree.png',
                          price: '100',
                          text: '',
                          pathPrice: 'assets/images/IconDollar.png'),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: (() {
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            opaque: false,
                            pageBuilder: (BuildContext context, _, __) =>
                                const PayDiamond(),
                          ),
                        );
                      }),
                      child: const BorderShop(
                        content: '',
                          quantity: '+15000 Diamonds',
                          path: 'assets/images/IconDiamondFour.png',
                          price: '1000',
                          text: '',
                          pathPrice: 'assets/images/IconDollar.png'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(
            flex: 1,
          ),
        ],
      ),
    );
  }
}
