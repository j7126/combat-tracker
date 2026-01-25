import 'package:combat_tracker/datamodel/generated/custom_field.pb.dart';
import 'package:combat_tracker/datamodel/generated/player_character.pb.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CharacterCustomField extends StatefulWidget {
  const CharacterCustomField({
    super.key,
    required this.character,
    required this.field,
  });

  final PlayerCharacter character;
  final CustomField field;

  @override
  State<CharacterCustomField> createState() => _CharacterCustomFieldState();
}

class _CharacterCustomFieldState extends State<CharacterCustomField> {
  late TextEditingController controller;

  @override
  void initState() {
    if (!widget.character.customFieldValues.containsKey(widget.field.id)) {
      widget.character.customFieldValues[widget.field.id] = "";
    }
    controller = TextEditingController(
      text: widget.character.customFieldValues[widget.field.id],
    );
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: (value) {
        if (widget.field.type == CustomFieldType.Numeric) {
          var intValue = int.tryParse(value) ?? 0;
          value = intValue.toString();
        }
        widget.character.customFieldValues[widget.field.id] = value;
      },
      decoration: InputDecoration(labelText: widget.field.name),
      keyboardType: widget.field.type == CustomFieldType.Numeric
          ? TextInputType.numberWithOptions(signed: true, decimal: false)
          : null,
      inputFormatters: widget.field.type == CustomFieldType.Numeric
          ? [FilteringTextInputFormatter.allow(RegExp(r'[0-9\-+]'))]
          : null,
    );
  }
}
