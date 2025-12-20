import 'package:combat_tracker/datamodel/character.pb.dart';
import 'package:combat_tracker/datamodel/extension/character_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CharacterInitiativeField extends StatefulWidget {
  const CharacterInitiativeField({
    super.key,
    required this.character,
    this.changed,
  });

  final Character character;
  final Function()? changed;

  @override
  State<CharacterInitiativeField> createState() =>
      _CharacterInitiativeFieldState();
}

class _CharacterInitiativeFieldState extends State<CharacterInitiativeField> {
  late TextEditingController controller;
  late String textValue;
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    textValue = widget.character.initiativeString;
    controller = TextEditingController(text: textValue);

    focusNode.addListener(() {
      if (!focusNode.hasFocus) {
        valueChanged();
      }
    });

    super.initState();
  }

  void valueChanged() {
    if (controller.text == textValue) {
      return;
    }

    textValue = controller.text;
    var doubleValue = double.tryParse(textValue);
    if (doubleValue != null) {
      if (textValue.startsWith(RegExp(r'[\-+]'))) {
        widget.character.initiativeDouble += doubleValue;
      } else {
        widget.character.initiativeDouble = doubleValue;
      }
    }

    textValue = widget.character.initiativeString;
    controller.text = textValue;
    widget.changed?.call();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onEditingComplete: () {
        focusNode.unfocus();
        valueChanged();
      },
      keyboardType: TextInputType.numberWithOptions(
        signed: true,
        decimal: false,
      ),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9\-+\.]')),
      ],
      decoration: InputDecoration(border: InputBorder.none),
      textAlign: TextAlign.center,
      onTap: () => controller.selection = TextSelection(
        baseOffset: 0,
        extentOffset: controller.value.text.length,
      ),
      focusNode: focusNode,
    );
  }
}
