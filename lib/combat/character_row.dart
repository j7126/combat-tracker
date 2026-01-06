import 'package:combat_tracker/datamodel/character.pb.dart';
import 'package:combat_tracker/datamodel/combat.pb.dart';
import 'package:combat_tracker/combat/character_initiative_field.dart';
import 'package:combat_tracker/combat/character_life_field.dart';
import 'package:combat_tracker/combat/character_name_field.dart';
import 'package:combat_tracker/combat/character_type_selector.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CharacterRow extends StatefulWidget {
  const CharacterRow({
    super.key,
    required this.combat,
    required this.character,
    this.showDelete = false,
    this.onDelete,
    this.changed,
  });

  final Combat combat;
  final Character character;
  final bool showDelete;
  final Function()? onDelete;
  final Function()? changed;

  @override
  State<CharacterRow> createState() => _CharacterRowState();
}

class _CharacterRowState extends State<CharacterRow> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (value) {
        setState(() {
          _hovering = true;
        });
      },
      onExit: (value) {
        setState(() {
          _hovering = false;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: _hovering
              ? ColorScheme.of(context).surfaceContainer
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: SizedBox(
          height: 48,
          child: Row(
            children: [
              Gap(4.0),
              SizedBox(
                width: 40,
                child: CharacterTypeSelector(
                  character: widget.character,
                  changed: widget.changed,
                ),
              ),
              VerticalDivider(),
              SizedBox(
                width: 48,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: CharacterInitiativeField(
                    character: widget.character,
                    changed: widget.changed,
                  ),
                ),
              ),
              VerticalDivider(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: CharacterNameField(
                    character: widget.character,
                    changed: widget.changed,
                  ),
                ),
              ),
              VerticalDivider(),
              SizedBox(
                width: 100,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: CharacterLifeField(
                    combat: widget.combat,
                    character: widget.character,
                    changed: widget.changed,
                  ),
                ),
              ),
              if (widget.showDelete) VerticalDivider(),
              AnimatedSize(
                duration: Duration(milliseconds: 120),
                child: SizedBox(
                  width: widget.showDelete ? 64 : 0,
                  child: Opacity(
                    opacity: widget.showDelete ? 1 : 0,
                    child: IconButton(
                      onPressed: widget.onDelete,
                      icon: Icon(Icons.delete_outline),
                      color: ColorScheme.of(context).error,
                    ),
                  ),
                ),
              ),
              Gap(4.0),
            ],
          ),
        ),
      ),
    );
  }
}
