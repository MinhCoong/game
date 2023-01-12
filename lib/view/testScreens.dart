import 'package:flutter/material.dart';

class TestScreend extends StatefulWidget {
  const TestScreend({super.key});

  @override
  State<TestScreend> createState() => _TestScreendState();
}

class _TestScreendState extends State<TestScreend> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Vào trận'),
      ),
    );
  }
}
