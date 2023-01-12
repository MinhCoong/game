import 'package:dc_marvel_app/components/ElvatedButtonCustom.dart';
import 'package:dc_marvel_app/components/TextCustom.dart';
import 'package:dc_marvel_app/components/TextFieldCustom.dart';
import 'package:flutter/material.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

import 'login.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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
                  title: "Create your account",
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 40,
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
                height: MediaQuery.of(context).size.height / 70,
              ),
              WidgetAnimator(
                incomingEffect:
                    WidgetTransitionEffects.incomingSlideInFromRight(),
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
                    WidgetTransitionEffects.incomingSlideInFromLeft(),
                child: const TextFieldCustom(
                  label: 'Password',
                  icon: Icons.key,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 70,
              ),
              WidgetAnimator(
                incomingEffect:
                    WidgetTransitionEffects.incomingSlideInFromBottom(),
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
                  'By registering, you are agreeing to our Terms of use and Privacy Policy.',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 20,
              ),
              WidgetAnimator(
                incomingEffect:
                    WidgetTransitionEffects.incomingSlideInFromBottom(),
                child: ElvatedButtonCustom(
                  caption: 'REGISTER',
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
