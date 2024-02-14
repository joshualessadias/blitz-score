import 'package:blitz_score/models/player.dart';
import 'package:blitz_score/widgets/score_page/temporary_points.dart';
import 'package:flutter/material.dart';

class ScoreText extends StatelessWidget {
  final Player player;
  final Map<int, int> temporaryPoints;
  final Function(int, int) updateTemporaryPoints;

  const ScoreText(this.player, this.temporaryPoints, this.updateTemporaryPoints,
      {Key? key})
      : super(key: key);

  bool _isTemporaryPointsEmpty() {
    return temporaryPoints[player.id!] == (0);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedDefaultTextStyle(
          style: TextStyle(
            color: Colors.white,
            decoration: TextDecoration.none,
            fontSize: _isTemporaryPointsEmpty() ? 90 : 75,
            height: 1,
          ),
          duration: const Duration(milliseconds: 200),
          child: Text(
            player.points.toString(),
            textAlign: TextAlign.center,
          ),
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 200),
          child: _isTemporaryPointsEmpty()
              ? const SizedBox.shrink()
              : TemporaryPointWidget(
                  player, temporaryPoints, updateTemporaryPoints),
        ),
      ],
    );
  }
}
