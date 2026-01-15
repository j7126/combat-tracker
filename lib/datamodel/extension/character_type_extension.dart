import 'package:combat_tracker/datamodel/generated/character.pb.dart';
import 'package:flutter/material.dart';

extension CharacterTypeExtension on CharacterType {
  Widget getIcon() => switch (this) {
    CharacterType.Player => Icon(Icons.person, color: Colors.blue),
    CharacterType.FriendlyNPC => Icon(Icons.person_outline, color: Colors.green),
    CharacterType.UnknownNPC => Icon(Icons.person_outline, color: Colors.amber),
    CharacterType.Enemy => Icon(Icons.shield_outlined, color: Colors.red),
    _ => Container(),
  };

  String getName() => switch (this) {
    CharacterType.Player => "Player Character",
    CharacterType.Enemy => "Enemy",
    CharacterType.FriendlyNPC => "Friendly NPC",
    CharacterType.UnknownNPC => "Unknown NPC",
    _ => "",
  };
}