import 'package:blitz_score/utilities/player_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../widgets/score_page/list_view.dart';
import 'player_config_page.dart';

class ScorePage extends StatefulWidget {
  final bool databaseIsEmpty;
  const ScorePage({Key? key, required this.databaseIsEmpty}) : super(key: key);

  @override
  ScorePageState createState() => ScorePageState();
}

class ScorePageState extends State<ScorePage> {
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

  void refreshScreen() {
    setState(() {});
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
      tooltip: AppLocalizations.of(context)!.addNewPlayer,
      backgroundColor: Colors.blueGrey,
      foregroundColor: Colors.white,
      child: const Icon(Icons.add_rounded),
    );
  }

  Widget _showGameDialog() {
    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.createLoad),
      content: Text(AppLocalizations.of(context)!.createLoadDescription),
      actions: [
        TextButton(
          child: Text(AppLocalizations.of(context)!.createNew),
          onPressed: () {
            playerUtils.clear();
            firstOpening = false;
            refreshScreen();
          },
        ),
        TextButton(
          child: Text(AppLocalizations.of(context)!.loadLast),
          onPressed: () {
            firstOpening = false;
            refreshScreen();
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    return !widget.databaseIsEmpty && firstOpening
        ? Scaffold(body: _showGameDialog())
        : Scaffold(
            body: const MyListView(),
            floatingActionButton: _addPlayerButton(),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.miniEndTop,
          );
  }
}
