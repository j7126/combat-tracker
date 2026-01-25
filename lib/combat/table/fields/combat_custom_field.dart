import 'package:combat_tracker/datamodel/generated/character.pb.dart';
import 'package:combat_tracker/datamodel/generated/custom_field.pb.dart';
import 'package:flutter/material.dart';

class CombatCustomField extends StatefulWidget {
  const CombatCustomField({super.key, required this.character, required this.field, this.changed});

  final Character character;
  final CustomField field;
  final Function()? changed;

  @override
  State<CombatCustomField> createState() => _CombatCustomFieldState();
}

class _CombatCustomFieldState extends State<CombatCustomField> {
  late TextEditingController controller;

  @override
  void initState() {
    if (!widget.character.customFieldValues.containsKey(widget.field.id)) {
      widget.character.customFieldValues[widget.field.id] = "";
    }
    controller = TextEditingController(text: widget.character.customFieldValues[widget.field.id]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: (value) {
        widget.character.customFieldValues[widget.field.id] = value;
        widget.changed?.call();
      },
      decoration: InputDecoration(border: InputBorder.none, hintText: widget.field.shortName),
    );
  }
}
