import 'package:combat_tracker/datamodel/generated/character.pb.dart';
import 'package:flutter/material.dart';

class CombatNameField extends StatefulWidget {
  const CombatNameField({super.key, required this.character, this.changed});

  final Character character;
  final Function()? changed;

  @override
  State<CombatNameField> createState() => _CombatNameFieldState();
}

class _CombatNameFieldState extends State<CombatNameField> {
  late TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController(text: widget.character.name);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: (value) {
        widget.character.name = value;
        widget.changed?.call();
      },
      readOnly: widget.character.type == CharacterType.Player,
      mouseCursor: widget.character.type == CharacterType.Player
          ? MouseCursor.defer
          : null,
      decoration: InputDecoration(border: InputBorder.none, hintText: "Name"),
    );
  }
}
