import 'package:blitz_score/models/player.dart';
import 'package:blitz_score/repositories/player_repository.dart';

class PlayerUtils {
  final _playerRepository = PlayerRepository();

  Future<List<Player>> findAll() async {
    return await _playerRepository.findAll();
  }

  void create(Player player) {
    _playerRepository.insert(player);
  }

  void delete(Player player) {
    _playerRepository.delete(player);
  }

  void update(Player newPlayer) {
    _playerRepository.update(newPlayer);
  }

  void clear() {
    _playerRepository.deleteAll();
  }

  void persistPoints(Player player, int temporaryPoints) {
    player.points += temporaryPoints;
    update(player);
  }

  int sumTemporary(int temporaryPoints, int value) {
    var aux = temporaryPoints + value;

    if (aux > 99) {
      aux = 99;
    } else if (aux < -99) {
      aux = -99;
    }

    return aux;
  }
}
