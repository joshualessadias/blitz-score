import 'package:blitz_score/models/card.dart';
import 'package:flutter/material.dart';

class MyCardSelection extends StatelessWidget {
  const MyCardSelection(
      {Key? key, required this.selectedCard, required this.index})
      : super(key: key);

  final MyCard selectedCard;
  final int index;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: selectedCard == cardList[index]
            ? cardList[index].color
            : cardList[index].color.withOpacity(0.3),
        boxShadow: [
          BoxShadow(
            color: selectedCard == cardList[index]
                ? Colors.black38
                : Colors.transparent,
            blurRadius: 8,
            spreadRadius: 2,
            offset: const Offset(2, 7),
          ),
        ],
      ),
      child: ClipRRect(
        child: Icon(
          cardList[index].figure.icon,
          size: 190,
          color: Colors.black38,
        ),
      ),
    );
  }
}
