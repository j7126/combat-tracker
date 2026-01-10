import 'dart:async';

import 'package:collection/collection.dart';
import 'package:combat_tracker/datamodel/character.pb.dart';
import 'package:combat_tracker/datamodel/combat.pb.dart';
import 'package:combat_tracker/util/time_util.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DamageDealtStats extends StatefulWidget {
  const DamageDealtStats({super.key, required this.combat, required this.character});

  final Character character;
  final Combat combat;

  @override
  State<DamageDealtStats> createState() => _DamageDealtStatsState();
}

class _DamageDealtStatsState extends State<DamageDealtStats> {
  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 1), (t) {
      if (mounted) {
        setState(() {});
      } else {
        t.cancel();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 64.0),
      titlePadding: const EdgeInsets.only(top: 12.0, left: 18.0, right: 16.0),
      contentPadding: EdgeInsets.zero,
      title: Row(
        children: [
          const Text("Damage History"),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      content: Container(
        constraints: const BoxConstraints(minWidth: 320),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16.0, top: 8.0),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0, top: 16.0, left: 12.0, right: 12.0),
                    child: Text("${widget.character.life} Life", style: const TextStyle(fontSize: 26, height: 1, color: Color.fromARGB(255, 178, 178, 178))),
                  ),
                  if (widget.character.damageEvents.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 24.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  widget.character.damageEvents.where((x) => x.change < 0).map((x) => x.change).sum.abs().toString(),
                                  style: const TextStyle(fontSize: 24, height: 1, color: Color.fromARGB(255, 178, 178, 178)),
                                ),
                                Text("Life Lost", style: const TextStyle(fontSize: 12, height: 1, color: Color.fromARGB(255, 178, 178, 178))),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  widget.character.damageEvents.where((x) => x.change > 0).map((x) => x.change).sum.abs().toString(),
                                  style: const TextStyle(fontSize: 24, height: 1, color: Color.fromARGB(255, 178, 178, 178)),
                                ),
                                Text("Life Gained", style: const TextStyle(fontSize: 12, height: 1, color: Color.fromARGB(255, 178, 178, 178))),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (widget.character.damageEvents.isEmpty)
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 24.0, top: 12.0),
                      child: Row(
                        children: [
                          const Spacer(),
                          const Icon(Icons.history, size: 34, color: Color.fromARGB(255, 127, 127, 127)),
                          const Gap(8.0),
                          Text(
                            "No history",
                            style: Theme.of(
                              context,
                            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontSize: 24, color: const Color.fromARGB(255, 127, 127, 127)),
                            textAlign: TextAlign.center,
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  for (var event in widget.character.damageEvents.reversed) ...[
                    Card(
                      child: SizedBox(
                        height: 80,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 64,
                                height: 64,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface, borderRadius: BorderRadius.circular(8)),
                                child: Builder(
                                  builder: (context) {
                                    return Stack(
                                      children: [
                                        SizedBox(
                                          width: 64,
                                          height: 64,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: FittedBox(fit: BoxFit.contain, child: Text("${event.change > 0 ? "+" : ""}${event.change.toString()}")),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Text(event.change > 0 ? "Life Gain" : "Damage", style: const TextStyle(fontSize: 28)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Text(TimeUtil.timeDiffString(event.timestamp.toDateTime().toLocal()), style: const TextStyle(fontSize: 16)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: Container(
                              height: 2.0,
                              color: (DividerTheme.of(context).color ?? Theme.of(context).colorScheme.outlineVariant).withAlpha(127),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Text("${event.previousLife}", style: const TextStyle(fontSize: 18, height: 1, color: Color.fromARGB(255, 153, 153, 153))),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: Container(
                              height: 2.0,
                              color: (DividerTheme.of(context).color ?? Theme.of(context).colorScheme.outlineVariant).withAlpha(127),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                  if (widget.character.damageEvents.isNotEmpty)
                    Card(
                      child: SizedBox(
                        height: 80,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 64,
                                height: 64,
                                decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface, borderRadius: BorderRadius.circular(8)),
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: FittedBox(fit: BoxFit.contain, child: Icon(Icons.flag)),
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: Text("Game Start", style: TextStyle(fontSize: 28)),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
