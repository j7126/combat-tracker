import 'package:combat_tracker/datamodel/extension/character_extension.dart';
import 'package:combat_tracker/datamodel/extension/character_type_extension.dart';
import 'package:combat_tracker/datamodel/generated/character.pb.dart';
import 'package:combat_tracker/datamodel/generated/combat.pb.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CharacterOptionsDialog extends StatefulWidget {
  const CharacterOptionsDialog({
    super.key,
    required this.combat,
    required this.character,
  });

  final Character character;
  final Combat combat;

  @override
  State<CharacterOptionsDialog> createState() =>
      _CharacterOptionsDialogDialogState();
}

class _CharacterOptionsDialogDialogState extends State<CharacterOptionsDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(
        horizontal: 40.0,
        vertical: 64.0,
      ),
      titlePadding: const EdgeInsets.only(top: 12.0, left: 18.0, right: 16.0),
      contentPadding: EdgeInsets.zero,
      title: Row(
        children: [
          const Text("Character Options"),
          Gap(12),
          widget.character.type.getIcon(),
          Gap(4),
          Text(widget.character.name),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.6,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.character.enableDead =
                            !widget.character.enableDead;
                      });
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Card(
                      elevation: 0,
                      margin: EdgeInsets.zero,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 8.0,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Enable Death",
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleMedium,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                  Text(
                                    "Consider this character dead when they have 0 or less life",
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodySmall,
                                  ),
                                ],
                              ),
                            ),
                            const Gap(4.0),
                            Switch(
                              value: widget.character.enableDead,
                              onChanged: (bool value) {
                                setState(() {
                                  widget.character.enableDead = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
