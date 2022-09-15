import 'dart:developer';

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

  var playerUtils = PlayerUtils();

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
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

  void refreshScreen() {
    setState(() {});
  }

  void _handleLongPress(int index) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                PlayerConfigPage(isEditing: true, index: index)));
    refreshScreen();
  }

  Widget _addPlayerButton() {
    return FloatingActionButton(
      onPressed: () async {
        await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PlayerConfigPage(
                      isEditing: false,
                      index: playerList.length,
                    )));
        refreshScreen();
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
            playerUtils.persistPoints(player.id);
            refreshScreen();
          },
          child: Text(
            _formatPoints(player.temporaryPoints),
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
        player.temporaryPoints == 0
            ? const SizedBox.shrink()
            : _temporaryPointsWidget(player)
      ],
    );
  }

  Widget _generateClickablePoint(int index, int value) {
    return ClickablePoint(
      amount: value,
      onTap: () {
        playerUtils.sumTemporary(index, value);
        refreshScreen();
      },
    );
  }

  Widget _scoringButtons(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            _generateClickablePoint(index, -1),
            const MyDivider(),
            _generateClickablePoint(index, -5),
            const MyDivider(),
            _generateClickablePoint(index, -10),
          ],
        ),
        Column(
          children: [
            _generateClickablePoint(index, 1),
            const MyDivider(),
            _generateClickablePoint(index, 5),
            const MyDivider(),
            _generateClickablePoint(index, 10),
          ],
        ),
      ],
    );
  }

  Widget _listView() {
    return ListView(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      children: [
        ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: playerList.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onLongPress: () {
                _handleLongPress(index);
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
                          _scoringButtons(index),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    dbMaxWidgets = MediaQuery.of(context).size.width / 225;
    maxWidgets = dbMaxWidgets.floor();
    return Scaffold(
      body: _listView(),
      floatingActionButton: _addPlayerButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
    );
  }
}
