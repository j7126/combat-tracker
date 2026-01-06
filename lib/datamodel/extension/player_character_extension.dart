import 'package:combat_tracker/datamodel/player_character.pb.dart';
import 'package:uuid/uuid.dart';

extension PlayerCharacterExtension on PlayerCharacter {
  static PlayerCharacter createCharacter() {
    return PlayerCharacter(id: Uuid().v4(), active: true);
  }
}
