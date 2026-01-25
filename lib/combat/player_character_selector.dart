import 'dart:collection';

import 'package:combat_tracker/campaign_manager.dart';
import 'package:combat_tracker/datamodel/generated/character.pb.dart';
import 'package:combat_tracker/datamodel/generated/combat.pb.dart';
import 'package:combat_tracker/datamodel/generated/player_character.pb.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class PlayerCharacterSelector extends StatefulWidget {
  const PlayerCharacterSelector({super.key, required this.combat});

  final Combat combat;

  @override
  State<PlayerCharacterSelector> createState() => _PlayerCharacterSelectorState();
}

class _PlayerCharacterSelectorState extends State<PlayerCharacterSelector> {
  HashSet<String> selectedIds = HashSet<String>();

  void checkedChanged(PlayerCharacter playerCharacter, bool value) {
    setState(() {
      if (value) {
        selectedIds.add(playerCharacter.id);
        if (!widget.combat.characters.any((x) => x.id == playerCharacter.id)) {
          var character = Character(
            id: playerCharacter.id,
            type: CharacterType.Player,
            damageEvents: [],
            life: playerCharacter.maxLife,
            maxLife: playerCharacter.maxLife,
            name: playerCharacter.name,
            customFieldValues: playerCharacter.customFieldValues.entries,
          );
          widget.combat.characters.add(character);
        }
      } else {
        selectedIds.remove(playerCharacter.id);
        widget.combat.characters.removeWhere((x) => x.id == playerCharacter.id);
      }
    });
  }

  @override
  void initState() {
    for (var playerCharacter in CampaignManager.instance.campaign!.characters) {
      if (widget.combat.characters.any((x) => x.id == playerCharacter.id)) {
        selectedIds.add(playerCharacter.id);
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Gap(4.0),
          GestureDetector(
            onTap: () {
              var val = selectedIds.isEmpty;
              for (var playerCharacter in CampaignManager.instance.campaign!.characters) {
                checkedChanged(playerCharacter, val);
              }
            },
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Gap(4.0),
                Checkbox(
                  tristate: true,
                  value: selectedIds.isNotEmpty
                      ? selectedIds.length == CampaignManager.instance.campaign!.characters.length
                            ? true
                            : null
                      : false,
                  onChanged: (value) {
                    for (var playerCharacter in CampaignManager.instance.campaign!.characters) {
                      checkedChanged(playerCharacter, value == true);
                    }
                  },
                ),
                Gap(16.0),
                Expanded(child: Text("Select All", style: TextTheme.of(context).bodyMedium?.copyWith(fontSize: 18))),
                Gap(4.0),
              ],
            ),
          ),
          for (var playerCharacter in CampaignManager.instance.campaign!.characters)
            GestureDetector(
              onTap: () => checkedChanged(playerCharacter, !selectedIds.contains(playerCharacter.id)),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Gap(4.0),
                  Checkbox(value: selectedIds.contains(playerCharacter.id), onChanged: (value) => checkedChanged(playerCharacter, value ?? false)),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Icon(Icons.person, color: Colors.blue),
                  ),
                  Expanded(child: Text(playerCharacter.name, style: TextTheme.of(context).bodyMedium?.copyWith(fontSize: 18))),
                  Gap(4.0),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
