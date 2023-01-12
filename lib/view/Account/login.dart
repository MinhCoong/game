import 'package:dc_marvel_app/components/AdvancedSwitch.dart';
import 'package:dc_marvel_app/components/ElvatedButtonCustom.dart';
import 'package:dc_marvel_app/components/TextCustom.dart';
import 'package:dc_marvel_app/components/TextFieldCustom.dart';
import 'package:dc_marvel_app/view/account/forgot_password.dart';
import 'package:dc_marvel_app/view/page_main.dart';
import 'package:flutter/material.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

import 'signup.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // final _controller = ValueNotifier<bool>(false);

  bool status = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/Edit_Background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              WidgetAnimator(
                incomingEffect: WidgetTransitionEffects.incomingScaleDown(),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width - 150,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/Logo_Text_DCMarvel.png"),
                      // fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              WidgetAnimator(
                incomingEffect: WidgetTransitionEffects.incomingScaleUp(),
                child: const TextCustom(
                  title: "Login to your account",
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 20,
              ),
              WidgetAnimator(
                incomingEffect:
                    WidgetTransitionEffects.incomingSlideInFromLeft(),
                child: const TextFieldCustom(
                  label: 'Username',
                  icon: Icons.person,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 60,
              ),
              WidgetAnimator(
                incomingEffect:
                    WidgetTransitionEffects.incomingSlideInFromRight(),
                child: const TextFieldCustom(
                  label: 'Password',
                  icon: Icons.key,
                ),
              ),
              WidgetAnimator(
                incomingEffect:
                    WidgetTransitionEffects.incomingSlideInFromBottom(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const AdvancedSwitchCustom(),
                    TextButton(
                      onPressed: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ForgotPassword(),
                          ),
                        ),
                      },
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 10,
              ),
              WidgetAnimator(
                incomingEffect:
                    WidgetTransitionEffects.incomingSlideInFromBottom(),
                child: ElvatedButtonCustom(
                  caption: 'LOGIN',
                  colorBorder: Colors.white,
                  colorBackground: Colors.black,
                  colorTitle: Colors.white,
                  opacity: 1.0,
                  routePage: MaterialPageRoute(
                    builder: (context) => const PageMain(),
                  ),
                ),
              ),
              WidgetAnimator(
                incomingEffect:
                    WidgetTransitionEffects.incomingSlideInFromBottom(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const TextCustom(title: 'Don\'t have an account? '),
                    TextButton(
                      onPressed: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUp(),
                          ),
                        ),
                      },
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
