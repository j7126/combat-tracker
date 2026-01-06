import 'package:combat_tracker/campaign_manager.dart';
import 'package:combat_tracker/characters/character_editor.dart';
import 'package:combat_tracker/datamodel/extension/player_character_extension.dart';
import 'package:combat_tracker/datamodel/player_character.pb.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CharacterTable extends StatefulWidget {
  const CharacterTable({super.key});

  @override
  State<CharacterTable> createState() => _CharacterTableState();
}

class _CharacterTableState extends State<CharacterTable> {
  void editCharacter(PlayerCharacter playerCharacter) async {
    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return CharacterEditor(character: playerCharacter);
      },
    );
    if (mounted) {
      setState(() {});
      CampaignManager.instance.saveCampaign();
    }
  }

  void deleteCharacter(PlayerCharacter playerCharacter) async {
    var shouldDelete = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: playerCharacter.name.isEmpty
              ? Text('Are you sure you want to delete unnamed character?\nThis cannot be undone.')
              : Text('Are you sure you want to delete character "${playerCharacter.name}"?\nThis cannot be undone.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: const Text('Delete', style: TextStyle(color: Colors.redAccent)),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
    if (mounted && shouldDelete == true) {
      setState(() {
        CampaignManager.instance.campaign!.characters.removeWhere((x) => x.id == playerCharacter.id);
      });
      CampaignManager.instance.saveCampaign();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              Text("Characters", style: TextTheme.of(context).titleMedium),
              Spacer(),
              IconButton(
                onPressed: () {
                  var character = PlayerCharacterExtension.createCharacter();
                  setState(() {
                    CampaignManager.instance.campaign!.characters.add(character);
                  });
                  editCharacter(character);
                },
                icon: Icon(Icons.add),
              ),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (var playerCharacter in CampaignManager.instance.campaign!.characters)
                  Card(
                    clipBehavior: Clip.hardEdge,
                    child: InkWell(
                      onTap: () => editCharacter(playerCharacter),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Icon(Icons.person, color: Colors.blue),
                          ),
                          Expanded(child: Text(playerCharacter.name, style: TextTheme.of(context).bodyMedium?.copyWith(fontSize: 18))),
                          Gap(4.0),
                          IconButton(
                            onPressed: () => deleteCharacter(playerCharacter),
                            icon: Icon(Icons.delete_outline, color: Colors.redAccent),
                          ),
                          Gap(8.0),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
