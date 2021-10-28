import 'package:blitz_score/model/card.dart';
import 'package:blitz_score/model/player.dart';
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
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    myController.dispose();
    super.dispose();
  }

  _handleSubmitted() {
    FocusScope.of(context).unfocus();
    widget.isEditing
        ? updatePlayer(widget.index, myController.text, selectedCard)
        : createPlayer(widget.index, myController.text, selectedCard);
    Navigator.pop(context);
  }

  _handleDeleted() {
    FocusScope.of(context).unfocus();
    deletePlayer(widget.index);
    Navigator.pop(context);
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
              Row(
                children: [
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 1.0,
                      child: InkWell(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          selectedCard = cardList[0];
                          setState(() {});
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: selectedCard == cardList[0]
                                  ? cardList[0].color
                                  : cardList[0].color.withOpacity(0.3)),
                          width: double.infinity,
                          child: Icon(
                            cardList[0].figure.icon,
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
                          selectedCard = cardList[1];
                          setState(() {});
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: selectedCard == cardList[1]
                                  ? cardList[1].color
                                  : cardList[1].color.withOpacity(0.3)),
                          width: double.infinity,
                          child: Icon(
                            cardList[1].figure.icon,
                            size: 200,
                            color: Colors.black38,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 1.0,
                      child: InkWell(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          selectedCard = cardList[2];
                          setState(() {});
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: selectedCard == cardList[2]
                                  ? cardList[2].color
                                  : cardList[2].color.withOpacity(0.3)),
                          width: double.infinity,
                          child: Icon(
                            cardList[2].figure.icon,
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
                          selectedCard = cardList[3];
                          setState(() {});
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: selectedCard == cardList[3]
                                  ? cardList[3].color
                                  : cardList[3].color.withOpacity(0.3)),
                          width: double.infinity,
                          child: Icon(
                            cardList[3].figure.icon,
                            size: 200,
                            color: Colors.black38,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 1.0,
                      child: InkWell(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          selectedCard = cardList[4];
                          setState(() {});
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: selectedCard == cardList[4]
                                  ? cardList[4].color
                                  : cardList[4].color.withOpacity(0.3)),
                          width: double.infinity,
                          child: Icon(
                            cardList[4].figure.icon,
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
                          selectedCard = cardList[5];
                          setState(() {});
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: selectedCard == cardList[5]
                                  ? cardList[5].color
                                  : cardList[5].color.withOpacity(0.3)),
                          width: double.infinity,
                          child: Icon(
                            cardList[5].figure.icon,
                            size: 200,
                            color: Colors.black38,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 1.0,
                      child: InkWell(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          selectedCard = cardList[6];
                          setState(() {});
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: selectedCard == cardList[6]
                                  ? cardList[6].color
                                  : cardList[6].color.withOpacity(0.3)),
                          width: double.infinity,
                          child: Icon(
                            cardList[6].figure.icon,
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
                          selectedCard = cardList[7];
                          setState(() {});
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: selectedCard == cardList[7]
                                  ? cardList[7].color
                                  : cardList[7].color.withOpacity(0.3)),
                          width: double.infinity,
                          child: Icon(
                            cardList[7].figure.icon,
                            size: 200,
                            color: Colors.black38,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
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
