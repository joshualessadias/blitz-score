import 'package:blitz_score/widgets/score_page/score_text.dart';
import 'package:blitz_score/widgets/score_page/scoring_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../models/player.dart';
import '../../screens/player_config_page.dart';
import '../../utilities/player_utils.dart';

class MyListView extends StatefulWidget {
  const MyListView({Key? key}) : super(key: key);

  @override
  State<MyListView> createState() => _MyListViewState();
}

class _MyListViewState extends State<MyListView> {
  Map<int, int> temporaryPoints = {};
  double dbMaxWidgets = 0;
  int maxWidgets = 0;

  void updateTemporaryPoints(int playerId, int value) {
    setState(() {
      temporaryPoints[playerId] = value;
    });
  }

  void _buildTemporaryPoints(List<Player> playerList) {
    if (temporaryPoints.length <= playerList.length) {
      for (var player in playerList) {
        if (!temporaryPoints.containsKey(player.id!)) {
          temporaryPoints[player.id!] = 0;
        }
      }
    } else {
      var keysToDelete = <int>[];
      temporaryPoints.forEach((key, value) {
        if (!playerList.any((player) => player.id == key)) {
          keysToDelete.add(key);
        }
      });
      for (var key in keysToDelete) {
        temporaryPoints.remove(key);
      }
    }
  }

  void _handleLongPress(Player player, BuildContext context) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                PlayerConfigPage(isEditing: true, player: player)));
  }

  @override
  Widget build(BuildContext context) {
    dbMaxWidgets = MediaQuery.of(context).size.width / 225;
    maxWidgets = dbMaxWidgets.floor();
    final playerUtils = PlayerUtils();

    return FutureBuilder<List<Player>>(
      future: playerUtils.findAll(),
      builder: (BuildContext context, AsyncSnapshot<List<Player>> snapshot) {
        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          var playerList = snapshot.data!;
          _buildTemporaryPoints(playerList);
          return ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: playerList.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onLongPress: () {
                  _handleLongPress(playerList[index], context);
                },
                child: Container(
                  width: playerList.length <= maxWidgets
                      ? MediaQuery.of(context).size.width / playerList.length
                      : 225,
                  color: playerList[index].card.color,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 24, 8, 24),
                    child: Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.fromLTRB(0, 65, 0, 0),
                          width: playerList.length <= maxWidgets
                              ? MediaQuery.of(context).size.width /
                                  playerList.length
                              : 225,
                          child: playerList[index].card.figure,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              playerList[index].name,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                height: 1,
                                decoration: TextDecoration.none,
                              ),
                              maxLines: 2,
                            ),
                            ScoreText(playerList[index], temporaryPoints,
                                updateTemporaryPoints),
                            ScoringButtons(playerList[index], temporaryPoints,
                                updateTemporaryPoints),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          return Center(
            child: Text(
              AppLocalizations.of(context)!.introduction,
              style: const TextStyle(fontSize: 24),
            ),
          );
        }
      },
    );
  }
}
