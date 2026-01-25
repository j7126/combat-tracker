import 'package:combat_tracker/datamodel/generated/character.pb.dart';
import 'package:combat_tracker/datamodel/generated/combat.pb.dart';

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
}
