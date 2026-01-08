import 'package:combat_tracker/datamodel/player_character.pb.dart';
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
  late TextEditingController lifeController;
  late TextEditingController maxLifeController;

  @override
  void initState() {
    nameController = TextEditingController(text: widget.character.name);
    maxLifeController = TextEditingController(text: widget.character.maxLife.toString());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16),
        child: Container(
          constraints: BoxConstraints(maxWidth: 500),
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
              TextField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(labelText: "Notes"),
              ),
              Gap(8.0),
            ],
          ),
        ),
      ),
    );
  }
}
