import 'package:blitz_score/utilities/player_utils.dart';
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
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  void _handleLongPress(int index) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                PlayerConfigPage(isEditing: true, index: index)));
    setState(() {});
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

  Future<int?> showScoreInputDialog(
      BuildContext context, bool sum, String name) {
    TextEditingController customController = TextEditingController();
    return showDialog<int>(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: const Color(0xff212121),
            title: sum == true
                ? Text('Increase "' + name + '" score:')
                : Text('Decrease "' + name + '" score:'),
            content: TextField(
              autofocus: true,
              controller: customController,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              keyboardType: TextInputType.number,
            ),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                  customController.text != ''
                      ? Navigator.of(context)
                          .pop(int.parse(customController.text))
                      : Navigator.of(context).pop(int.parse('0'));
                },
                child: const Text('Submit'),
              )
            ],
          );
        });
  }

  Widget _scoringButtons(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        OutlinedButton(
            onPressed: () {
              showScoreInputDialog(context, true, playerList[index].name)
                  .then((value) => setState(() {
                        playerUtils.sumPoints(index, value!);
                      }));
            },
            style: OutlinedButton.styleFrom(
              primary: Colors.white,
              side: const BorderSide(color: Colors.black38, width: 1.7),
              fixedSize: const Size(80, 50),
              backgroundColor: Colors.black12,
            ),
            child: const Icon(
              Icons.add_rounded,
              size: 40,
            )),
        OutlinedButton(
            onPressed: () {
              showScoreInputDialog(context, false, playerList[index].name)
                  .then((value) => setState(() {
                        playerUtils.subtractPoints(index, value!);
                      }));
            },
            style: OutlinedButton.styleFrom(
              primary: Colors.white,
              side: const BorderSide(color: Colors.black38, width: 1.7),
              fixedSize: const Size(80, 50),
              backgroundColor: Colors.black12,
            ),
            child: const Icon(
              Icons.remove_rounded,
              size: 40,
            )),
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
                              Text(
                                playerList[index].points.toString(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  decoration: TextDecoration.none,
                                  fontSize: 100,
                                ),
                              ),
                              _scoringButtons(index),
                            ],
                          ),
                        ],
                      ))),
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
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }
}
