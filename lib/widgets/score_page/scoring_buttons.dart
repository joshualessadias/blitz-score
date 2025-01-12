import 'package:flutter/material.dart';

import '../../models/player.dart';
import '../../utilities/player_utils.dart';
import '../clickable_point.dart';
import '../my_divider.dart';

class ScoringButtons extends StatelessWidget {
  final Map<int, int> temporaryPoints;
  final Player player;
  final Function(int, int) updateTemporaryPoints;

  ScoringButtons(this.player, this.temporaryPoints, this.updateTemporaryPoints,
      {Key? key})
      : super(key: key);

  final PlayerUtils playerUtils = PlayerUtils();

  Widget _generateClickablePoint(Player player, int value) {
    return InkWell(
      onTap: () {
        int updatedValue =
            playerUtils.sumTemporary(temporaryPoints[player.id!]!, value);
        updateTemporaryPoints(player.id!, updatedValue);
      },
      child: Column(
        children: [
          ClickablePoint(
            amount: value,
          ),
          const MyDivider(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            _generateClickablePoint(player, -1),
            _generateClickablePoint(player, -5),
            _generateClickablePoint(player, -10),
          ],
        ),
        Column(
          children: [
            _generateClickablePoint(player, 1),
            _generateClickablePoint(player, 5),
            _generateClickablePoint(player, 10),
          ],
        ),
      ],
    );
  }
}
