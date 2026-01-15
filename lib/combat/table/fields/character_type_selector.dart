import 'package:combat_tracker/datamodel/extension/character_type_extension.dart';
import 'package:combat_tracker/datamodel/generated/character.pb.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CharacterTypeSelector extends StatefulWidget {
  const CharacterTypeSelector({
    super.key,
    required this.character,
    this.changed,
    this.readOnly = false,
  });

  final Character character;
  final Function()? changed;
  final bool readOnly;

  @override
  State<CharacterTypeSelector> createState() => _CharacterTypeSelectorState();
}

class _CharacterTypeSelectorState extends State<CharacterTypeSelector> {
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
        children: [type.getIcon(), Gap(8.0), Text(type.getName())],
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return widget.character.type == CharacterType.Player || widget.readOnly
        ? widget.character.type.getIcon()
        : MenuAnchor(
            menuChildren: [
              _menuEntry(CharacterType.Enemy),
              _menuEntry(CharacterType.FriendlyNPC),
              _menuEntry(CharacterType.UnknownNPC),
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
                icon: widget.character.type.getIcon(),
              );
            },
          );
  }
}
