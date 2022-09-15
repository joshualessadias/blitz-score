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

  void persistPoints(int index) {
    playerList[index].points += playerList[index].temporaryPoints;
    playerList[index].temporaryPoints = 0;
  }

  void sumTemporary(int index, int value) {
    var aux = playerList[index].temporaryPoints + value;

    if (aux > 99) {
      aux = 99;
    } else if (aux < -99) {
      aux = -99;
    }

    playerList[index].temporaryPoints = aux;
  }
}
