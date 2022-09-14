import 'package:blitz_score/models/card.dart';
import 'package:blitz_score/models/player.dart';

class PlayerUtils {
  void createPlayer(int index, String inputName, MyCard selectedCard) {
    Player newPlayer =
        Player(id: index, name: inputName, points: 0, card: selectedCard);
    playerList.add(newPlayer);
  }

  void updatePlayer(int index, String inputName, MyCard selectedCard) {
    playerList[index].name = inputName;
    playerList[index].card = selectedCard;
  }

  void deletePlayer(int index) {
    playerList.removeAt(index);
  }

  void sumPoints(int index, int value) {
    playerList[index].points += value;
  }

  void subtractPoints(int index, int value) {
    playerList[index].points -= value;
  }
}




