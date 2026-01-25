import 'package:combat_tracker/combat/damage_stats/damage_dealt_stats.dart';
import 'package:combat_tracker/combat/damage_stats/damage_recieved_stats.dart';
import 'package:combat_tracker/datamodel/generated/character.pb.dart';
import 'package:combat_tracker/datamodel/generated/combat.pb.dart';
import 'package:flutter/material.dart';

class DamageStatsDialog extends StatefulWidget {
  const DamageStatsDialog({
    super.key,
    required this.combat,
    required this.character,
  });

  final Character character;
  final Combat combat;

  @override
  State<DamageStatsDialog> createState() => _DamageStatsDialogDialogState();
}

class _DamageStatsDialogDialogState extends State<DamageStatsDialog> {
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
          const Text("Damage Statistics"),
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
        width: MediaQuery.of(context).size.width * 0.8,
        child: DefaultTabController(
          length: 2,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              TabBar(
                tabs: [
                  Tab(child: Text("Damage Recieved")),
                  Tab(child: Text("Damage Dealt")),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0, top: 8.0),
                      child: DamageRecievedStats(
                        combat: widget.combat,
                        character: widget.character,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0, top: 8.0),
                      child: DamageDealtStats(
                        combat: widget.combat,
                        character: widget.character,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
