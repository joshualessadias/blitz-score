import 'package:blitz_score/utilities/player_utils.dart';
import 'package:blitz_score/widgets/clickable_point.dart';
import 'package:blitz_score/widgets/my_divider.dart';
import 'package:flutter/material.dart';
import 'package:blitz_score/models/player.dart';
import 'package:flutter/services.dart';

import 'player_config_page.dart';

class ScorePage extends StatefulWidget {
  const ScorePage({Key? key}) : super(key: key);

  @override
  ScorePageState createState() => ScorePageState();
}

class ScorePageState extends State<ScorePage> {
  double dbMaxWidgets = 0;
  int maxWidgets = 0;
  Map<int, int> temporaryPoints = {};
  var playerUtils = PlayerUtils();
  late bool firstOpening;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    firstOpening = true;
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
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

  void refreshScreen() {
    setState(() {});
  }

  void _handleLongPress(Player player) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                PlayerConfigPage(isEditing: true, player: player)));
  }

  Widget _addPlayerButton() {
    return FloatingActionButton(
      onPressed: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const PlayerConfigPage(
              isEditing: false,
              player: null,
            ),
          ),
        );
      },
      child: const Icon(Icons.add_rounded),
      tooltip: "Add new player",
      backgroundColor: Colors.blueGrey,
      foregroundColor: Colors.white,
    );
  }

  String _formatPoints(int points) {
    return (points > 0 ? "+" : "") + points.toString();
  }

  Widget _temporaryPointsWidget(Player player) {
    return Row(
      children: [
        const SizedBox(width: 8),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              fixedSize: const Size(77, 60),
              backgroundColor: Colors.black26),
          onPressed: () {
            playerUtils.persistPoints(player, temporaryPoints[player.id!]!);
            temporaryPoints[player.id!] = 0;
            refreshScreen();
          },
          child: Text(
            _formatPoints(temporaryPoints[player.id!]!),
            style: const TextStyle(
              color: Colors.white70,
              decoration: TextDecoration.none,
              fontSize: 26,
            ),
          ),
        ),
      ],
    );
  }

  Widget _scoreText(Player player) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          player.points.toString(),
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            decoration: TextDecoration.none,
            fontSize: 100,
          ),
        ),
        temporaryPoints[player.id!] == (0)
            ? const SizedBox.shrink()
            : _temporaryPointsWidget(player)
      ],
    );
  }

  Widget _generateClickablePoint(Player player, int value) {
    return ClickablePoint(
      amount: value,
      onTap: () {
        temporaryPoints[player.id!] =
            playerUtils.sumTemporary(temporaryPoints[player.id!]!, value);
        refreshScreen();
      },
    );
  }

  Widget _scoringButtons(Player player) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            _generateClickablePoint(player, -1),
            const MyDivider(),
            _generateClickablePoint(player, -5),
            const MyDivider(),
            _generateClickablePoint(player, -10),
          ],
        ),
        Column(
          children: [
            _generateClickablePoint(player, 1),
            const MyDivider(),
            _generateClickablePoint(player, 5),
            const MyDivider(),
            _generateClickablePoint(player, 10),
          ],
        ),
      ],
    );
  }

  Widget _showGameDialog() {
    return AlertDialog(
      title: const Text(
        'Create/Load',
      ),
      content: const Text('Create new board or load last players?'),
      actions: [
        TextButton(
          child: const Text('Create new'),
          onPressed: () {
            playerUtils.clear();
            firstOpening = false;
            refreshScreen();
          },
        ),
        TextButton(
          child: const Text('Load last'),
          onPressed: () {
            firstOpening = false;
            refreshScreen();
          },
        )
      ],
    );
  }

  Widget _listView() {
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
                  _handleLongPress(playerList[index]);
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
                                decoration: TextDecoration.none,
                              ),
                            ),
                            _scoreText(playerList[index]),
                            _scoringButtons(playerList[index]),
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
          return const Center(
            child: Text(
              'Add a new player by tapping the + button',
              style: TextStyle(fontSize: 24),
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    dbMaxWidgets = MediaQuery.of(context).size.width / 225;
    maxWidgets = dbMaxWidgets.floor();

    return Scaffold(
      body: firstOpening ? _showGameDialog() : _listView(),
      floatingActionButton: _addPlayerButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
    );
  }
}
