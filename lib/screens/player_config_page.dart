import 'package:blitz_score/models/card.dart';
import 'package:blitz_score/models/player.dart';
import 'package:blitz_score/utilities/player_utils.dart';
import 'package:blitz_score/widgets/my_card_selection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PlayerConfigPage extends StatefulWidget {
  final bool isEditing;
  final Player? player;

  const PlayerConfigPage(
      {Key? key, required this.isEditing, required this.player})
      : super(key: key);

  @override
  State<PlayerConfigPage> createState() => _PlayerConfigPageState();
}

class _PlayerConfigPageState extends State<PlayerConfigPage> {
  MyCard selectedCard = cardList[8];
  TextEditingController myController = TextEditingController();

  var playerUtils = PlayerUtils();

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    selectedCard = widget.isEditing ? widget.player!.card : selectedCard;
    myController.text =
        widget.isEditing ? widget.player!.name : myController.text;
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    myController.dispose();
    super.dispose();
  }

  void _handleSubmitted() {
    FocusScope.of(context).unfocus();
    var editedPlayer = Player(
      id: widget.player?.id,
      name: myController.text,
      points: widget.player == null ? 0 : widget.player!.points,
      card: selectedCard,
    );
    widget.isEditing
        ? playerUtils.update(editedPlayer)
        : playerUtils.create(editedPlayer);
    Navigator.pop(context);
  }

  void _handleDeleted() {
    FocusScope.of(context).unfocus();
    playerUtils.delete(widget.player!);
    Navigator.pop(context);
  }

  Widget _constructRow(int firstIndex, int secondIndex) {
    return Row(
      children: [
        Expanded(
          child: AspectRatio(
            aspectRatio: 1.0,
            child: InkWell(
              onTap: () {
                FocusScope.of(context).unfocus();
                selectedCard = cardList[firstIndex];
                setState(() {});
              },
              child: MyCardSelection(
                selectedCard: selectedCard,
                index: firstIndex,
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: AspectRatio(
            aspectRatio: 1.0,
            child: InkWell(
              onTap: () {
                FocusScope.of(context).unfocus();
                selectedCard = cardList[secondIndex];
                setState(() {});
              },
              child: MyCardSelection(
                selectedCard: selectedCard,
                index: secondIndex,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.white,
          elevation: 0,
          backgroundColor: Colors.transparent,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
              ),
              color: Colors.lightBlue,
            ),
          ),
          title: Text(
            widget.isEditing
                ? AppLocalizations.of(context)!.editPlayerTitle
                : AppLocalizations.of(context)!.addPlayerTitle,
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                  controller: myController,
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText:
                          AppLocalizations.of(context)!.enterPlayersName)),
              const SizedBox(
                height: 16,
              ),
              Text(
                AppLocalizations.of(context)!.selectPlayersCard,
                style: const TextStyle(fontSize: 22),
              ),
              const SizedBox(
                height: 16,
              ),
              _constructRow(0, 1),
              const SizedBox(
                height: 8,
              ),
              _constructRow(2, 3),
              const SizedBox(
                height: 8,
              ),
              _constructRow(4, 5),
              const SizedBox(
                height: 8,
              ),
              _constructRow(6, 7),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (widget.isEditing)
                    Row(
                      children: [
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.red,
                            side: const BorderSide(color: Colors.red),
                            fixedSize: const Size(100, 45),
                            textStyle: const TextStyle(fontSize: 15),
                          ),
                          onPressed: _handleDeleted,
                          child: Text(AppLocalizations.of(context)!.delete),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                      ],
                    ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        fixedSize: const Size(100, 45),
                        textStyle: const TextStyle(fontSize: 15)),
                    onPressed: _handleSubmitted,
                    child: Text(AppLocalizations.of(context)!.submit),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
