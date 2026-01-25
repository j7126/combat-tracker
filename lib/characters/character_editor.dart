import 'package:combat_tracker/campaign_manager.dart';
import 'package:combat_tracker/characters/character_custom_field.dart';
import 'package:combat_tracker/datamodel/extension/custom_field_extension.dart';
import 'package:combat_tracker/datamodel/generated/player_character.pb.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';

class CharacterEditor extends StatefulWidget {
  const CharacterEditor({super.key, required this.character});

  final PlayerCharacter character;

  @override
  State<CharacterEditor> createState() => _CharacterEditorState();
}

class _CharacterEditorState extends State<CharacterEditor> {
  late TextEditingController nameController;
  late TextEditingController maxLifeController;
  late TextEditingController notesController;

  @override
  void initState() {
    nameController = TextEditingController(text: widget.character.name);
    maxLifeController = TextEditingController(text: widget.character.maxLife.toString());
    notesController = TextEditingController(text: widget.character.notes);
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    maxLifeController.dispose();
    notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16),
        child: Container(
          constraints: BoxConstraints(maxWidth: 600),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text("Edit Character", style: TextTheme.of(context).headlineSmall, textAlign: TextAlign.center),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close),
                  ),
                ],
              ),
              Gap(8.0),
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextField(
                        controller: nameController,
                        onChanged: (value) {
                          widget.character.name = value;
                        },
                        decoration: InputDecoration(labelText: "Name"),
                      ),
                      Gap(8.0),
                      TextField(
                        controller: maxLifeController,
                        onChanged: (value) {
                          var intValue = int.tryParse(value);
                          if (intValue != null) {
                            widget.character.maxLife = intValue;
                          }
                        },
                        keyboardType: TextInputType.numberWithOptions(signed: true, decimal: false),
                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9\-+]'))],
                        decoration: InputDecoration(labelText: "Max Life"),
                        onTap: () => maxLifeController.selection = TextSelection(baseOffset: 0, extentOffset: maxLifeController.value.text.length),
                      ),
                      Gap(8.0),
                      for (var field in CampaignManager.instance.campaign!.options.customFields.where((x) => x.enabledCharacter && x.isValid))
                        CharacterCustomField(character: widget.character, field: field),
                      Gap(8.0),
                      TextField(
                        controller: notesController,
                        onChanged: (val) => widget.character.notes = val,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(labelText: "Notes"),
                      ),
                    ],
                  ),
                ),
              ),
              Gap(8.0),
            ],
          ),
        ),
      ),
    );
  }
}
