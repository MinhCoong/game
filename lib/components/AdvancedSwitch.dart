// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';

class AdvancedSwitchCustom extends StatefulWidget {
  const AdvancedSwitchCustom({super.key});

  @override
  State<AdvancedSwitchCustom> createState() => _AdvancedSwitchCustomState();
}

class _AdvancedSwitchCustomState extends State<AdvancedSwitchCustom> {
  final _controller = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return AdvancedSwitch(
      activeColor: Colors.green,
      inactiveColor: Colors.grey,
      // activeChild: Text('Yellow'),
      // inactiveChild: Text('Indigo'),
      width: 50,
      height: 25,
      controller: _controller,
    );
  }
}
