import 'package:blitz_score/utilities/player_utils.dart';
import 'package:flutter/material.dart';

import '../../models/player.dart';

class TemporaryPointWidget extends StatelessWidget {
  final Player player;
  final Map<int, int> temporaryPoints;
  final Function(int, int) updateTemporaryPoints;

  TemporaryPointWidget(
      this.player, this.temporaryPoints, this.updateTemporaryPoints,
      {Key? key})
      : super(key: key);

  final PlayerUtils playerUtils = PlayerUtils();

  String _formatPoints(int points) {
    return (points > 0 ? "+" : "") + points.toString();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          fixedSize: const Size(110, 60),
          backgroundColor: Colors.black26),
      onPressed: () {
        playerUtils.persistPoints(player, temporaryPoints[player.id!]!);
        updateTemporaryPoints(player.id!, 0);
      },
      child: Text(
        _formatPoints(temporaryPoints[player.id!]!),
        style: const TextStyle(
          color: Colors.white70,
          decoration: TextDecoration.none,
          fontSize: 26,
        ),
      ),
    );
  }
}
