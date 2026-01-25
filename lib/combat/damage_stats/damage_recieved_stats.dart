import 'dart:async';

import 'package:collection/collection.dart';
import 'package:combat_tracker/combat/table/fields/combat_type_selector.dart';
import 'package:combat_tracker/datamodel/generated/character.pb.dart';
import 'package:combat_tracker/datamodel/generated/combat.pb.dart';
import 'package:combat_tracker/util/time_util.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DamageRecievedStats extends StatefulWidget {
  const DamageRecievedStats({
    super.key,
    required this.combat,
    required this.character,
  });

  final Character character;
  final Combat combat;

  @override
  State<DamageRecievedStats> createState() => _DamageRecievedStatsState();
}

class _DamageRecievedStatsState extends State<DamageRecievedStats> {
  final Map<String, int> damageTotals = {};

  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 1), (t) {
      if (mounted) {
        setState(() {});
      } else {
        t.cancel();
      }
    });

    for (var event in widget.character.damageEvents) {
      if (event.source.isEmpty || event.change > 0) {
        continue;
      }
      var damage = damageTotals[event.source] ?? 0;
      damageTotals[event.source] = damage + event.change;
    }

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
                      "${widget.character.life} Life",
                      style: const TextStyle(
                        fontSize: 26,
                        height: 1,
                        color: Color.fromARGB(255, 178, 178, 178),
                      ),
                    ),
                  ),
                  if (widget.character.damageEvents.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 24.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 12.0,
                              right: 12.0,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  widget.character.damageEvents
                                      .where((x) => x.change < 0)
                                      .map((x) => x.change)
                                      .sum
                                      .abs()
                                      .toString(),
                                  style: const TextStyle(
                                    fontSize: 24,
                                    height: 1,
                                    color: Color.fromARGB(255, 178, 178, 178),
                                  ),
                                ),
                                Text(
                                  "Life Lost",
                                  style: const TextStyle(
                                    fontSize: 12,
                                    height: 1,
                                    color: Color.fromARGB(255, 178, 178, 178),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 12.0,
                              right: 12.0,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  widget.character.damageEvents
                                      .where((x) => x.change > 0)
                                      .map((x) => x.change)
                                      .sum
                                      .abs()
                                      .toString(),
                                  style: const TextStyle(
                                    fontSize: 24,
                                    height: 1,
                                    color: Color.fromARGB(255, 178, 178, 178),
                                  ),
                                ),
                                Text(
                                  "Life Gained",
                                  style: const TextStyle(
                                    fontSize: 12,
                                    height: 1,
                                    color: Color.fromARGB(255, 178, 178, 178),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  for (var entry in damageTotals.entries.sortedBy(
                    (x) => x.value,
                  ))
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
                                  " total damage by",
                                  style: const TextStyle(fontSize: 18),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CombatTypeSelector(
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
                      "Recieved Damage History",
                      style: const TextStyle(
                        fontSize: 26,
                        height: 1,
                        color: Color.fromARGB(255, 178, 178, 178),
                      ),
                    ),
                  ),
                  if (widget.character.damageEvents.isEmpty)
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
                  for (var event in widget.character.damageEvents.reversed)
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
                                      "${event.change > 0 ? "+" : ""}${event.change.toString()}",
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
                                    if (event.change > 0) {
                                      return Text(
                                        "Life Gain",
                                        style: const TextStyle(fontSize: 18),
                                      );
                                    }
                                    var sourceCharacter = event.source.isEmpty
                                        ? null
                                        : widget.combat.characters
                                              .firstWhereOrNull(
                                                (x) => x.id == event.source,
                                              );
                                    return sourceCharacter == null
                                        ? Text(
                                            "Damage",
                                            style: const TextStyle(
                                              fontSize: 18,
                                            ),
                                          )
                                        : Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                "Damaged by ",
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                ),
                                              ),
                                              Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  CombatTypeSelector(
                                                    character: sourceCharacter,
                                                    readOnly: true,
                                                  ),
                                                  Text(
                                                    sourceCharacter.name,
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
                                    "${TimeUtil.timeDiffString(event.timestamp.toDateTime().toLocal())} ago",
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            Icon(Icons.arrow_forward),
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
                                      (event.previousLife + event.change)
                                          .toString(),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  if (widget.character.damageEvents.isNotEmpty)
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
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.surface,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: Icon(Icons.flag),
                                  ),
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: Text(
                                "Game Start",
                                style: TextStyle(fontSize: 24),
                              ),
                            ),
                            Spacer(),
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
                                      (widget.character.maxLife).toString(),
                                    ),
                                  ),
                                ),
                              ),
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
