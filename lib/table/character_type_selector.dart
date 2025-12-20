import 'package:combat_tracker/datamodel/character.pb.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CharacterTypeSelector extends StatefulWidget {
  const CharacterTypeSelector({super.key, required this.character, this.changed});

  final Character character;
  final Function()? changed;

  @override
  State<CharacterTypeSelector> createState() => _CharacterTypeSelectorState();
}

class _CharacterTypeSelectorState extends State<CharacterTypeSelector> {
  Widget _icon(CharacterType type) => switch (type) {
    CharacterType.PlayerCharacter => Icon(Icons.person, color: Colors.green),
    CharacterType.FriendlyNPC => Icon(
      Icons.person_outline,
      color: Colors.amber,
    ),
    CharacterType.Enemy => Icon(Icons.shield_outlined, color: Colors.red),
    _ => Container(),
  };

  String _name(CharacterType type) => switch (type) {
    CharacterType.PlayerCharacter => "Player Character",
    CharacterType.FriendlyNPC => "NPC",
    CharacterType.Enemy => "Enemy",
    _ => "",
  };

  Widget _menuEntry(CharacterType type) => MenuItemButton(
    onPressed: () {
      setState(() {
        widget.character.type = type;
        widget.changed?.call();
      });
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _icon(type),
          Gap(8.0),
          Text(_name(type)),
        ],
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      menuChildren: [
        _menuEntry(CharacterType.PlayerCharacter),
        _menuEntry(CharacterType.FriendlyNPC),
        _menuEntry(CharacterType.Enemy),
      ],
      builder: (_, MenuController controller, Widget? child) {
        return IconButton(
          onPressed: () {
            if (controller.isOpen) {
              controller.close();
            } else {
              controller.open();
            }
          },
          icon: _icon(widget.character.type),
        );
      },
    );
  }
}
