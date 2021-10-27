import 'package:flutter/material.dart';
import 'package:blitz_score/model/app_icons.dart';

class MyCard {
  final int id;
  final Color color;
  final Icon figure;

  MyCard({required this.id, required this.color, required this.figure});
}

const double iconSize = 250;
const Color iconColor = Colors.black12;

MyCard greenPail = MyCard(
    id: 0,
    color: Colors.lightGreen.shade600,
    figure:
        const Icon(MyFlutterApp.pail, size: iconSize - 50, color: iconColor));
MyCard yellowCarriage = MyCard(
    id: 1,
    color: Colors.yellow.shade600,
    figure:
        const Icon(MyFlutterApp.carriage, size: iconSize, color: iconColor));
MyCard redPlow = MyCard(
    id: 2,
    color: Colors.red.shade500,
    figure: const Icon(MyFlutterApp.plow, size: iconSize, color: iconColor));
MyCard bluePump = MyCard(
    id: 3,
    color: Colors.lightBlue.shade600,
    figure:
        const Icon(MyFlutterApp.pump, size: iconSize - 50, color: iconColor));
MyCard yellowPail = MyCard(
    id: 4,
    color: Colors.yellow.shade600,
    figure:
        const Icon(MyFlutterApp.pail, size: iconSize - 50, color: iconColor));
MyCard redCarriage = MyCard(
    id: 5,
    color: Colors.red.shade500,
    figure:
        const Icon(MyFlutterApp.carriage, size: iconSize, color: iconColor));
MyCard bluePlow = MyCard(
    id: 6,
    color: Colors.lightBlue.shade600,
    figure: const Icon(MyFlutterApp.plow, size: iconSize, color: iconColor));
MyCard greenPump = MyCard(
    id: 7,
    color: Colors.lightGreen.shade600,
    figure:
        const Icon(MyFlutterApp.pump, size: iconSize - 50, color: iconColor));

List<MyCard> cardList = [
  greenPump,
  yellowPail,
  bluePlow,
  redCarriage,
  bluePump,
  greenPail,
  redPlow,
  yellowCarriage,
];
