// ignore_for_file: prefer_const_constructors

import 'package:dc_marvel_app/components/TextCustom.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

class LoginPhone extends StatefulWidget {
  const LoginPhone({super.key});
  static String verify = "";

  @override
  State<LoginPhone> createState() => _LoginPhoneState();
}

class _LoginPhoneState extends State<LoginPhone> {
  TextEditingController countryController = TextEditingController();
  var phone = "";
  @override
  void initState() {
    // TODO: implement initState
    countryController.text = "+84";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
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
                  width: size.width,
                  height: size.width - 150,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/LogoText3D.png"),
                      // fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height / 30,
              ),
              WidgetAnimator(
                incomingEffect: WidgetTransitionEffects.incomingScaleUp(),
                child: Column(
                  children: const [
                    TextCustom(
                      title:
                          'We need to register your phone without getting started!',
                    ),
                    TextCustom(
                      title: 'Let us help you change that.',
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height / 12,
              ),
              WidgetAnimator(
                incomingEffect:
                    WidgetTransitionEffects.incomingSlideInFromLeft(),
                child: Container(
                  height: 55,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: 40,
                        child: TextField(
                          readOnly: true,
                          style: TextStyle(color: Colors.white),
                          controller: countryController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Text(
                        "|",
                        style: TextStyle(fontSize: 33, color: Colors.grey),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: TextField(
                          style: TextStyle(color: Colors.white),
                          onChanged: (value) {
                            phone = value;
                          },
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "change number phone",
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: size.height / 20,
              ),
              WidgetAnimator(
                incomingEffect:
                    WidgetTransitionEffects.incomingSlideInFromRight(),
                child: SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    onPressed: () async {
                      try {
                        await FirebaseAuth.instance.verifyPhoneNumber(
                          phoneNumber: countryController.text + phone,
                          verificationCompleted:
                              (PhoneAuthCredential credential) {},
                          verificationFailed: (FirebaseAuthException e) {
                            if (e.code == 'invalid-phone-number') {
                              print('The provided phone number is not valid.');
                            }
                          },
                          codeSent: (String verificationId, int? resendToken) {
                            LoginPhone.verify = verificationId;
                            Navigator.pushNamed(context, 'verify');
                          },
                          codeAutoRetrievalTimeout: (String verificationId) {},
                        );
                      } catch (e) {
                        print('feild');
                      }
                    },
                    child: Text("Send the code"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
