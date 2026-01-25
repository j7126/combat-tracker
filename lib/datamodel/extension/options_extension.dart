import 'package:combat_tracker/datamodel/generated/character.pb.dart';
import 'package:combat_tracker/datamodel/generated/custom_field.pb.dart';
import 'package:combat_tracker/datamodel/generated/options.pb.dart';

extension OptionsExtension on Options {
  static List<CharacterType> defaultInitiativePriority = [
    CharacterType.Player,
    CharacterType.FriendlyNPC,
    CharacterType.UnknownNPC,
    CharacterType.Enemy,
  ];

  static List<CustomField> defaultCustomFields = [
    CustomField(
      id: "dd8593fe-4bf2-4ddf-99db-1bbd83fc8d65",
      builtIn: true,
      name: "Armor Class",
      shortName: "AC",
      enabledCharacter: true,
      enabledCombat: true,
    ),
  ];

  void validate() {
    // initiative priority
    for (var type in defaultInitiativePriority) {
      if (!initiativePriority.contains(type)) {
        initiativePriority.add(type);
      }
    }
    if (initiativePriority.length != defaultInitiativePriority.length) {
      initiativePriority.clear();
      initiativePriority.addAll(defaultInitiativePriority);
    }

    // custom fields
    for (var (i, defautlField) in defaultCustomFields.indexed) {
      if (!customFields.any((x) => x.id == defautlField.id)) {
        customFields.insert(i, defautlField);
      }
    }
  }
}
