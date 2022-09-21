import 'package:blitz_score/helpers/database_helpers.dart';
import 'package:blitz_score/models/player.dart';

class PlayerRepository {
  List<Player> _playerList = [];

  List<Player> get playerList => _playerList;

  PlayerRepository() {
    _initRepository();
  }

  _initRepository() async {
    await _getAllPlayers();
  }

  _getAllPlayers() async {
    _playerList = await findAll();
  }

  Future<void> insert(Player player) async {
    var db = await DatabaseHelper.instance.database;
    await db.insert('Player', player.toMap());
  }

  Future<void> delete(Player player) async {
    var db = await DatabaseHelper.instance.database;
    await db.delete('Player', where: 'id = ?', whereArgs: [player.id]);
  }

  Future<void> update(Player player) async {
    var db = await DatabaseHelper.instance.database;
    await db.update('Player', player.toMap(),
        where: 'id = ?', whereArgs: [player.id]);
  }

  Future<void> deleteAll() async {
    var db = await DatabaseHelper.instance.database;
    await db.delete('Player');
  }

  Future<List<Player>> findAll() async {
    var db = await DatabaseHelper.instance.database;
    var maps =
        await db.query('Player', columns: ['id', 'name', 'points', 'card']);

    if (maps.isNotEmpty) {
      return maps.map((playerFromDB) => Player.fromMap(playerFromDB)).toList();
    }

    return List.empty();
  }
}
