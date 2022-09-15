import 'package:blitz_score/models/card.dart';

class Player {
  int id;
  String name;
  int points;
  MyCard card;
  int temporaryPoints;

  Player(
      {required this.id,
      required this.name,
      required this.points,
      required this.card,
      this.temporaryPoints = 0});
}

List<Player> playerList = [];
