// ignore_for_file: prefer_const_constructors

import 'package:dc_marvel_app/view/LoginPhone/login_phone.dart';
import 'package:dc_marvel_app/view/LoginPhone/verify.dart';
import 'package:dc_marvel_app/view/page_main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute:
          FirebaseAuth.instance.currentUser == null ? 'phone' : 'home',
      routes: {
        'phone': (context) => LoginPhone(),
        'verify': (context) => Verify(),
        'home': (context) => PageMain(),
      },
    );
  }
}
