import 'package:combat_tracker/combat/combat_table.dart';
import 'package:combat_tracker/datamodel/combat.pb.dart';
import 'package:flutter/material.dart';

class CombatPage extends StatelessWidget {
  const CombatPage({super.key, required this.combat});

  final Combat combat;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(combat.name)),
      body: CombatTable(combat: combat),
    );
  }
}
