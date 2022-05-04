import 'package:blitz_score/model/player.dart';
import 'package:blitz_score/player_config_page.dart';
import 'package:blitz_score/point_button.dart';
import 'package:flutter/material.dart';

class PlayerList extends StatefulWidget {
  const PlayerList({
    Key? key,
    required this.maxWidgets,
    required this.textColor,
  }) : super(key: key);

  final int maxWidgets;
  final Color textColor;
  static const Color separatorColor = Colors.black12;

  @override
  State<PlayerList> createState() => _PlayerListState();
}

class _PlayerListState extends State<PlayerList> {
  @override
  Widget build(BuildContext context) {
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
                width: playerList.length <= widget.maxWidgets
                    ? MediaQuery.of(context).size.width / playerList.length
                    : 225,
                color: playerList[index].card.color,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 24, 8, 24),
                  child: Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 65, 0, 0),
                        width: playerList.length <= widget.maxWidgets
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
                            style: TextStyle(
                              color: widget.textColor,
                              fontSize: 40,
                              decoration: TextDecoration.none,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                playerList[index].points.toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: widget.textColor,
                                  decoration: TextDecoration.none,
                                  fontSize: 100,
                                ),
                              ),
                              Text(
                                playerList[index].points.toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: widget.textColor,
                                  decoration: TextDecoration.none,
                                  fontSize: 24,
                                ),
                              ),
                            ],
                          ),
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

  Widget _scoringButtons(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            PointButton(
              widget: widget,
              index: index,
              value: -1,
              onValueUpdated: _refreshPoints,
            ),
            Container(
              height: 1,
              width: 35,
              color: PlayerList.separatorColor,
            ),
            PointButton(
              widget: widget,
              index: index,
              value: -5,
              onValueUpdated: _refreshPoints,
            ),
            Container(
              height: 1,
              width: 35,
              color: PlayerList.separatorColor,
            ),
            PointButton(
              widget: widget,
              index: index,
              value: -10,
              onValueUpdated: _refreshPoints,
            ),
          ],
        ),
        Column(
          children: [
            PointButton(
              widget: widget,
              index: index,
              value: 1,
              onValueUpdated: _refreshPoints,
            ),
            Container(
              height: 1,
              width: 35,
              color: PlayerList.separatorColor,
            ),
            PointButton(
              widget: widget,
              index: index,
              value: 5,
              onValueUpdated: _refreshPoints,
            ),
            Container(
              height: 1,
              width: 35,
              color: PlayerList.separatorColor,
            ),
            PointButton(
              widget: widget,
              index: index,
              value: 10,
              onValueUpdated: _refreshPoints,
            ),
          ],
        ),
      ],
    );
  }

  void _refreshPoints() {
    setState(() {});
  }

  void _handleLongPress(int index) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                PlayerConfigPage(isEditing: true, index: index)));
    setState(() {});
  }
}
