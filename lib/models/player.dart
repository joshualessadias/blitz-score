import 'package:blitz_score/models/card.dart';

class Player {
  late int? id;
  late String name;
  late int points;
  late MyCard card;

  Player(
      {this.id, required this.name, required this.points, required this.card});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'name': name, 'points': points, 'card': card.id};
  }

  Player.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    points = map['points'];
    card = cardList[map['card']];
  }
}
