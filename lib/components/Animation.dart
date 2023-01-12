import 'package:flutter/material.dart';

class AnimatedLogo extends AnimatedWidget {
  const AnimatedLogo({super.key, required Animation<double> animation})
      : super(listenable: animation);

  static final _sizeTween = Tween<double>(begin: 350, end: 100);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        height: _sizeTween.evaluate(animation),
        width: _sizeTween.evaluate(animation),
        child: Image.asset(
          "assets/images/LogoText3D.png",
        ),
      ),
    );
  }
}

class LogoAnimation extends StatefulWidget {
  const LogoAnimation({super.key});

  @override
  State<LogoAnimation> createState() => _LogoAnimationState();
}

class _LogoAnimationState extends State<LogoAnimation>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 3), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.bounceIn)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) => AnimatedLogo(animation: animation);

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
