import 'dart:async';

import 'package:collection/collection.dart';
import 'package:combat_tracker/combat/table/fields/character_type_selector.dart';
import 'package:combat_tracker/datamodel/character.pb.dart';
import 'package:combat_tracker/datamodel/combat.pb.dart';
import 'package:combat_tracker/datamodel/damage_event.pb.dart';
import 'package:combat_tracker/util/time_util.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DamageDealtStats extends StatefulWidget {
  const DamageDealtStats({
    super.key,
    required this.combat,
    required this.character,
  });

  final Character character;
  final Combat combat;

  @override
  State<DamageDealtStats> createState() => _DamageDealtStatsState();
}

class _DamageDealtStatsState extends State<DamageDealtStats> {
  final Map<String, int> damageTotals = {};
  final List<(DamageEvent event, String characterId)> damageEvents = [];
  late int totalDamage;

  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 1), (t) {
      if (mounted) {
        setState(() {});
      } else {
        t.cancel();
      }
    });

    for (var character in widget.combat.characters) {
      for (var event in character.damageEvents) {
        if (event.source.isEmpty ||
            event.change > 0 ||
            event.source != widget.character.id) {
          continue;
        }
        damageEvents.add((event, character.id));
        var damage = damageTotals[character.id] ?? 0;
        damageTotals[character.id] = damage + event.change * -1;
      }
    }
    totalDamage = damageTotals.values.sum;
    damageEvents.sortBy((x) => x.$1.timestamp.toDateTime());

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 16.0,
                      top: 16.0,
                      left: 12.0,
                      right: 12.0,
                    ),
                    child: Text(
                      "$totalDamage Dealt",
                      style: const TextStyle(
                        fontSize: 26,
                        height: 1,
                        color: Color.fromARGB(255, 178, 178, 178),
                      ),
                    ),
                  ),
                  for (var entry
                      in damageTotals.entries.sortedBy((x) => x.value).reversed)
                    () {
                      var sourceCharacter = widget.combat.characters.firstWhere(
                        (x) => x.id == entry.key,
                      );
                      return SizedBox(
                        width: double.infinity,
                        height: 64.0,
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  entry.value.toString(),
                                  style: const TextStyle(fontSize: 22),
                                ),
                                Text(
                                  " total damage to",
                                  style: const TextStyle(fontSize: 18),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CharacterTypeSelector(
                                      character: sourceCharacter,
                                      readOnly: true,
                                    ),
                                    Text(
                                      sourceCharacter.name,
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }(),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 16.0,
                      top: 16.0,
                      left: 12.0,
                      right: 12.0,
                    ),
                    child: Text(
                      "Dealt Damage History",
                      style: const TextStyle(
                        fontSize: 26,
                        height: 1,
                        color: Color.fromARGB(255, 178, 178, 178),
                      ),
                    ),
                  ),
                  if (damageEvents.isEmpty)
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 16.0,
                        right: 16.0,
                        bottom: 24.0,
                        top: 12.0,
                      ),
                      child: Row(
                        children: [
                          const Spacer(),
                          const Icon(
                            Icons.history,
                            size: 34,
                            color: Color.fromARGB(255, 127, 127, 127),
                          ),
                          const Gap(8.0),
                          Text(
                            "No history",
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                  color: const Color.fromARGB(
                                    255,
                                    127,
                                    127,
                                    127,
                                  ),
                                ),
                            textAlign: TextAlign.center,
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  for (var event in damageEvents.reversed)
                    Card(
                      child: SizedBox(
                        height: 64,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 48,
                                height: 48,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.surface,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: Text(
                                      (event.$1.change * -1).toString(),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: () {
                                    var targetCharacter = widget
                                        .combat
                                        .characters
                                        .firstWhere(
                                          (x) => x.id == event.$2,
                                        );
                                    return Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          "Damage to ",
                                          style: const TextStyle(fontSize: 18),
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            CharacterTypeSelector(
                                              character: targetCharacter,
                                              readOnly: true,
                                            ),
                                            Text(
                                              targetCharacter.name,
                                              style: const TextStyle(
                                                fontSize: 20,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    );
                                  }(),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Text(
                                    "${TimeUtil.timeDiffString(event.$1.timestamp.toDateTime().toLocal())} ago",
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
