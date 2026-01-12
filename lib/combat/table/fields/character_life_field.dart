import 'package:combat_tracker/datamodel/generated/character.pb.dart';
import 'package:combat_tracker/datamodel/generated/combat.pb.dart';
import 'package:combat_tracker/datamodel/extension/character_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CharacterLifeField extends StatefulWidget {
  const CharacterLifeField({
    super.key,
    required this.combat,
    required this.character,
    this.changed,
  });

  final Combat combat;
  final Character character;
  final Function()? changed;

  @override
  State<CharacterLifeField> createState() => _CharacterLifeFieldState();
}

class _CharacterLifeFieldState extends State<CharacterLifeField> {
  late TextEditingController lifeController;
  late String lifeString;
  late TextEditingController maxLifeController;
  late String maxLifeString;

  FocusNode lifeFocusNode = FocusNode();
  FocusNode maxLifeFocusNode = FocusNode();

  @override
  void initState() {
    lifeString = widget.character.life.toString();
    lifeController = TextEditingController(text: lifeString);
    maxLifeString = widget.character.maxLife.toString();
    maxLifeController = TextEditingController(text: maxLifeString);

    lifeFocusNode.addListener(() {
      if (!lifeFocusNode.hasFocus) {
        lifeValueChanged();
      }
    });

    maxLifeFocusNode.addListener(() {
      if (!maxLifeFocusNode.hasFocus) {
        maxLifeValueChanged();
      }
    });

    super.initState();
  }

  void lifeValueChanged() {
    if (lifeController.text == lifeString) {
      return;
    }

    lifeString = lifeController.text;
    var intValue = int.tryParse(lifeString);
    if (intValue != null) {
      if (lifeString.startsWith(RegExp(r'[\-+]'))) {
        widget.character.setLifeWithTrackedDamage(
          widget.character.life + intValue,
          widget.combat.activePlayer,
        );
      } else {
        widget.character.setLifeWithTrackedDamage(
          intValue,
          widget.combat.activePlayer,
        );
      }
    }

    lifeString = widget.character.life.toString();
    lifeController.text = lifeString;
    widget.changed?.call();
  }

  void maxLifeValueChanged() {
    if (maxLifeController.text == maxLifeString) {
      return;
    }

    var fromZero = widget.character.life == 0 && widget.character.maxLife == 0;

    maxLifeString = maxLifeController.text;
    var intValue = int.tryParse(maxLifeString);
    if (intValue != null) {
      if (maxLifeString.startsWith(RegExp(r'[\-+]'))) {
        widget.character.maxLife += intValue;
      } else {
        widget.character.maxLife = intValue;
      }
    }

    if (fromZero && widget.character.maxLife > 0) {
      widget.character.life = widget.character.maxLife;
      lifeString = widget.character.life.toString();
      lifeController.text = lifeString;
    }

    maxLifeString = widget.character.maxLife.toString();
    maxLifeController.text = maxLifeString;
    widget.changed?.call();
  }

  @override
  Widget build(BuildContext context) {
    var lifeCurrent = int.tryParse(lifeString);
    if (lifeCurrent != null && lifeCurrent != widget.character.life) {
      lifeString = widget.character.life.toString();
      lifeController.text = widget.character.life.toString();
    }
    var maxLifeCurrent = int.tryParse(maxLifeString);
    if (maxLifeCurrent != null && maxLifeCurrent != widget.character.maxLife) {
      maxLifeString = widget.character.maxLife.toString();
      maxLifeController.text = widget.character.maxLife.toString();
    }

    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: TextField(
            controller: lifeController,
            onEditingComplete: () {
              lifeFocusNode.unfocus();
              lifeValueChanged();
            },
            keyboardType: TextInputType.numberWithOptions(
              signed: true,
              decimal: false,
            ),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9\-+]')),
            ],
            decoration: InputDecoration(border: InputBorder.none),
            textAlign: TextAlign.right,
            focusNode: lifeFocusNode,
            onTap: () => lifeController.selection = TextSelection(
              baseOffset: 0,
              extentOffset: lifeController.value.text.length,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Text("/"),
        ),
        Expanded(
          child: TextField(
            controller: maxLifeController,
            onEditingComplete: () {
              maxLifeFocusNode.unfocus();
              maxLifeValueChanged();
            },
            keyboardType: TextInputType.numberWithOptions(
              signed: false,
              decimal: false,
            ),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9\-+]')),
            ],
            decoration: InputDecoration(border: InputBorder.none),
            focusNode: maxLifeFocusNode,
            onTap: () => maxLifeController.selection = TextSelection(
              baseOffset: 0,
              extentOffset: maxLifeController.value.text.length,
            ),
          ),
        ),
      ],
    );
  }
}
