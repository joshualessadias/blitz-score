import 'package:blitz_score/model/card.dart';

class Player {
  int id;
  String name;
  int points;
  MyCard card;

  Player(
      {required this.id,
      required this.name,
      required this.points,
      required this.card});
}

Player player1 = Player(id: 0, name: 'Joshua', points: 0, card: cardList[0]);
Player player2 = Player(id: 1, name: 'Nátali', points: 0, card: cardList[1]);
Player player3 = Player(id: 2, name: 'Johnny', points: 0, card: cardList[2]);
Player player4 = Player(id: 3, name: 'Valéria', points: 0, card: cardList[3]);

List<Player> playerList = [];

createPlayer(int index, String inputName, MyCard selectedCard) {
  Player newPlayer =
      Player(id: index, name: inputName, points: 0, card: selectedCard);
  playerList.add(newPlayer);
}

updatePlayer(int index, String inputName, MyCard selectedCard) {
  playerList[index].name = inputName;
  playerList[index].card = selectedCard;
}

deletePlayer(int index) {
  playerList.removeAt(index);
}
