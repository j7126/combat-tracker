import 'package:combat_tracker/datamodel/generated/character.pb.dart';
import 'package:flutter/material.dart';

class CharacterNameField extends StatefulWidget {
  const CharacterNameField({super.key, required this.character, this.changed});

  final Character character;
  final Function()? changed;

  @override
  State<CharacterNameField> createState() => _CharacterNameFieldState();
}

class _CharacterNameFieldState extends State<CharacterNameField> {
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
      decoration: InputDecoration(border: InputBorder.none, hintText: "Name"),
    );
  }
}
