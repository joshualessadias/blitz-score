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

List<Player> playerList = [];
