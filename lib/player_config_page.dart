import 'package:blitz_score/model/card.dart';
import 'package:blitz_score/model/player.dart';
import 'package:blitz_score/service/player_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PlayerConfigPage extends StatefulWidget {
  final bool isEditing;
  final int index;

  const PlayerConfigPage(
      {Key? key, required this.isEditing, required this.index})
      : super(key: key);

  @override
  State<PlayerConfigPage> createState() => _PlayerConfigPageState();
}

class _PlayerConfigPageState extends State<PlayerConfigPage> {
  MyCard selectedCard = cardList[8];
  TextEditingController myController = TextEditingController();

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    selectedCard =
        widget.isEditing ? playerList[widget.index].card : selectedCard;
    myController.text =
        widget.isEditing ? playerList[widget.index].name : myController.text;
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
    widget.isEditing
        ? updatePlayer(widget.index, myController.text, selectedCard)
        : createPlayer(widget.index, myController.text, selectedCard);
    Navigator.pop(context);
  }

  void _handleDeleted() {
    FocusScope.of(context).unfocus();
    deletePlayer(widget.index);
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
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: selectedCard == cardList[firstIndex]
                        ? cardList[firstIndex].color
                        : cardList[firstIndex].color.withOpacity(0.3)),
                width: double.infinity,
                child: Icon(
                  cardList[firstIndex].figure.icon,
                  size: 200,
                  color: Colors.black38,
                ),
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
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: selectedCard == cardList[secondIndex]
                        ? cardList[secondIndex].color
                        : cardList[secondIndex].color.withOpacity(0.3)),
                width: double.infinity,
                child: Icon(
                  cardList[secondIndex].figure.icon,
                  size: 200,
                  color: Colors.black38,
                ),
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
          title: widget.isEditing
              ? const Text('Edit Player')
              : const Text('Add New Player'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextFormField(
                  controller: myController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter Player\'s Name')),
              const SizedBox(
                height: 16,
              ),
              const Text(
                'Select Player\'s Card:',
                style: TextStyle(fontSize: 24),
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (widget.isEditing)
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          primary: Colors.red,
                          side: const BorderSide(color: Colors.red),
                          fixedSize: const Size(100, 45),
                          textStyle: const TextStyle(fontSize: 16)),
                      onPressed: _handleDeleted,
                      child: const Text('Delete'),
                    ),
                  Center(
                      child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(100, 45),
                        textStyle: const TextStyle(fontSize: 16)),
                    onPressed: _handleSubmitted,
                    child: const Text('Submit'),
                  )),
                ],
              )
            ],
          ),
        ));
  }
}
