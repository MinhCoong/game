import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class DropDownSelectDiamond extends StatefulWidget {
  const DropDownSelectDiamond({super.key});

  @override
  State<DropDownSelectDiamond> createState() => _DropDownSelectDiamondState();
}

class _DropDownSelectDiamondState extends State<DropDownSelectDiamond> {
  final List<String> items = [
    '10',
    '100',
    '1000',
    '10000',
  ];
  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        dropdownDecoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        buttonDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: Colors.green,
        ),
        hint: const Text(
          'Diamond',
          style: TextStyle(
            fontSize: 14,
            color: Colors.white,
          ),
        ),
        items: items
            .map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                      Image.asset(
                        'assets/images/IconDiamond.png',
                        width: 20,
                        height: 20,
                      )
                    ],
                  ),
                ))
            .toList(),
        value: selectedValue,
        onChanged: (value) {
          setState(() {
            selectedValue = value as String;
          });
        },
        icon: const Icon(
          Icons.menu,
          color: Colors.white,
        ),
        buttonHeight: 40,
        buttonWidth: MediaQuery.of(context).size.width / 3,
        itemHeight: 40,
        buttonPadding: const EdgeInsets.only(left: 14, right: 14),
      ),
    );
  }
}
