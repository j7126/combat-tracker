import 'package:combat_tracker/datamodel/generated/character.pb.dart';
import 'package:combat_tracker/datamodel/generated/combat.pb.dart';
import 'package:uuid/uuid.dart';

extension CombatExtension on Combat {
  void deleteCharacter(Character character) {
    characters.remove(character);
    if (activePlayer == character.id) {
      activePlayer = "";
    }
    if (currentTurn == character.id) {
      currentTurn = "";
    }
  }

  void duplicateCharacter(Character character) {
    var newCharacter = Character.fromBuffer(character.writeToBuffer());
    newCharacter.id = Uuid().v4();
    newCharacter.damageEvents.clear();
    characters.add(newCharacter);
  }
}
