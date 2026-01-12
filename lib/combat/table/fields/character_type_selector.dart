import 'package:combat_tracker/datamodel/generated/character.pb.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CharacterTypeSelector extends StatefulWidget {
  const CharacterTypeSelector({super.key, required this.character, this.changed, this.readOnly = false});

  final Character character;
  final Function()? changed;
  final bool readOnly;

  @override
  State<CharacterTypeSelector> createState() => _CharacterTypeSelectorState();
}

class _CharacterTypeSelectorState extends State<CharacterTypeSelector> {
  Widget _icon(CharacterType type) => switch (type) {
    CharacterType.Player => Icon(Icons.person, color: Colors.blue),
    CharacterType.FriendlyNPC => Icon(Icons.person_outline, color: Colors.green),
    CharacterType.UnknownNPC => Icon(Icons.person_outline, color: Colors.amber),
    CharacterType.Enemy => Icon(Icons.shield_outlined, color: Colors.red),
    _ => Container(),
  };

  String _name(CharacterType type) => switch (type) {
    CharacterType.Player => "Player Character",
    CharacterType.Enemy => "Enemy",
    CharacterType.FriendlyNPC => "Friendly NPC",
    CharacterType.UnknownNPC => "Unknown NPC",
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
      child: Row(mainAxisSize: MainAxisSize.min, children: [_icon(type), Gap(8.0), Text(_name(type))]),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return widget.character.type == CharacterType.Player || widget.readOnly
        ? _icon(widget.character.type)
        : MenuAnchor(
            menuChildren: [_menuEntry(CharacterType.Enemy), _menuEntry(CharacterType.FriendlyNPC), _menuEntry(CharacterType.UnknownNPC)],
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
