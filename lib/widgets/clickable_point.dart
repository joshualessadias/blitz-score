import 'package:flutter/material.dart';

class ClickablePoint extends StatelessWidget {
  final int amount;

  const ClickablePoint({Key? key, required this.amount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      amount < 0 ? amount.toString() : "+$amount",
      style: const TextStyle(
        color: Colors.white,
        decoration: TextDecoration.none,
        fontSize: 20,
      ),
    );
  }
}
