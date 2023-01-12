import 'package:dc_marvel_app/components/FramePay.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class PayDiamond extends StatefulWidget {
  const PayDiamond({super.key});

  @override
  State<PayDiamond> createState() => _PayDiamondState();
}

class _PayDiamondState extends State<PayDiamond> {
  @override
  final List<String> items = [
    'AgriBank',
    'ViettinBank',
    'Sacombank',
    'Wooho Bank',
  ];
  String? selectedValue;
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.9),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(
                height: size.height / 23,
              ),
              Align(
                alignment: Alignment.center,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(child: Image.asset('assets/images/BgPay.png')),
                    const Text(
                      'Cash Payment',
                      style: TextStyle(
                          fontSize: 28,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Horizon'),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height / 35,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Card number:',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Horizon'),
                  ),
                  const TextField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height / 18,
                  ),
                  const FramePay(text: 'Full name:', txt: 'Trần Minh Công'),
                  SizedBox(
                    height: size.height / 18,
                  ),
                  const FramePay(text: 'Price:', txt: '20.000'),
                  SizedBox(
                    height: size.height / 20,
                  ),
                  Row(
                    children: [
                      const Text(
                        'Bank:',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: 'Horizon',
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: size.width / 7,
                      ),
                      DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          hint: const Text(
                            'Select bank',
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Horizon'),
                          ),
                          items: items
                              .map((item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          fontFamily: 'Horizon',
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ))
                              .toList(),
                          value: selectedValue,
                          onChanged: (value) {
                            setState(() {
                              selectedValue = value as String;
                            });
                          },
                          buttonHeight: 40,
                          buttonWidth: 115,
                          itemHeight: 40,
                          dropdownDecoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.2),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height / 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 150,
                        height: 50,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/ButonSetting.png'),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'SUBMIT',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1.5,
                              fontFamily: 'Horizon',
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      margin: EdgeInsets.only(
                          top: size.height / 8, left: size.width / 25),
                      height: 60,
                      width: 60,
                      child: InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          height: double.infinity,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/ButtonBack.png'),
                              // fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
