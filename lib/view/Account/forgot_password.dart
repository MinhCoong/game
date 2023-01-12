import 'package:dc_marvel_app/components/ElvatedButtonCustom.dart';
import 'package:dc_marvel_app/components/TextCustom.dart';
import 'package:dc_marvel_app/components/TextFieldCustom.dart';
import 'package:flutter/material.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

import 'login.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
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
                  title: "Forgot Password",
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 70,
              ),
              WidgetAnimator(
                incomingEffect: WidgetTransitionEffects.incomingScaleUp(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.person,
                      size: 50,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'JiDuy',
                      style: TextStyle(
                        fontSize: 26,
                        color: Colors.white,
                        letterSpacing: 3.0,
                        fontWeight: FontWeight.w700,
                      ),
                    )
                  ],
                ),
              ),
              WidgetAnimator(
                incomingEffect:
                    WidgetTransitionEffects.incomingSlideInFromLeft(),
                child: const TextFieldCustom(
                  label: 'Email Address',
                  icon: Icons.email,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 70,
              ),
              WidgetAnimator(
                incomingEffect:
                    WidgetTransitionEffects.incomingSlideInFromRight(),
                child: const TextFieldCustom(
                  label: 'New Password',
                  icon: Icons.key,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 70,
              ),
              WidgetAnimator(
                incomingEffect:
                    WidgetTransitionEffects.incomingSlideInFromLeft(),
                child: const TextFieldCustom(
                  label: 'Confirm password',
                  icon: Icons.key,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 70,
              ),
              WidgetAnimator(
                incomingEffect:
                    WidgetTransitionEffects.incomingSlideInFromBottom(),
                child: const Text(
                  'By forgetting the shared password, I will help you get the password when you forgot it during use.',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 15,
              ),
              WidgetAnimator(
                incomingEffect:
                    WidgetTransitionEffects.incomingSlideInFromBottom(),
                child: ElvatedButtonCustom(
                  caption: 'SUBMIT',
                  colorBorder: Colors.white,
                  colorBackground: Colors.black,
                  colorTitle: Colors.white,
                  opacity: 1.0,
                  routePage: MaterialPageRoute(
                    builder: (context) => const Login(),
                  ),
                ),
              ),
              WidgetAnimator(
                incomingEffect:
                    WidgetTransitionEffects.incomingSlideInFromBottom(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const TextCustom(title: 'Already have an account?'),
                    TextButton(
                      onPressed: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Login(),
                          ),
                        ),
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
