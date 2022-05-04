import 'package:blitz_score/model/player.dart';
import 'package:blitz_score/player_list.dart';
import 'package:flutter/material.dart';

class PointButton extends StatelessWidget {
  const PointButton({
    Key? key,
    required this.widget,
    required this.value,
    required this.index,
    required this.onValueUpdated,
  }) : super(key: key);

  final PlayerList widget;
  final int value;
  final int index;
  final VoidCallback onValueUpdated;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Text(
        _valueToShow(value),
        style: TextStyle(
          color: widget.textColor,
          decoration: TextDecoration.none,
          fontSize: 20,
        ),
      ),
      onTap: () {
        _handleScoreTap(index, value);
      },
    );
  }

  String _valueToShow(int value) {
    if (value < 0) {
      return value.toString();
    } else {
      return '+$value';
    }
  }

  void _handleScoreTap(int index, int value) {
    sumPoints(index, value);
    onValueUpdated.call();
  }
}
