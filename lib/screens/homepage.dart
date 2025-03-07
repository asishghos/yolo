import 'package:flutter/material.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';
import 'dart:math' as math;

import 'package:yolo/screens/card_details.dart';
import 'package:yolo/screens/frozen_card_view.dart';

class CardApp extends StatefulWidget {
  const CardApp({Key? key}) : super(key: key);

  @override
  _CardAppState createState() => _CardAppState();
}

class _CardAppState extends State<CardApp> {
  bool _isFrozen = false;
  final controller = FlipCardController();
  late String cardNumber;
  late String expiryDate;
  late String cvv;

  @override
  void initState() {
    super.initState();
    _generateCardDetails();
  }

  void _generateCardDetails() {
    final random = math.Random();
    cardNumber = List.generate(
            4, (_) => List.generate(4, (_) => random.nextInt(10)).join(''))
        .join(' ');
    final month = (random.nextInt(12) + 1).toString().padLeft(2, '0');
    final year =
        (DateTime.now().year + random.nextInt(5)).toString().substring(2);
    expiryDate = '$month/$year';
    cvv = List.generate(3, (_) => random.nextInt(10)).join('');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      'select payment mode',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'choose your preferred payment method to make payment.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[500],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white,
                                blurRadius: 2,
                                spreadRadius: 1,
                                offset: Offset(1, 0),
                              ),
                            ],
                          ),
                          child: GestureDetector(
                            onTap: () {},
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 16),
                              child: Text(
                                'pay',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.red,
                                blurRadius: 2,
                                spreadRadius: 1,
                                offset: Offset(1, 0),
                              ),
                            ],
                          ),
                          child: GestureDetector(
                            onTap: () {},
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 16),
                              child: Text(
                                'card',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Text(
                      'YOUR DIGITAL DEBIT CARD',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[500],
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        Flexible(
                          child: FlipCard(
                            rotateSide: RotateSide.bottom,
                            onTapFlipping: false,
                            axis: FlipAxis.vertical,
                            controller: controller,
                            frontWidget: FrozenCardView(),
                            backWidget: CardDetailsView(
                              cardNumber: cardNumber,
                              expiryDate: expiryDate,
                              cvv: cvv,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _isFrozen = !_isFrozen;
                                controller.flipcard();
                              });
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color:
                                          _isFrozen ? Colors.red : Colors.white,
                                      width: 1,
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.ac_unit,
                                    color:
                                        _isFrozen ? Colors.red : Colors.white,
                                    size: 24,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  _isFrozen ? 'unfreeze' : 'freeze',
                                  style: TextStyle(
                                    color:
                                        _isFrozen ? Colors.red : Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.white,
              blurRadius: 2,
              spreadRadius: 1,
              offset: Offset(1, 0),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNavItem(
                  icon: Icons.home_outlined, label: 'home', isActive: false),
              _buildNavItem(
                customIcon: Icons.qr_code_scanner_rounded,
                label: 'yolo pay',
                isActive: true,
                showCircle: true,
              ),
              _buildNavItem(
                customIcon: Icons.percent_rounded,
                label: 'ginie',
                isActive: false,
                isDiscount: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildNavItem({
  IconData? icon,
  IconData? customIcon,
  required String label,
  required bool isActive,
  bool showCircle = false,
  bool isDiscount = false,
}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        padding: EdgeInsets.all(showCircle ? 10 : 0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: showCircle ? Border.all(color: Colors.white, width: 1) : null,
        ),
        child: Icon(
          icon ?? customIcon,
          color: isActive ? Colors.white : Colors.grey.shade600,
          size: 24,
        ),
      ),
      SizedBox(height: 8),
      Text(
        label,
        style: TextStyle(
          color: isActive ? Colors.white : Colors.grey.shade600,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    ],
  );
}
