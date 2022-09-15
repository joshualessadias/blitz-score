import 'package:flutter/material.dart';

class ClickablePoint extends StatelessWidget {
  final int amount;
  final VoidCallback onTap;

  const ClickablePoint({Key? key, required this.amount, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Text(
        amount < 0 ? amount.toString() : "+" + amount.toString(),
        style: const TextStyle(
          color: Colors.white,
          decoration: TextDecoration.none,
          fontSize: 20,
        ),
      ),
      onTap: onTap,
    );
  }
}
