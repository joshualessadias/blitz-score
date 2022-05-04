import 'package:blitz_score/player_list.dart';
import 'package:flutter/material.dart';
import 'package:blitz_score/model/player.dart';
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
  static const Color textColor = Colors.white;

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
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    dbMaxWidgets = MediaQuery.of(context).size.width / 225;
    maxWidgets = dbMaxWidgets.floor();

    return Scaffold(
      body: PlayerList(maxWidgets: maxWidgets, textColor: textColor),
      floatingActionButton: _addPlayerButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
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
        setState(() {});
      },
      child: const Icon(Icons.add_rounded),
      tooltip: 'Add new player',
      backgroundColor: Colors.blueGrey,
      foregroundColor: Colors.white,
    );
  }
}
