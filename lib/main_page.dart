import 'package:combat_tracker/table/combat_table.dart';
import 'package:combat_tracker/datamodel/combat.pb.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Combat combat = Combat();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: CombatTable(combat: combat));
  }
}
