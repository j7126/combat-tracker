import 'package:combat_tracker/datamodel/generated/character.pb.dart';
import 'package:combat_tracker/datamodel/generated/options.pb.dart';

extension OptionsExtension on Options {
  static List<CharacterType> defaultInitiativePriority = [
    CharacterType.Player,
    CharacterType.FriendlyNPC,
    CharacterType.UnknownNPC,
    CharacterType.Enemy,
  ];

  void validate() {
    for (var type in defaultInitiativePriority) {
      if (!initiativePriority.contains(type)) {
        initiativePriority.add(type);
      }
    }
    if (initiativePriority.length != defaultInitiativePriority.length) {
      initiativePriority.clear();
      initiativePriority.addAll(defaultInitiativePriority);
    }
  }
}